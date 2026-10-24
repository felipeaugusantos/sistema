unit untGeraArqSerasaPEFINSel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, DirectoryEditFocus, Grids, DBGridCitel, DBGrids, MaskEditFocus, Uni,
  DB, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  UniClientDataSet, UniDataSetProvider, System.StrUtils;

type
  TfrmGeraArqSerasaPEFINSel = class(TfrmPai)
    pnlTopo: TPanel;
    pnlDadosDup: TPanel;
    lblCliente: TLabel;
    Nome: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    lblProtesta: TLabel;
    Label1: TLabel;
    edtCodCliBai: TEdit;
    edtNomCliBai: TEdit;
    edtCodPorBai: TEdit;
    edtNomPorBai: TEdit;
    edtNosNum: TEdit;
    edtHistor: TEdit;
    edtHistor2: TEdit;
    edtDesProtesta: TEdit;
    edtCodVel: TEdit;
    pnlTotais: TPanel;
    Label21: TLabel;
    Label9: TLabel;
    edtTotalDup: TEditFocus;
    edtTotalSelecionado: TEditFocus;
    Panel1: TPanel;
    dbgDuplicatas: TDBGridCitel;
    btnConfirma: TBitBtnLocked;
    btnSelTodos: TBitBtnLocked;
    btnProximo: TBitBtnLocked;
    btnBusca: TBitBtnLocked;
    btnOrdem: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    procedure dbgDuplicatasDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbgDuplicatasDblClick(Sender: TObject);
    procedure dbgDuplicatasCellClick(Column: TColumn);
    procedure dbgDuplicatasKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnOrdemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnSelTodosClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOrdemKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgDuplicatasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
  private
    { Private declarations }
    strValorFiltro: String;
    strCampoFiltro: String;
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    function fCriaCdsArqSer(AOwner: TComponent): TUniClientDataSet;
  public
    { Public declarations }
    qryArqSer: TUniQuery;
    cdsArqSer: TUniClientDataSet;
    dspArqSer: TUniDataSetProvider;
    dtsArqSer: TDataSource;
    dtaDtaIni: TDateTime;
    dtaDtaFin: TDateTime;
    strCodEmp: String;
    strEspDoc: String;
    strCodPor: String;
    strOrdem: String;
    intOrdem: Integer;

    procedure pSelecionaDuplicataContasReceber;
    procedure pAtualizaDadosContasReceber;
    procedure pMudaOrdemContasReceber;
    procedure pSelTodosContasReceber;
    function fTotalDup: string;
    function fTotalDupSel: String;
    procedure pCriarArquivoSerasa;
    function fDupMarcadas: Boolean;
    procedure pDesmarcarTodas;
    function fGeraDupSerasa: Boolean;
    procedure pLiberaObjetos;
  end;

var
  frmGeraArqSerasaPEFINSel: TfrmGeraArqSerasaPEFINSel;

implementation

uses untFuncoesSimples, 
  untBaixaBusca,  untExpArqSerPEFIN, untGravando, untConstantes;

{$R *.dfm}

{ TfrmGeraArqSerasaPEFIN }



procedure TfrmGeraArqSerasaPEFINSel.dbgDuplicatasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  {*************************************************************}
  {* MUDA AS CORES DO GRID DE ACORDO COM A ORDEM DE A MARCACAO *}
  {**********************************************************PH*}

  If (cdsArqSer.FieldByName('CTR_MARCAD').AsString = 'M') Then
  Begin
    dbgDuplicatas.Canvas.Font.Color := clBlue;
    dbgDuplicatas.DefaultDrawColumnCell(Rect,DataCol, Column, State);
  End;

  If (Column.Field.FieldName = strOrdem) Then
  Begin
    dbgDuplicatas.Canvas.Brush.Color := clInfoBk;
    dbgDuplicatas.Canvas.Font.Color  := clWindowText;
    dbgDuplicatas.Canvas.FillRect(Rect);

    dbgDuplicatas.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

