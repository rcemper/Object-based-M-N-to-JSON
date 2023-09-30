Class JSONExportManyToMany.TeacherStudent Extends (%Persistent, %JSON.Adaptor)
{

Property ID As %Integer [ Identity ];

Property Teacher As JSONExportManyToMany.Teacher [ Calculated ];

Property Student As JSONExportManyToMany.Student [ Calculated ];

XData Student
{
<Mapping xmlns="http://www.intersystems.com/jsonmapping">
    <Property Name="ID"/>
    <Property Name="Teacher" />
  </Mapping>
}

XData Teacher
{
<Mapping xmlns="http://www.intersystems.com/jsonmapping">
    <Property Name="ID"/>
    <Property Name="Student" />
  </Mapping>
}

Method TeacherGet() As JSONExportManyToMany.Teacher
{
  Set tSQL="SELECT ID FROM JSONExportManyToMany.Teacher WHERE Students[?"
  Set tRS=##class(%SQL.Statement).%ExecDirect(,tSQL,i%ID)
  Set tSC=tRS.%Next()
  Set tID=tRS.%Get("ID")
  Set tTeacher=##class(JSONExportManyToMany.Teacher).%OpenId(tID)
  Quit tTeacher
}

Method StudentGet() As JSONExportManyToMany.Student
{
  Set tSQL="SELECT ID FROM JSONExportManyToMany.Student WHERE Teachers[?"
  Set tRS=##class(%SQL.Statement).%ExecDirect(,tSQL,i%ID)
  Set tSC=tRS.%Next()
  Set tID=tRS.ID
  Set tStudent=##class(JSONExportManyToMany.Student).%OpenId(tID)
  Quit tStudent
}

ClassMethod Populate()
{
  write ##class(JSONExportManyToMany.Student).%DeleteExtent()," > ",
    ##class(JSONExportManyToMany.Teacher).%DeleteExtent()," > ",
    ##class(JSONExportManyToMany.TeacherStudent).%DeleteExtent(),!
  set student1=##class(JSONExportManyToMany.Student).%New()
  set student2=##class(JSONExportManyToMany.Student).%New()
  set student1.Name="Peter"
  set student2.Name="Nael"
  set teacher1=##class(JSONExportManyToMany.Teacher).%New()
  set teacher2=##class(JSONExportManyToMany.Teacher).%New()
  set teacher3=##class(JSONExportManyToMany.Teacher).%New()
  set teacher1.Name="Teacher1Name"
  set teacher2.Name="Teacher2Name"
  set teacher3.Name="Teacher3Name"
  set ts1=##class(JSONExportManyToMany.TeacherStudent).%New()
  write ts1.%Save()," > "
  set ts2=##class(JSONExportManyToMany.TeacherStudent).%New()
  write ts2.%Save()," > "
  set ts3=##class(JSONExportManyToMany.TeacherStudent).%New()
  write ts3.%Save()," > "
  set ts4=##class(JSONExportManyToMany.TeacherStudent).%New()
  write ts4.%Save()," > ",!
  do student1.Teachers.Insert(ts1)
  do teacher1.Students.Insert(ts1)
  do student1.Teachers.Insert(ts2)
  do teacher2.Students.Insert(ts2)
  do student2.Teachers.Insert(ts3)
  do teacher1.Students.Insert(ts3)
  do student2.Teachers.Insert(ts4)
  do teacher3.Students.Insert(ts4)
  write student1.%Save()," > "
  write student2.%Save()," > "
  write teacher1.%Save()," > "
  write teacher2.%Save()," > "
  write teacher3.%Save()," > ",!
}

ClassMethod Test()
{
  set student1=##class(JSONExportManyToMany.Student).%OpenId(1)
  do student1.%JSONExportToString(.%rcc,"Student"),show

  set student2=##class(JSONExportManyToMany.Student).%OpenId(2)
  do student2.%JSONExportToString(.%rcc,"Student"),show
  
  set teacher1=##class(JSONExportManyToMany.Teacher).%OpenId(1)
  do teacher1.%JSONExportToString(.%rcc,"Teacher"),show
  
  set teacher2=##class(JSONExportManyToMany.Teacher).%OpenId(2)
  do teacher2.%JSONExportToString(.%rcc,"Teacher"),show
  
  set teacher3=##class(JSONExportManyToMany.Teacher).%OpenId(3)
  do teacher3.%JSONExportToString(.%rcc,"Teacher"),show
show
  write !!,%rcc,!!
  do ##class(%JSON.Formatter).%New().Format(%rcc)
  quit
}

Storage Default
{
<Data name="TeacherStudentDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
</Data>
<DataLocation>^JSONExportMBD32.TeacherStudentD</DataLocation>
<DefaultData>TeacherStudentDefaultData</DefaultData>
<ExtentSize>4</ExtentSize>
<IdLocation>^JSONExportMBD32.TeacherStudentD</IdLocation>
<IndexLocation>^JSONExportMBD32.TeacherStudentI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^JSONExportMBD32.TeacherStudentS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
