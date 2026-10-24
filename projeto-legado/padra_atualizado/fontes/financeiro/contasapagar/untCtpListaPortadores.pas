unit untCtpListaPortadores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  untFuncoesSimples, Aurelius.Bind.Dataset, untTMovBan, untTMovBanRepository,
  untTCadPag, untTCadPagRepository, System.Generics.Collections, UniClientDataSet, Datasnap.DBClient, Uni,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  Aurelius.Bind.BaseDataset;

type
  TfrmCtpListaPortadores = class(TfrmPai)
    cxDados: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    dtsDados: TDataSource;
    qryDados: TAureliusDataset;
    qryDadosFCTB_CODPOR: TStringField;
    qryDadosFCTB_NOMPOR: TStringField;
    qryDadosFCTB_VALLAN: TFloatField;
    colCodPor: TcxGridDBColumn;
    colNomPor: TcxGridDBColumn;
    colValor: TcxGridDBColumn;
    colCheques: TcxGridDBColumn;
    qryDadosCheques: TStringField;
    cdsDados: TUniClientDataSet;
    cdsDadosFCTB_CODPOR: TStringField;
    cdsDadosFCTB_NOMPOR: TStringField;
    cdsDadosFCTB_VALLAN: TFloatField;
    cdsDadosCHEQUES: TStringField;
    qryDadosFCTB_SEQLAN: TStringField;
    cdsDadosFCTB_SEQLAN: TStringField;
    qryDadosFCTB_CREDEB: TStringField;
    cdsDadosFCTB_CREDEB: TStringField;
    qryDadosFCTB_DTALAN: TDateTimeField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxDadosCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cdsDadosCHEQUESGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsDadosFCTB_NOMPORGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    repMovBan: TMovBanRepository;
    repCadPag: TCadPagRepository;
    lstMovBan: TList<TMovBan>;
    objCadPag: TCadPag;
    fltValorRecalculado: Double;

    procedure pChamarTelaCheques;
    procedure pRecalculaValor (intSeqCon : Integer; strEmpBai : String);

    function RetornaDataMovBan(APagcon: Integer;
                               AEmpresaBaixa: String;
                               ADataPagamento: TDateTime): TDateTime;
  public
    { Public declarations }
    strNumDup, strParcel: String;
    intSeqBai: Integer;
    strCodEmp, strCodFor, strSerie_, strSeqLan: String
  end;

var
  frmCtpListaPortadores: TfrmCtpListaPortadores;

implementation

{$R *.dfm}

uses untFuncoesRel, untFuncoesRel2;

procedure TfrmCtpListaPortadores.cdsDadosCHEQUESGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := '...';
end;

procedure TfrmCtpListaPortadores.cdsDadosFCTB_NOMPORGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := fRetNomPortador(cdsDadosFCTB_CODPOR.AsString);
end;

procedure TfrmCtpListaPortadores.cxDadosCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  Var
    coluna : TcxgridDBColumn;
begin
  inherited;
  If ACellViewInfo = Nil Then
    Exit;

  If ACellViewInfo.Item = Nil Then
    Exit;

  If (ACellViewInfo.item.Caption <> 'Cheques') Then
    Exit;

  coluna := cxDados.GetColumnByFieldName('CHEQUES');

  If (coluna <> Nil) And (ACellViewInfo.Item.Index = coluna.Index) And
     (cdsDados.FindField('FCTB_CODPOR') <> Nil) Then
  Begin
    pChamarTelaCheques;
    AHandled := True;
  End;
end;

procedure TfrmCtpListaPortadores.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(repMovBan);
  FreeAndNil(repCadPag);
end;

procedure TfrmCtpListaPortadores.FormCreate(Sender: TObject);
begin
  inherited;
  repMovBan := TMovBanRepository.Create;
  repCadPag := TCadPagRepository.Create;
end;

procedure TfrmCtpListaPortadores.FormShow(Sender: TObject);
  Var
    LDataMovBan: TDateTime;