end;

procedure TfrmGeraArqSerasaPEFINSel.dbgDuplicatasDblClick(Sender: TObject);
begin
  inherited;
  pSelecionaDuplicataContasReceber;
  pAtualizaDadosContasReceber;
end;

procedure TfrmGeraArqSerasaPEFINSel.pSelecionaDuplicataContasReceber;
begin
  With cdsArqSer Do
  Begin
    Edit;
    If FieldByName('CTR_MARCAD').AsString = 'M' Then
      FieldByName('CTR_MARCAD').AsString := 'D'
    Else
      FieldByName('CTR_MARCAD').AsString := 'M';
    Post;
  End;
end;

procedure TfrmGeraArqSerasaPEFINSel.pAtualizaDadosContasReceber;
begin

  edtCodCliBai.Text := cdsArqSer.FieldByName('CTR_CODCLI').AsString;
  edtNomCliBai.Text := cdsArqSer.FieldByName('CLI_NOMCLI').AsString;

  edtCodPorBai.Text := cdsArqSer.FieldByName('CTR_CODPOR').AsString;
  edtNomPorBai.Text := cdsArqSer.FieldByName('POR_NOMPOR').AsString;

  edtNosNum.Text    := cdsArqSer.FieldByName('CTR_NOSNUM').AsString;
  edtHistor.Text    := AnsiReplaceStr(cdsArqSer.FieldByName('CTR_HIST01').AsString, STRING_QUEBRA, EmptyStr);
  edtHistor2.Text   := AnsiReplaceStr(cdsArqSer.FieldByName('CTR_HIST02').AsString, STRING_QUEBRA, EmptyStr);

  If cdsArqSer.FieldByName('CTR_PROTES').AsString = 'N' Then
  Begin
    edtDesProtesta.Text    := 'Não';
    edtDesProtesta.Font.Color := clmoneygreen;
  End
  Else If cdsArqSer.FieldByName('CTR_PROTES').AsString = 'S' Then
  Begin
    edtDesProtesta.Text    := 'Sim';
    edtDesProtesta.Font.Color := clRed;
  End
  Else
  Begin
    edtDesProtesta.Visible := False;
    lblProtesta.Visible    := False;
  End;

  edtCodVel.Text           := cdsArqSer.FieldByName('CTR_CODVEL').AsString;
  edtTotalDup.Text         := fTotalDup;
  edtTotalSelecionado.Text := fTotalDupSel;
end;

procedure TfrmGeraArqSerasaPEFINSel.dbgDuplicatasCellClick(Column: TColumn);
begin
  inherited;
  pAtualizaDadosContasReceber;
end;

procedure TfrmGeraArqSerasaPEFINSel.dbgDuplicatasKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  dbgDuplicatas.Refresh;
  pAtualizaDadosContasReceber;
end;

procedure TfrmGeraArqSerasaPEFINSel.btnOrdemClick(Sender: TObject);
begin
  inherited;
  pMudaOrdemContasReceber;
end;

procedure TfrmGeraArqSerasaPEFINSel.pMudaOrdemContasReceber;
begin
  strOrdem := dbgDuplicatas.Fields[intOrdem].FieldName;
  cdsArqser.IndexFieldNames := dbgDuplicatas.Fields[intOrdem].FieldName;
  intOrdem := (intOrdem + 1) mod (dbgDuplicatas.FieldCount);
end;

procedure TfrmGeraArqSerasaPEFINSel.FormCreate(Sender: TObject);
begin
  inherited;
  intOrdem := 3;
end;

procedure TfrmGeraArqSerasaPEFINSel.FormDestroy(Sender: TObject);
begin
  inherited;
  pLiberaObjetos;
end;

procedure TfrmGeraArqSerasaPEFINSel.btnBuscaClick(Sender: TObject);
  Var
    frmBaixaBusca : TfrmBaixaBusca;
