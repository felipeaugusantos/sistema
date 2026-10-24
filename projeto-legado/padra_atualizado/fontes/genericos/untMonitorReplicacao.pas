unit untMonitorReplicacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, UniClientDataSet, Uni, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient;

type
  TfrmMonitorReplicacao = class(TfrmPai)
    edtTmpAtu: TcxSpinEdit;
    Label1: TLabel;
    dbgEmpresasDBTableView1: TcxGridDBTableView;
    dbgEmpresasLevel1: TcxGridLevel;
    dbgEmpresas: TcxGrid;
    EMP_NOMEMP: TcxGridDBColumn;
    EMP_STAEXE: TcxGridDBColumn;
    EMP_STAGER: TcxGridDBColumn;
    EMP_STAENV: TcxGridDBColumn;
    EMP_STACON: TcxGridDBColumn;
    EMP_QTDREP: TcxGridDBColumn;
    EMP_QTDEXE: TcxGridDBColumn;
    cdsEmpresas: TUniClientDataSet;
    dtsEmpresas: TDataSource;
    cdsEmpresasEMP_NOMEMP: TStringField;
    cdsEmpresasEMP_NUM_IP: TStringField;
    cdsEmpresasEMP_STAEXE: TIntegerField;
    cdsEmpresasEMP_STAGER: TIntegerField;
    cdsEmpresasEMP_STAENV: TIntegerField;
    cdsEmpresasEMP_STACON: TIntegerField;
    cdsEmpresasEMP_QTDREP: TIntegerField;
    cdsEmpresasEMP_QTDEXE: TIntegerField;
    cdsEmpresasEMP_CODEMP: TStringField;
    tmrAtualizaTela: TTimer;
    cxEditRepository1: TcxEditRepository;
    Label4: TLabel;
    Shape4: TShape;
    Label3: TLabel;
    Shape3: TShape;
    EMP_CODEMP: TcxGridDBColumn;
    strngfldEmpresasEMP_MOTCON: TStringField;
    dbgEmpresasDBTableView1Column1: TcxGridDBColumn;
    shp1: TShape;
    lbl1: TLabel;
    cdsEmpresasEMP_NUMPOR: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure tmrAtualizaTelaTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EMP_STAEXECustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure EMP_STACONCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure edtTmpAtuExit(Sender: TObject);
    procedure edtTmpAtuKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    stlThreads: TStringList;
    procedure pIniciarThreadsEmpresas;
    procedure pStartarThreads;
    procedure pPararThreads;
    procedure pAtualizaGrid;
  public
    { Public declarations }
  end;


implementation

uses untFuncoesSimples, untThreadMonitorAutcom, System.UITypes;

{$R *.dfm}

{ TfrmMonitorReplicacao }

procedure TfrmMonitorReplicacao.edtTmpAtuExit(Sender: TObject);
  Var
    thrMonitor: TMonitorRep;
    intContador: Integer;
begin
  For intContador := 0 To stlThreads.Count-1 Do
  Begin
    thrMonitor := TMonitorRep(stlThreads.Objects[intContador]);
    thrMonitor.intTmpPar := StrToInt(edtTmpAtu.Text);
  End;
end;

procedure TfrmMonitorReplicacao.edtTmpAtuKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmMonitorReplicacao.EMP_STACONCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If AViewInfo.Value = '0' Then
  Begin
    ACanvas.Font.Color  := clGray;
    ACanvas.Brush.Color := clGray;
  End
  Else If AViewInfo.Value = '1' Then
  Begin
    ACanvas.Font.Color  := clGreen;
    ACanvas.Brush.Color := clGreen;
  End
  Else
  Begin
    ACanvas.Font.Color  := clWhite;
    ACanvas.Brush.Color := clWhite;
  End

end;

procedure TfrmMonitorReplicacao.EMP_STAEXECustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If AViewInfo.Value = '0' Then
  Begin
    ACanvas.Font.Color  := clYellow;
    ACanvas.Brush.Color := clYellow;
  End
  Else ACanvas.Font.Color := ACanvas.Brush.Color;
end;

procedure TfrmMonitorReplicacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pPararThreads;
  fAtuCfgSis('TMPMON', edtTmpAtu.Text);
end;

procedure TfrmMonitorReplicacao.FormCreate(Sender: TObject);
begin
  inherited;
  stlThreads := TStringList.Create;

  edtTmpAtu.Text := fCfgSisL('TMPMON');

  pIniciarThreadsEmpresas;
  pStartarThreads;

  tmrAtualizaTela.Interval := 500;
  tmrAtualizaTela.Enabled := True;
end;

procedure TfrmMonitorReplicacao.FormDestroy(Sender: TObject);
  Var
    thrMonitor: TMonitorRep;
    intContador: Integer;
begin
  inherited;
  For intContador := 0 To stlThreads.Count-1 Do
  Begin
    thrMonitor := TMonitorRep(stlThreads.Objects[intContador]);
    thrMonitor.Free;
  End;

  FreeAndNil(stlThreads);
end;

procedure TfrmMonitorReplicacao.pAtualizaGrid;
  Var
    thrMonitor: TMonitorRep;
    intContador: Integer;
