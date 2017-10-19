VERSION 5.00
Begin VB.Form FrmBellmanFord 
   Caption         =   "VB 6.0 implementation of Bellman Ford Algorithm"
   ClientHeight    =   8595
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   13140
   LinkTopic       =   "Form1"
   ScaleHeight     =   8595
   ScaleWidth      =   13140
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame1 
      Height          =   1215
      Left            =   720
      TabIndex        =   1
      Top             =   7320
      Width           =   11775
      Begin VB.CommandButton CmdCancel 
         Caption         =   "&Cancel"
         BeginProperty Font 
            Name            =   "Palatino Linotype"
            Size            =   20.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   735
         Left            =   8520
         TabIndex        =   4
         Top             =   360
         Width           =   3015
      End
      Begin VB.CommandButton CmdReset 
         Caption         =   "&Reset"
         BeginProperty Font 
            Name            =   "Palatino Linotype"
            Size            =   20.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   735
         Left            =   4560
         TabIndex        =   3
         Top             =   360
         Width           =   3015
      End
      Begin VB.CommandButton CmdStart 
         Caption         =   "&Start"
         BeginProperty Font 
            Name            =   "Palatino Linotype"
            Size            =   20.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   735
         Left            =   600
         TabIndex        =   2
         Top             =   360
         Width           =   3015
      End
   End
   Begin VB.TextBox TxtOutput 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   7095
      Left            =   120
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   0
      Top             =   120
      Width           =   12975
   End
End
Attribute VB_Name = "FrmBellmanford"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' A VB 6.0 -PROGRAMMING LANGUAGE IMPLEMENTATION OF BELLMAN FORD SHORTEST PATH ALGORITHM
Const MAXNODE = 10
Const INFINTY = 9999
    
    
   '*Procedure for finding the shortest path *
Private Sub FindShortestPath(ByRef Vertice() As String, ByRef Edge() As Integer, ByVal source As String, ByVal target As String, ByVal M As Integer)
    Dim souce As Integer, j As Integer, u As Integer, v As Integer, taget As Integer, w As Integer
    Const Nulll As Integer = -1
    Dim Distance() As Integer, predecessor() As Integer, S() As Integer
    Dim found As Boolean
    
    found = False
                
    '* Dynamically Allocate Array *
    ReDim Distance(M)
    ReDim predecessor(M)
    ReDim S(M)
               
    '* Verify source *
    For j = 1 To M
       If (source = Vertice(j)) Then
            souce = j
            found = True
            'break
       End If
    Next j

        If (found = False) Then
            TxtOutput.Text = TxtOutput.Text & vbCrLf & "Wrong Input! Source Node not found; No path found: "
            Return
        End If
             
          found = False
         '* Verify target *
        For j = 1 To M
           If (target = Vertice(j)) Then
                taget = j
                found = True
                'break
           End If
        Next j

        If (found = False) Then
            TxtOutput.Text = TxtOutput.Text & vbCrLf & "Wrong Input! Target Node not found; No path found: "
            Return
        End If
            
        
        
             
        For v = 1 To M
           If (v = souce) Then
             Distance(v) = 0 'distance from source to source
           Else
             Distance(v) = INFINTY  'unknown distance function from source to v
             
            End If
           predecessor(v) = Nulll 'previous node in optimal path initialization
        Next v
             
        '//step 2: relax edges repeatedly
             For i = 1 To M - 1
               For u = 1 To M
                   For v = 1 To M
                        w = Edge(u, v)
                       If ((Distance(u) + w) < (Distance(v))) Then
                            Distance(v) = Distance(u) + w
                            predecessor(v) = u
                       End If
                   Next v
                Next u
             Next i
             
             '//return distance[], predecessor[]
             TxtOutput.Text = TxtOutput.Text & vbCrLf & "Distance table: " & vbCrLf
             For v = 1 To M
                If (Distance(v) = INFINTY) Then
                    TxtOutput.Text = TxtOutput.Text & "INF    "
                Else
                   TxtOutput.Text = TxtOutput.Text & Distance(v) & "    "
                End If
             Next v
             
             TxtOutput.Text = TxtOutput.Text & vbCrLf & "Predecessor table: " & vbCrLf
             For v = 1 To M
             TxtOutput.Text = TxtOutput.Text & predecessor(v) & "    "
             Next v
             
             '//getting the shortest path
             j = 1
             u = taget
             While (predecessor(u) <> Nulll) '//construct the shortest path with a stack S
                 S(j) = u: j = j + 1            ' //Push the vertex onto the stack
                 u = predecessor(u)           ' //Traverse from target to source
             Wend
                 ' //display shortest path
                TxtOutput.Text = TxtOutput.Text & vbCrLf & vbCrLf & "Successful, A Path Found!!! \nThe Shortest Path between " + source + " and " + target + " is: " & vbCrLf + source + "--->"
                For v = j - 1 To 2 Step -1
                TxtOutput.Text = TxtOutput.Text & Vertice(S(v)) & "--->"
                Next v
                TxtOutput.Text = TxtOutput.Text & Vertice(S(1))
                TxtOutput.Text = TxtOutput.Text & vbCrLf & "The weight/cost of the shortest path between Node: " & source & " and Node: " & target & " is " & Distance(taget)
       
End Sub
    '*Procedure for reading Nodes *