begin
  inherited;
  If (Not cdsArqSer.Active) Or
     (cdsArqSer.IsEmpty)    Then
    Exit;

  Try
    pCriarFormularios(TfrmBaixaBusca, frmBaixaBusca);
    frmBaixaBusca.ShowModal;
  Finally
    If (Not fEmptyStr(frmBaixaBusca.strValorFiltro)) Then
    Begin
      strValorFiltro := frmBaixaBusca.strValorFiltro;
      strCampoFiltro := frmBaixaBusca.strCampoFiltro;
      cdsArqSer.FieldByName('CTR_CODCLI').AsString;
      cdsArqSer.FindFirst;
    End;
    FreeAndNil(frmBaixaBusca);
    pAtualizaDadosContasReceber;
  End;

end;

procedure TfrmGeraArqSerasaPEFINSel.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
end;

procedure TfrmGeraArqSerasaPEFINSel.pLiberaObjetos;
begin
  FreeAndNil(dtsArqSer);
  FreeAndNil(qryArqSer);
  FreeAndNil(cdsArqSer);
  FreeAndNil(dspArqSer);
end;

procedure TfrmGeraArqSerasaPEFINSel.btnProximoClick(Sender: TObject);
begin
  inherited;
  If (cdsArqSer.Active) And (Not fEmptyStr(strCampoFiltro)) Then
  begin
    cdsArqSer.FindNext;
    pAtualizaDadosContasReceber;
  end;
end;

procedure TfrmGeraArqSerasaPEFINSel.btnSelTodosClick(Sender: TObject);
begin
  inherited;
  pSelTodosContasReceber;
end;

procedure TfrmGeraArqSerasaPEFINSel.pSelTodosContasReceber;
var
  intRecNo: Integer;
begin
  Try
    With cdsArqSer Do
    Begin
      intRecNo := RecNo;
      DisableControls;
      First;

      While Not Eof Do
      Begin
        Edit;
        FieldByName('CTR_MARCAD').AsString := 'M';
        Post;

        Next;
      End;

      RecNo := intRecNo;
      EnableControls;
    End;

    pAtualizaDadosContasReceber;
    pSetFocus(dbgDuplicatas);

  Except
    On E:Exception Do
      pMensagensErro(E.Message, '[TfrmGeraArqSerasaPEFINSel.pSelTodosContasReceber]');
  End;
end;

procedure TfrmGeraArqSerasaPEFINSel.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pCriarArquivoSerasa, 'Aguarde... Carregando Títulos.', '');
end;

procedure TfrmGeraArqSerasaPEFINSel.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  pDesmarcarTodas;
end;

procedure TfrmGeraArqSerasaPEFINSel.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(dbgDuplicatas);
  pMudaOrdemContasReceber;
  pAtualizaDadosContasReceber;
end;

function TfrmGeraArqSerasaPEFINSel.fTotalDup: string;
Var
  cdsClone : TUniClientDataSet;
  fldTotal : TAggregateField;
Begin
  Try
    cdsClone := TUniClientDataSet.Create(Self);
    fldTotal := fCriaAggregateField(cdsClone, 'FLDTOT', 'SUM(CTR_VALDUP)');
    cdsClone.Data := cdsArqSer.Data;
    cdsClone.AggregatesActive := True;

    Result := FormatFloat('#,##0.00', IIF(fldTotal.Value = Null, 0, fldTotal.Value));
  Finally
    FreeAndNil(cdsClone);
  End;
end;

function TfrmGeraArqSerasaPEFINSel.fTotalDupSel: String;
Var
  cdsClone : TUniClientDataSet;
  fldTotal : TAggregateField;
begin
  Try
    cdsClone := TUniClientDataSet.Create(Self);
    fldTotal := fCriaAggregateField(cdsClone, 'FLDTOT', 'SUM(CTR_VALDUP)');

    With cdsClone Do
    Begin
      Data := cdsArqSer.Data;

      Filtered := False;
      Filter := 'CTR_MARCAD = ''M''';
      Filtered := True;

      AggregatesActive := True;
    End;

    Result := FormatFloat('#,##0.00', IIF(fldTotal.Value = Null, 0, fldTotal.Value));
  Finally
    FreeAndNil(cdsClone);
  End;
