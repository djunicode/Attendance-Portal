from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response 
from rest_framework.generics import GenericAPIView
from rest_framework import status
from .serializers import AttendanceSerializer, LectureSerializer, BatchSerializer
from .models import Attendance, Batch, Lecture

from django.core.exceptions import ObjectDoesNotExist
# Create your views here.

#----------------Lecture Views Here-------------------------
class LectureAPI(GenericAPIView):
    serializer_class = LectureSerializer
    queryset = Lecture.objects.all()
    def post(self, request):
        lecture = LectureSerializer(data = request.data)
        if not lecture.is_valid():
            return Response(data= {'error':lecture.errors}, status=status.HTTP_400_BAD_REQUEST)
        lecture.save()
        return Response(data = {'lecture_id': lecture.data['id']}, status=status.HTTP_201_CREATED)

#----------------Batch Views Here -------------------------

class BatchAPI(GenericAPIView):
    serializer_class = BatchSerializer
    queryset = Batch.objects.all()
    def post(self, request):
        data_dict={}
        for key in request.data:
            data_dict[key] =  request.data[key]
        data_dict['students'] = data_dict.get('students','[]').strip('][}{)(').split(',')
        batch = BatchSerializer(data=data_dict)
        if not batch.is_valid():
            return Response(data= {'error':batch.errors}, status=status.HTTP_400_BAD_REQUEST)
        batch.save()
        return Response(data = {'batch_id': batch.data['id']}, status=status.HTTP_201_CREATED)
    
#-------------Attendance Views---------------------------

class AttendanceAPI(GenericAPIView):
    serializer_class = AttendanceSerializer
    queryset = Attendance.objects.all()
    def post(self,request):
        instance = request.data
        for i in instance:
            try:
                instance1 = Attendance.objects.get(lecture = i['lecture'], student = i['student'])
                serializer = AttendanceSerializer(instance1,data = i)
                if serializer.is_valid():
                    serializer.save()
            except ObjectDoesNotExist:
                serializer = AttendanceSerializer(data = i)
                if serializer.is_valid():
                    serializer.save()
        lecture = Lecture.objects.get(id = instance[0]['lecture'])
        lecture.attendance_taken = True
        lecture.save()    
        return Response(data = {"message":"Attendance created successfully"} ,status=status.HTTP_201_CREATED)

    def patch(self, request):
        try:
            instance = Attendance.objects.get(lecture = request.data['lecture'], student = request.data['student'])
            serializer = AttendanceSerializer(instance,data = request.data)
            if serializer.is_valid():
                serializer.save()
        except ObjectDoesNotExist:
            serializer = AttendanceSerializer(data = request.data)
            if serializer.is_valid():
                serializer.save()
        return Response(data = {"message":"Student attendance updated successfully"} ,status=status.HTTP_202_ACCEPTED)