Private Sub readNodes(ByRef Nodes() As String, ByVal M As Integer)
Dim j As Integer
  TxtOutput.Text = TxtOutput.Text & vbCrLf & "Read in the names of all Nodes/Vertices in the graph"
  MsgBox "Read in the names of all Nodes/Vertices in the graph", vbOKOnly, "Bellman Ford"
  ReDim Nodes(M)
  For j = 1 To M
      Nodes(j) = InputBox("Read in the names of Node/Vertex " & j & " : ", "Bellman Ford")
      Nodes(j) = Left$(Nodes(j), 1)
      TxtOutput.Text = TxtOutput.Text & vbCrLf & "Read in the names of Node/Vertex " & j & " : " & Nodes(j)
  Next j
  
End Sub
    '*Procedure for reading weight *
Private Sub readWeight(ByRef w() As Integer, ByRef Nodes() As String, ByVal n As Integer)
Dim j As Integer, i As Integer
  TxtOutput.Text = TxtOutput.Text & vbCrLf & "Read in the weights/costs of all edges between 2 Vertices in the graph"
  MsgBox "Read in the weights/costs of all edges between 2 Vertices in the graph:", vbOKOnly, "DIJKSTRA"
  For i = 1 To n
     For j = 1 To n
         w(i, j) = Val(InputBox("Read in the weight/cost of edge between Node " & Nodes(i) & " and Node " & Nodes(j) & ": ", "Dijkstra"))
         TxtOutput.Text = TxtOutput.Text & vbCrLf & "Read in the weight/cost of edge between Node " & Nodes(i) & " and Node " & Nodes(j) & ": " & w(i, j)
         If (w(i, j) = 0) Then w(i, j) = INFINTY
     Next j
  Next i
End Sub
    '*Procedure to generate Itemset *

    '* Procedure to display the itemset generated*
Private Sub DisplayWeight(ByRef w() As Integer, ByVal n As Integer)
Dim i  As Integer, j As Integer
    TxtOutput.Text = TxtOutput.Text & vbCrLf & "The weights/costs Table of all edges between 2 Vertices in the graph: "
    For i = 1 To n
        TxtOutput.Text = TxtOutput.Text & vbCrLf
        For j = 1 To n
            If (w(i, j) = INFINTY) Then
                TxtOutput.Text = TxtOutput.Text & "INF   "
            Else
                TxtOutput.Text = TxtOutput.Text & w(i, j) & "    "
            End If
        Next j
    Next i
  
    
End Sub
    
Private Sub CmdCancel_Click()
End
End Sub

Private Sub CmdReset_Click()
TxtOutput.Text = ""
CmdStart.Enabled = True
End Sub

Private Sub CmdStart_Click()
 '*Begin the main procedure for implementing Dijkstra Algorithm *
 
Dim Vertices() As String, Edges(MAXNODE, MAXNODE) As Integer

Dim noOfNodes As Integer, Ch As Integer, source As String * 1, target As String * 1
            
    TxtOutput.Text = TxtOutput.Text & "Welcome to VB 6.0 Program developed to implement Bellman Ford Algorithm:"
    TxtOutput.Text = TxtOutput.Text & vbCrLf & "......................................................................."
    TxtOutput.Text = TxtOutput.Text & vbCrLf & "Read in Number of Vertices/Nodes in Graph: "
    noOfNodes = Val(InputBox("Read in Number of Vertices/Nodes in Graph: ", "Bellman Ford"))
    TxtOutput.Text = TxtOutput.Text + Str(noOfNodes)
    If (noOfNodes <= 0 Or noOfNodes > MAXNODE) Then
       TxtOutput.Text = TxtOutput.Text & vbCrLf & "Wrong Input! Please, Read in correct digit from 1 to 10:"
            
    Else
       Call readNodes(Vertices, noOfNodes)
       Call readWeight(Edges, Vertices, noOfNodes)
       Call DisplayWeight(Edges, noOfNodes)
       TxtOutput.Text = TxtOutput.Text & vbCrLf & "Do you wish to find Shortest Path between two Vertices/Nodes in  the Graph: "
       TxtOutput.Text = TxtOutput.Text & vbCrLf & "Press 1 -> Yes"
       TxtOutput.Text = TxtOutput.Text & vbCrLf & "Press 0 or any other digit -> No"
       Ch = Val(InputBox("Press 1 -> Yes,  Press 0 or any other digit -> No", "Bellman Ford"))
       TxtOutput.Text = TxtOutput.Text & vbCrLf & Str(Ch)
       If (Ch = 1) Then
           TxtOutput.Text = TxtOutput.Text & vbCrLf & "Read in the Source Node/Vertex: "
           source = Left(InputBox("Read in the Source Node/Vertex: ", "Bellman Ford"), 1)
           TxtOutput.Text = TxtOutput.Text & vbCrLf & source
           TxtOutput.Text = TxtOutput.Text & vbCrLf & "Read in the Target Node/Vertex: "
           target = Left(InputBox("Read in the target Node/Vertex: ", "Bellman Ford"), 1)
           TxtOutput.Text = TxtOutput.Text & vbCrLf & target
           Call FindShortestPath(Vertices, Edges, source, target, noOfNodes)
                
       End If
    End If
    TxtOutput.Text = TxtOutput.Text & vbCrLf & "****** Press any Key to Continue ******"
CmdStart.Enabled = False
End Sub