end;

procedure TfrmGeraArqSerasaPEFINSel.pCriarArquivoSerasa;
Begin
  If fDupMarcadas Then
  Begin
    pCriarFormularios(TfrmExpArqSerPEFIN, frmExpArqSerPEFIN);
    frmExpArqSerPEFIN.cdsArqSer.Data := cdsArqSer.Data;
    frmExpArqSerPEFIN.ShowModal;
    Close;
  End
  Else
    fMensagem(Application.Title, 'Não existem duplicatas selecionadas', ['&O K'])
end;

function TfrmGeraArqSerasaPEFINSel.fCriaCdsArqSer(
  AOwner: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(AOwner);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_NUMDUP';
    DataType:= ftString;
    Size:= 12;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_PARCEL';
    DataType:= ftString;
    Size:= 1;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_ESPDOC';
    DataType:= ftString;
    Size:= 2;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_DTACAD';
    DataType:= ftDate;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_VALDUP';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_VALJUR';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_VALDES';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_CODEMP';
    DataType:= ftString;
    Size:= 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_CODCLI';
    DataType:= ftString;
    Size:= 8;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CLI_NOMCLI';
    DataType:= ftString;
    Size:= 60;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_CODPOR';
    DataType:= ftString;
    Size:= 5;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'POR_NOMPOR';
    DataType:= ftString;
    Size:= 40;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_NOSNUM';
    DataType:= ftString;
    Size:= 12;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_HIST01';
    DataType:= ftString;
    Size:= 120;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_HIST02';
    DataType:= ftString;
    Size:= 120;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_OBSAG1';
    DataType:= ftString;
    Size:= 120;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_OBSAG2';
    DataType:= ftString;
    Size:= 120;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_OBSAG3';
    DataType:= ftString;
    Size:= 120;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_CODVEL';
    DataType:= ftString;
    Size:= 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_DTAVEN';
    DataType:= ftDate;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_MARCAD';
    DataType:= ftString;
    Size:= 1;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_PROTES';
    DataType:= ftString;
    Size:= 1;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_SEQBAI';
    DataType:= ftInteger;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CTR_AUTINC';
    DataType:= ftString;
    Size:= 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CLI_CGCCPF';
    DataType:= ftString;
    Size:= 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CLI_C_G_C_';
    DataType:= ftString;
    Size:= 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CLI_DTACAD';
    DataType:= ftDate;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CLI_STATUS';
    DataType:= ftString;
    Size:= 1;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CLI_FONE01';
    DataType:= ftString;
    Size:= 15;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CLI_ENDERE';
    DataType:= ftString;
    Size:= 160;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CLI_C_E_P_';
    DataType:= ftString;
    Size:= 10;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CLI_BAIRRO';
    DataType:= ftString;
    Size:= 60;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CID_NOMCID';
    DataType:= ftString;
    Size:= 40;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CID_ESTADO';
    DataType:= ftString;
    Size:= 2;
  End;
end;

function TfrmGeraArqSerasaPEFINSel.fDupMarcadas: Boolean;
var
  cdsClone : TUniClientDataSet;
Begin
  Try
    cdsClone := TUniClientDataSet.Create(Self);

    With cdsClone Do
    Begin
      Data := cdsArqSer.Data;

      Filtered := False;
      Filter := 'CTR_MARCAD = ''M''';
      Filtered := True;
    End;

    Result := (cdsClone.RecordCount > 0);
  Finally
    FreeAndNil(cdsClone);
  End;
end;

function TfrmGeraArqSerasaPEFINSel.fGeraDupSerasa: Boolean;
Var
  strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT                                           ';
  strSQL := strSQL + '  CTR_NUMDUP,                                    ';
  strSQL := strSQL + '  CTR_PARCEL,                                    ';
  strSQL := strSQL + '  CTR_ESPDOC,                                    ';
  strSQL := strSQL + '  CTR_DTACAD,                                    ';
  strSQL := strSQL + '  CTR_VALORI AS CTR_VALDUP,                      ';
  strSQL := strSQL + '  CTR_VALJUR,                                    ';
  strSQL := strSQL + '  CTR_VALDES,                                    ';
  strSQL := strSQL + '  CTR_CODEMP,                                    ';
  strSQL := strSQL + '  CTR_CODCLI,                                    ';
  strSQL := strSQL + '  CLI_NOMCLI,                                    ';
  strSQL := strSQL + '  CTR_CODPOR,                                    ';
  strSQL := strSQL + '  POR_NOMPOR,                                    ';
  strSQL := strSQL + '  CTR_NOSNUM,                                    ';
  strSQL := strSQL + '  CTR_HIST01,                                    ';
  strSQL := strSQL + '  CTR_HIST02,                                    ';
  strSQL := strSQL + '  CTR_OBSAG1,                                    ';
  strSQL := strSQL + '  CTR_OBSAG2,                                    ';
  strSQL := strSQL + '  CTR_OBSAG3,                                    ';
  strSQL := strSQL + '  CTR_CODVEL,                                    ';
  strSQL := strSQL + '  CTR_DTAVEN,                                    ';
  strSQL := strSQL + '  CTR_VALCOB,                                    ';
  strSQL := strSQL + '  "D" AS CTR_MARCAD,                             ';
  strSQL := strSQL + '  "N" AS CTR_PROTES,                             ';
  strSQL := strSQL + '  CTR_DTASER,                                    ';
  strSQL := strSQL + '  CTR_SEQBAI,                                    ';
  strSQL := strSQL + '  RIGHT(CADREC.AUTOINCREM, 17) AS CTR_AUTINC,    ';
  strSQL := strSQL + '  CLI_CGCCPF,                                    ';
  strSQL := strSQL + '  REPLACE(REPLACE(REPLACE(CLI_C_G_C_, ".", ""), "/", ""), "-", "") AS CLI_C_G_C_, ';
  strSQL := strSQL + '  CLI_DTACAD,                                    ';
  strSQL := strSQL + '  CLI_STATUS,                                    ';
  strSQL := strSQL + '  CLI_FONE01,                                    ';
  strSQL := strSQL + '  IF(CLI_ENDCOB IS NULL, CONCAT(CLI_ENDERE, ", ", CLI_ENDNUM, ", ", CLI_ENDCOM), CLI_ENDCOB) AS CLI_ENDERE, ';
  strSQL := strSQL + '  IF(CLI_CEPCOB IS NULL, CLI_C_E_P_, CLI_CEPCOB) AS CLI_C_E_P_, ';
  strSQL := strSQL + '  IF(CLI_BAICOB IS NULL, CLI_BAIRRO, CLI_BAICOB) AS CLI_BAIRRO, ';
  strSQL := strSQL + '  CID_NOMCID,                                     ';
  strSQL := strSQL + '  CID_ESTADO                                      ';
  strSQL := strSQL + 'FROM                                              ';
  strSQL := strSQL + '  CADREC ';

  strSQL := strSQL + '  INNER JOIN CADCLI ON (CTR_CODCLI = CLI_CODCLI) ';
  strSQL := strSQL + '  LEFT JOIN CADCID ON (CID_CODCID = CLI_CODCID)  ';
  strSQL := strSQL + '  LEFT JOIN CADPOR ON (CTR_CODPOR = POR_CODPOR)  ';
  strSQL := strSQL + 'WHERE                                            ';
  strSQL := strSQL + '  CTR_DTAREC IS NULL                             ';
  strSQL := strSQL + '  AND CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIM     ';
  strSQL := strSQL + '  AND CTR_SEQBAI = 0                             ';
  strSQL := strSQL + '  AND IFNULL(CTR_NOSNUM, "")                     ';
  strSQL := strSQL + '  AND CTR_BCOBOL = "001"                         ';
  strSQL := strSQL + '  AND CTR_DTAPFI IS NULL                         ';

  If Trim(strCodEmp) <> '' Then
    strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP                     ';

  If Trim(strEspDoc) <> '' Then
    strSQL := strSQL + '  AND CTR_ESPDOC = :ESPDOC                     ';

  If Trim(strCodPor) <> '' Then
    strSQL := strSQL + '  AND CTR_CODPOR = :CODPOR                     ';

  strSQL := strSQL + ' ORDER BY CTR_DTAVEN ';

  qryArqSer := fCriaQuery(Self);
  cdsArqSer := fCriaCdsArqSer(Self);
  cdsArqSer.OnFilterRecord := pFilterRecord;
  dspArqSer := TUniDataSetProvider.Create(Self);
  dtsArqSer := fCriaDataSource(cdsArqSer);
  dspArqSer.DataSet := qryArqSer;

  dbgDuplicatas.DataSource := dtsArqSer;

  With qryArqSer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('DTAINI').AsDate := dtaDtaIni;
    ParamByName('DTAFIM').AsDate := dtaDtaFin;

    If Trim(strCodEmp) <> '' Then
      ParamByName('CODEMP').AsString := strCodEmp;

    If Trim(strEspDoc) <> '' Then
      ParamByName('ESPDOC').AsString := strEspDoc;

    If (Not fEmptyStr(strCodPor)) Then
      ParamByName('CODPOR').AsString := strCodPor;

    cdsArqSer.Close;
    cdsArqSer.SetProvider(dspArqSer);

    qryArqSer.Open;
    pSetaClient(qryArqSer);
    cdsArqSer.Open;

    (cdsArqSer.FieldByName('CTR_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';

    Result := Not IsEmpty;

    If Not Result Then
    Begin
      pLiberaObjetos;
      fMensagem('','Não há duplicatas para serem enviadas!', ['&OK']);
    End;
  End;
end;

procedure TfrmGeraArqSerasaPEFINSel.btnOrdemKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Escape: btnSair.Click;
    VK_Space : pSelecionaDuplicataContasReceber;
    VK_F3    : btnOrdem.Click;
    VK_F4    : btnDesmarcaTodos.Click;
    VK_F5    : btnBusca.Click;
    VK_F6    : btnProximo.Click;
    VK_F7    : btnSelTodos.Click;
    VK_F10   : btnConfirma.Click;
  End;
end;

procedure TfrmGeraArqSerasaPEFINSel.pDesmarcarTodas;
var
  intRecNo: Integer;
begin
  Try
    With cdsArqSer Do
    Begin
      intRecNo := RecNo;
      DisableControls;
      First;

      While Not Eof Do
      Begin
        Edit;
        FieldByName('CTR_MARCAD').AsString := 'D';
        Post;

        Next;
      End;

      RecNo := intRecNo;
      EnableControls;
    End;

    pAtualizaDadosContasReceber;
    pSetFocus(dbgDuplicatas);

  Except
    On E:Exception Do
      pMensagensErro(E.Message, '[TfrmGeraArqSerasaPEFINSel.pDesmarcarTodas]');
  End;
end;

procedure TfrmGeraArqSerasaPEFINSel.dbgDuplicatasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Escape: btnSair.Click;
    VK_Space : pSelecionaDuplicataContasReceber;

    VK_Return: Begin
                  pSelecionaDuplicataContasReceber;
                  pSetFocus(dbgDuplicatas);
                End;

    VK_F3    : btnOrdem.Click;
    VK_F4    : btnDesmarcaTodos.Click;
    VK_F5    : btnBusca.Click;
    VK_F6    : btnProximo.Click;
    VK_F7    : btnSelTodos.Click;
    VK_F10   : btnConfirma.Click;
  End;
end;

end.