begin
  For intContador := 0 To stlThreads.Count-1 Do
  Begin
    thrMonitor := TMonitorRep(stlThreads.Objects[intContador]);

    cdsEmpresas.Locate('EMP_CODEMP', thrMonitor.strCodEmp, []);
    cdsEmpresas.Edit;
    cdsEmpresas.FieldByName('EMP_STACON').AsInteger := thrMonitor.intStaCon;
    cdsEmpresas.FieldByName('EMP_MOTCON').AsString  := thrMonitor.strMotCon;
    cdsEmpresas.FieldByName('EMP_STAEXE').AsInteger := thrMonitor.intStaExe;
    cdsEmpresas.FieldByName('EMP_STAGER').AsInteger := thrMonitor.intStaGer;
    cdsEmpresas.FieldByName('EMP_STAENV').AsInteger := thrMonitor.intStaEnv;
    cdsEmpresas.FieldByName('EMP_QTDREP').AsInteger := thrMonitor.intQtdRep;
    cdsEmpresas.FieldByName('EMP_QTDEXE').AsInteger := thrMonitor.intQtdExe;
    cdsEmpresas.Post;
  End;

end;

procedure TfrmMonitorReplicacao.pIniciarThreadsEmpresas;
  Var
    qryEmp: TUniQuery;
    thrMonitor: TMonitorRep;
begin
  cdsEmpresas.CreateDataSet;
  
  qryEmp := fCriaQuery(Self);
  qryEmp.SQL.Add('SELECT EMP_CODEMP, EMP_NOMEMP, EMP_NUM_IP, IF(IFNULL(EMP_NUMPOR, 0) > 0, EMP_NUMPOR, 3306) AS EMP_NUMPOR');
  qryEmp.SQL.Add('FROM CADEMP');
//  qryEmp.SQL.Add('WHERE EMP_CODEMP = "001"');
  qryEmp.Open;

  While (Not qryEmp.Eof) Do
  Begin

    cdsEmpresas.Append;
    cdsEmpresas.FieldByName('EMP_CODEMP').AsString :=  qryEmp.FieldByName('EMP_CODEMP').AsString;
    cdsEmpresas.FieldByName('EMP_NOMEMP').AsString :=  qryEmp.FieldByName('EMP_NOMEMP').AsString;
    cdsEmpresas.FieldByName('EMP_NUM_IP').AsString :=  qryEmp.FieldByName('EMP_NUM_IP').AsString;
    cdsEmpresas.FieldByName('EMP_NUMPOR').AsInteger := qryEmp.FieldByName('EMP_NUMPOR').AsInteger;
    cdsEmpresas.FieldByName('EMP_STACON').AsInteger := -1;
    cdsEmpresas.FieldByName('EMP_MOTCON').AsString  := 'AINDA NÃO TENTOU CONECTAR';
    cdsEmpresas.FieldByName('EMP_STAEXE').AsInteger := 1;
    cdsEmpresas.FieldByName('EMP_STAGER').AsInteger := 1;
    cdsEmpresas.FieldByName('EMP_STAENV').AsInteger := 1;
    cdsEmpresas.FieldByName('EMP_QTDREP').AsInteger := 0;
    cdsEmpresas.FieldByName('EMP_QTDEXE').AsInteger := 0;
    cdsEmpresas.Post;

    thrMonitor := TMonitorRep.Create(cdsEmpresas.FieldByName('EMP_CODEMP').AsString,
                                     cdsEmpresas.FieldByName('EMP_NUM_IP').AsString,
                                     StrToIntDef(edtTmpAtu.Text, 5),
                                     cdsEmpresas.FieldByName('EMP_NUMPOR').AsInteger);
    stlThreads.AddObject(cdsEmpresas.FieldByName('EMP_CODEMP').AsString,
                         thrMonitor);

    qryEmp.Next;
  End;

  FreeAndNil(qryEmp);
end;

procedure TfrmMonitorReplicacao.pPararThreads;
  Var
    thrMonitor: TMonitorRep;
    intContador: Integer;
begin
  For intContador := 0 To stlThreads.Count-1 Do
  Begin
    thrMonitor := TMonitorRep(stlThreads.Objects[intContador]);
    thrMonitor.Terminate;
  End;

  For intContador := 0 To stlThreads.Count-1 Do
  Begin
    thrMonitor := TMonitorRep(stlThreads.Objects[intContador]);
    thrMonitor.WaitFor;
  End;
end;

procedure TfrmMonitorReplicacao.pStartarThreads;
  Var
    thrMonitor: TMonitorRep;
    intContador: Integer;
begin
  For intContador := 0 To stlThreads.Count-1 Do
  Begin
    thrMonitor := TMonitorRep(stlThreads.Objects[intContador]);
    thrMonitor.Start;
  End;
end;

procedure TfrmMonitorReplicacao.tmrAtualizaTelaTimer(Sender: TObject);
begin
  inherited;
  tmrAtualizaTela.Enabled := False;
  pAtualizaGrid;
  tmrAtualizaTela.Enabled := True;
end;

end.