begin
  inherited;
  fltValorRecalculado:= 0;
  objCadPag := repCadPag.fRetDuplicata(strNumDup, strParcel, intSeqBai, strCodEmp, strCodFor, strSerie_);

  LDataMovBan := 0;

  If strSerie_ <> 'CRT' Then
  Begin
    LDataMovBan := RetornaDataMovBan(objCadPag.intSeqCon, objCadPag.strEmpBai, objCadPag.dtaDtaPag);
    lstMovBan := repMovBan.fRetDocumentos(objCadPag.intSeqCon, objCadPag.strEmpBai);
  End
  Else
    lstMovBan := repMovBan.fRetDocumentos(objCadPag.intSeqCon, objCadPag.strEmpBai, strSeqLan);

  qryDados.SetSourceList(lstMovBan);
  qryDados.Open;

  cdsDados.CreateDataSet;
  cdsDados.IndexFieldNames := 'FCTB_CODPOR';

  qryDados.First;
  While not qryDados.Eof Do
  Begin
    If LDataMovBan > 0 Then
    Begin
      If LDataMovBan <> qryDados.FieldByName('FCTB_DTALAN').AsDateTime Then
      Begin
        qryDados.Next;
        Continue;
      End;
    End;

    If cdsDados.FindKey([qryDados.FieldByName('FCTB_CODPOR').AsString]) Then
   Begin
     cdsDados.Edit;
     cdsDados.FieldByName('FCTB_VALLAN').AsFloat := cdsDados.FieldByName('FCTB_VALLAN').AsFloat +
                                                    IIF(qryDados.FieldByName('FCTB_CREDEB').AsString='D',
                                                        qryDados.FieldByName('FCTB_VALLAN').AsFloat*(-1),
                                                        qryDados.FieldByName('FCTB_VALLAN').AsFloat);
   End
   Else
   Begin
     cdsDados.Insert;
     cdsDados.FieldByName('FCTB_SEQLAN').AsString := qryDados.FieldByName('FCTB_SEQLAN').AsString;
     cdsDados.FieldByName('FCTB_CODPOR').AsString := qryDados.FieldByName('FCTB_CODPOR').AsString;
     cdsDados.FieldByName('FCTB_NOMPOR').AsString := qryDados.FieldByName('FCTB_NOMPOR').AsString;
     If (qryDados.RecordCount = 1) And (fCfgSis('CTP_AS') = 'S') Then
     Begin
       pRecalculaValor (objCadPag.intSeqCon,objCadPag.strEmpBai);
       If (fltValorRecalculado <> qryDados.FieldByName('FCTB_VALLAN').AsFloat) Then
       Begin
         cdsDados.FieldByName('FCTB_VALLAN').AsFloat := fltValorRecalculado;
       End
       Else
         cdsDados.FieldByName('FCTB_VALLAN').AsFloat := qryDados.FieldByName('FCTB_VALLAN').AsFloat;
     End
     Else
       cdsDados.FieldByName('FCTB_VALLAN').AsFloat := IIF(qryDados.FieldByName('FCTB_CREDEB').AsString='D',
                                                         qryDados.FieldByName('FCTB_VALLAN').AsFloat*(-1),
                                                         qryDados.FieldByName('FCTB_VALLAN').AsFloat);
     End;
   cdsDados.Post;
   qryDados.Next;
  End;
end;

procedure TfrmCtpListaPortadores.pChamarTelaCheques;
begin

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(89, 5407, [],
                        ['SEQLAN','CODEMP','CODFOR'],
                        [IntToStr(objCadPag.intSeqCon),
                        objCadPag.strEmpBai,
                        cdsDados.FieldByName('FCTB_CODPOR').AsString],
                        nil,
                        nil,
                        True);
  End;

end;

procedure TfrmCtpListaPortadores.pRecalculaValor(intSeqCon: Integer; strEmpBai:String);
Var
  strSQL : String;
  qryGen1: TUniQuery;
begin
  qryGen1 := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADPAG ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTP_SEQCON = :SEQCON AND ';
  strSQL := strSQL + '  CTP_EMPBAI = :EMPBAI     ';


  With qryGen1 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('SEQCON').AsInteger := intSeqCon;
    ParamByName('EMPBAI').AsString := strEmpBai;
    Open;

    If Not IsEmpty Then
      While Not Eof Do
      Begin
        fltValorRecalculado := fltValorRecalculado + qryGen1.FieldByName('CTP_VALPAG').AsFloat;
        Next;
      End
  End;
  FreeAndNil(qryGen1);
end;

function TfrmCtpListaPortadores.RetornaDataMovBan(APagcon: Integer;
  AEmpresaBaixa: String; ADataPagamento: TDateTime): TDateTime;
  Var
    LConsulta: TUniQuery;
begin
  If APagcon = 0 Then
    Exit(0);

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT MIN(CTB_DTALAN) AS DATA ' +
                          'FROM MOVBAN ' +
                          'WHERE CTB_DTALAN >= :DTAPAG ' +
                          '  AND CTB_CODEMP = :CODEMP ' +
                          '  AND CTB_PAGCON = :PAGCON';

    LConsulta.ParamByName('DTAPAG').AsDateTime := ADataPagamento;
    LConsulta.ParamByName('CODEMP').AsString := AEmpresaBaixa;
    LConsulta.ParamByName('PAGCON').AsInteger := APagcon;

    LConsulta.Open;

    Try
      Result := LConsulta.FieldByName('DATA').AsDateTime;
    Except
      Result := 0;
    End;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

end.
