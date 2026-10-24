unit untGeraArqSerasaSel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, DirectoryEditFocus, Grids, DBGridCitel, DBGrids, MaskEditFocus, Uni,
  DB, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, StrUtils;

type
  TfrmGeraArqSerasaSel = class(TfrmPai)
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
    lblDevol1: TLabel;
    lblDevol2: TLabel;
    pnlTopo: TPanel;
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
    procedure btnProtestaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgDuplicatasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnOrdemKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    strValorFiltro: String;
    strCampoFiltro: String;
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    function fTemNaCadCbi(strNumDup, strEspDoc, strParcel, strCodEmp, strCodCli: String): Boolean;

    function RetornaNumeroDuplicata(ANumDup: String): String;

    function DuplicataExistenteNaCADCBI(ANumeroDuplicata,
                                        AParcela,
                                        AEspecie,
                                        ACodigoEmpresa,
                                        ACodigoCliente: String;
                                        AExibeMensagem: Boolean = False): Boolean;
  public
    { Public declarations }
    qryArqSer: TUniQuery;
    dtsArqSer: TDataSource;
    strOrdem: String;
    intOrdem: Integer;
    intOpcao: Integer;
    dtaDtaIni: TDateTime;
    dtaDtaFin: TDateTime;
    strCodBco: String;

    procedure pSelecionaDuplicataContasReceber;
    procedure pAtualizaDadosContasReceber;
    procedure pMudaOrdemContasReceber;
    procedure pSelTodosContasReceber(blnMarca: Boolean = True);
    procedure pProtestaContasReceber;
    function fTotalDup: string;
    function fTotalDupSel: String;
    procedure pCriarArquivoSerasa;
    function fdupMarcadas: Boolean;
    procedure pConfirmaDupSerasa;
  end;

var
  frmGeraArqSerasaSel: TfrmGeraArqSerasaSel;

implementation

uses untFuncoesSimples,
  untBaixaBusca, untModuloCadCbi, untFuncoes;

{$R *.dfm}

{ TfrmGeraArqSerasa }



procedure TfrmGeraArqSerasaSel.dbgDuplicatasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  {*************************************************************}
  {* MUDA AS CORES DO GRID DE ACORDO COM A ORDEM DE A MARCACAO *}
  {**********************************************************PH*}

  If (qryArqSer.FieldByName('CTR_MARCAD').AsString = 'M') Then
  Begin
    dbgDuplicatas.Canvas.Font.Color := clBlue;
    dbgDuplicatas.DefaultDrawColumnCell(Rect,DataCol, Column, State);
  End;

  If Assigned(Column.Field) Then
  Begin
    If (Column.Field.FieldName = strOrdem) Then
    Begin
      dbgDuplicatas.Canvas.Brush.Color := clInfoBk;
      dbgDuplicatas.Canvas.Font.Color  := clWindowText;
      dbgDuplicatas.Canvas.FillRect(Rect);

      dbgDuplicatas.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    End;
  End;

end;

procedure TfrmGeraArqSerasaSel.dbgDuplicatasDblClick(Sender: TObject);
begin
  inherited;
  pSelecionaDuplicataContasReceber;
  pAtualizaDadosContasReceber;
end;

procedure TfrmGeraArqSerasaSel.pSelecionaDuplicataContasReceber;
  Var
    strSQL: String;
    intRecNo: Integer;
    qryGen: TUniQuery;
begin
  If (strCodBco = 'BOA') And
     (Not TEspecieParaArquivoRemessa.New.fValidaEspecie(qryArqSer.FieldByName('CTR_ESPDOC').AsString)) Then
    Exit;

  {*********************************************}
  {* VERIFICO SE A DUPLICATA JÁ ESTÁ NA CADCBI *}
  {******************************************JU*}
  If fTemNaCadCbi(qryArqSer.FieldByName('CTR_NUMDUP1').AsString,
                  qryArqSer.FieldByName('CTR_ESPDOC').AsString,
                  qryArqSer.FieldByName('CTR_PARCEL').AsString,
                  qryArqSer.FieldByName('CTR_CODEMP').AsString,
                  qryArqSer.FieldByName('CTR_CODCLI').AsString)Then
  Begin
    fMensagem('','Essa duplicata já foi selecionada para ser enviada ao SERASA!', ['&OK']);
    Exit;
  End;

  If DuplicataExistenteNaCADCBI(qryArqSer.FieldByName('CTR_NUMDUP1').AsString,
                                qryArqSer.FieldByName('CTR_PARCEL').AsString,
                                qryArqSer.FieldByName('CTR_ESPDOC').AsString,
                                qryArqSer.FieldByName('CTR_CODEMP').AsString,
                                qryArqSer.FieldByName('CTR_CODCLI').AsString,
                                True) Then
    Exit;

  {***********************************************}
  {* MARCA A DUPLICATA PARA SER GERADO O ARQUIVO *}
  {********************************************PH*}
  Try
    intRecNo := qryArqSer.RecNo;

    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'UPDATE TMP_GERSER SET ';

    If qryArqSer.FieldByName('CTR_MARCAD').AsString = 'M' Then
      strSQL := strSQL + 'CTR_MARCAD = "D" '
    Else
      strSQL := strSQL + 'CTR_MARCAD = "M" ';

    strSQL := strSQL + 'WHERE                      ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := qryArqSer.FieldByName('CTR_NUMDUP1').AsString;
      ParamByName('PARCEL').AsString := qryArqSer.FieldByName('CTR_PARCEL').AsString;
      ParamByName('ESPDOC').AsString := qryArqSer.FieldByName('CTR_ESPDOC').AsString;
      ParamByName('CODEMP').AsString := qryArqSer.FieldByName('CTR_CODEMP').AsString;
      ParamByName('CODCLI').AsString := qryArqSer.FieldByName('CTR_CODCLI').AsString;
      ExecSQL;
      Close;
    End;

    qryArqSer.Close;
    qryArqSer.Open;

    (qryArqSer.FieldByName('CTR_VALDUP') as TFloatField).DisplayFormat := '#,##0.00';

    qryArqSer.RecNo := intRecNo;
  Finally
    FreeAndNil(qryGen);
  End;

end;

procedure TfrmGeraArqSerasaSel.pAtualizaDadosContasReceber;
begin

  edtCodCliBai.Text := qryArqSer.FieldByName('CTR_CODCLI').AsString;
  edtNomCliBai.Text := qryArqSer.FieldByName('CLI_NOMCLI').AsString;

  edtCodPorBai.Text := qryArqSer.FieldByName('CTR_CODPOR').AsString;
  edtNomPorBai.Text := qryArqSer.FieldByName('POR_NOMPOR').AsString;

  edtNosNum.Text    := qryArqSer.FieldByName('CTR_NOSNUM').AsString;
  edtHistor.Text    := qryArqSer.FieldByName('CTR_HIST01').AsString;
  edtHistor2.Text   := qryArqSer.FieldByName('CTR_HIST02').AsString;

  If qryArqSer.FieldByName('CTR_PROTES').AsString = 'N' Then
  Begin
    edtDesProtesta.Text    := 'Não';
    edtDesProtesta.Font.Color := clmoneygreen;
  End
  Else If qryArqSer.FieldByName('CTR_PROTES').AsString = 'S' Then
  Begin
    edtDesProtesta.Text    := 'Sim';
    edtDesProtesta.Font.Color := clRed;
  End
  Else
  Begin
    edtDesProtesta.Visible := False;
    lblProtesta.Visible    := False;
  End;

  edtCodVel.Text           := qryArqSer.FieldByName('CTR_CODVEL').AsString;
  edtTotalDup.Text         := fTotalDup;
  edtTotalSelecionado.Text := fTotalDupSel;
end;

procedure TfrmGeraArqSerasaSel.dbgDuplicatasCellClick(Column: TColumn);
begin
  inherited;
  pAtualizaDadosContasReceber;
end;

procedure TfrmGeraArqSerasaSel.dbgDuplicatasKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  dbgDuplicatas.Refresh;
  pAtualizaDadosContasReceber;
end;

function TfrmGeraArqSerasaSel.DuplicataExistenteNaCADCBI(ANumeroDuplicata,
  AParcela, AEspecie, ACodigoEmpresa, ACodigoCliente: String;
  AExibeMensagem: Boolean = False): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT CBI_NUMDUP, CBI_CODBCO, CBI_EMPGER AS TOTAL ' +
                          'FROM CADCBI ' +
                          'WHERE CBI_NUMDUP="' + ANumeroDuplicata + '" ' +
                          '  AND CBI_PARCEL="' + AParcela + '" ' +
                          '  AND CBI_ESPDOC="' + AEspecie + '" ' +
                          '  AND CBI_CODEMP="' + ACodigoEmpresa + '" ' +
                          '  AND CBI_CODCLI="' + ACodigoCliente + '" ';
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
    If Not Result Then
      Exit;

    If AExibeMensagem Then
      fMensagem('ATENÇÃO', 'Não é possível selecionar essa duplicata, pois essa já foi ' +
                           'selecionada pela carteira do banco ' + LConsulta.FieldByName('CBI_CODBCO').AsString +
                           ' para envio de arquivo de remessa.', ['&Ok']);
  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmGeraArqSerasaSel.btnOrdemClick(Sender: TObject);
begin
  inherited;
  pMudaOrdemContasReceber;
end;

procedure TfrmGeraArqSerasaSel.pMudaOrdemContasReceber;
  Var
    strSQL: String;
begin

  Try
    While Not dbgDuplicatas.Columns.Items[intOrdem].Visible Do
      intOrdem := (intOrdem + 1) mod (dbgDuplicatas.FieldCount);

    strOrdem := dbgDuplicatas.Fields[intOrdem].FieldName;
  Except
    intOrdem := 1;
    strOrdem := dbgDuplicatas.Fields[intOrdem].FieldName;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT                                           ';
  strSQL := strSQL + '  CONCAT(CTR_NUMDUP,CTR_PARCEL) AS CTR_NUMDUP,   ';
  strSQL := strSQL + '  CTR_NUMDUP AS CTR_NUMDUP1,                     ';
  strSQL := strSQL + '  CTR_PARCEL,                                    ';
  strSQL := strSQL + '  CTR_ESPDOC,                                    ';
  strSQL := strSQL + '  CTR_DTACAD,                                    ';
  strSQL := strSQL + '  CTR_DTAREC,                                    ';
  strSQL := strSQL + '  DTAREF,                                        ';
//  strSQL := strSQL + '  CTR_VALDUP,                                    ';
  strSQL := strSQL + '  CTR_VALDUP,                                    ';
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
  strSQL := strSQL + '  CTR_MARCAD,                                    ';
  strSQL := strSQL + '  CTR_PROTES,                                    ';
  strSQL := strSQL + '  CTR_DTASER,                                    ';
  strSQL := strSQL + '  CTR_SEQBAI,                                    ';
  strSQL := strSQL + '  CLI_CGCCPF,                                    ';
  strSQL := strSQL + '  CLI_DTACAD,                                    ';
  strSQL := strSQL + '  REPLACE(REPLACE(REPLACE(CLI_C_G_C_, ".", ""), "/", ""), "-", "") AS CLI_C_G_C_, ';
  strSQL := strSQL + '  CLI_STATUS,                                    ';
  strSQL := strSQL + '  CTR_CANCEL,                                    ';
  strSQL := strSQL + '  DET_DEVOLV,                                    ';
  strSQL := strSQL + '  DET_DTADEV                                     ';
  strSQL := strSQL + 'FROM   ';
  strSQL := strSQL + '   TMP_GERSER ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + strOrdem;

  With qryArqSer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    (FieldByName('CTR_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
  End;
  intOrdem := (intOrdem + 1) mod (dbgDuplicatas.FieldCount);

end;

procedure TfrmGeraArqSerasaSel.FormActivate(Sender: TObject);
begin
  inherited;

  If intOpcao = 2 Then
  Begin
    dbgDuplicatas.Columns.Items[0].Visible := True;
    dbgDuplicatas.Columns.Items[7].Visible := True;
    lblDevol1.Visible := True;
    lblDevol2.Visible := True;
  End
  Else
  Begin
    dbgDuplicatas.Columns.Items[0].Visible := False;
    dbgDuplicatas.Columns.Items[7].Visible := False;
    lblDevol1.Visible := False;
    lblDevol2.Visible := False;
  End;

end;

procedure TfrmGeraArqSerasaSel.FormCreate(Sender: TObject);
begin
  inherited;
  intOrdem := 1;
end;

procedure TfrmGeraArqSerasaSel.btnBuscaClick(Sender: TObject);
  Var
    frmBaixaBusca : TfrmBaixaBusca;
begin
  inherited;
  If (Not qryArqSer.Active) Or
     (qryArqSer.IsEmpty)    Then
    Exit;

  Try
    pCriarFormularios(TfrmBaixaBusca, frmBaixaBusca);
    frmBaixaBusca.ShowModal;
  Finally
    If (Not fEmptyStr(frmBaixaBusca.strValorFiltro)) Then
    Begin
      strValorFiltro := frmBaixaBusca.strValorFiltro;
      strCampoFiltro := frmBaixaBusca.strCampoFiltro;
      qryArqSer.FieldByName('CTR_CODCLI').AsString;
      qryArqSer.FindFirst;
    End;
    FreeAndNil(frmBaixaBusca);
    pAtualizaDadosContasReceber;
  End;

end;

procedure TfrmGeraArqSerasaSel.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
end;

procedure TfrmGeraArqSerasaSel.btnProximoClick(Sender: TObject);
begin
  inherited;
  If (qryArqSer.Active) And (Not fEmptyStr(strCampoFiltro)) Then
  begin
    qryArqSer.FindNext;
    pAtualizaDadosContasReceber;
  end;
end;

procedure TfrmGeraArqSerasaSel.btnSelTodosClick(Sender: TObject);
begin
  inherited;
  pSelTodosContasReceber;
end;

procedure TfrmGeraArqSerasaSel.pSelTodosContasReceber(blnMarca: Boolean = True);
var
  strSQL,
  strEspDocPermitido: String;

  blnEspDocNaoPermitido,
  LDuplicataExisteNaCADCBI: Boolean;

  intRecNo: Integer;
  qryGen: TUniQuery;
begin
  {*********************************************}
  {* VERIFICO SE A DUPLICATA JÁ ESTÁ NA CADCBI *}
  {******************************************JU*}
  If fTemNaCadCbi(qryArqSer.FieldByName('CTR_NUMDUP1').AsString,
                  qryArqSer.FieldByName('CTR_ESPDOC').AsString,
                  qryArqSer.FieldByName('CTR_PARCEL').AsString,
                  qryArqSer.FieldByName('CTR_CODEMP').AsString,
                  qryArqSer.FieldByName('CTR_CODCLI').AsString) Then
  Begin
    fMensagem('','Essa duplicata já foi selecinada para ser enviada ao SERASA!', ['&OK']);
    Exit;
  End;

  Try
    qryGen := fCriaQuery;
    intRecNo := qryArqSer.RecNo;

    strEspDocPermitido    := TEspecieParaArquivoRemessa.New.fRetornaEspeciesPermitidas();

    strSQL := '';
    strSQL := strSQL + 'UPDATE TMP_GERSER SET ';

    If Not blnMarca Then
      strSQL := strSQL + 'CTR_MARCAD = "D" '
    Else
      strSQL := strSQL + 'CTR_MARCAD = "M" ';

    If blnMarca Then
    Begin
      If (strCodBco = 'BOA') Then
        strSQL := strSQL + ' WHERE CTR_ESPDOC IN (' + fRetStrToSQLIn(strEspDocPermitido) + ') '
      Else
        strSQL := strSQL + ' WHERE (SELECT IFNULL(COUNT(CBI_NUMDUP), 0) ' +
                           '        FROM CADCBI ' +
                           '        WHERE CBI_NUMDUP=CTR_NUMDUP ' +
                           '          AND CBI_PARCEL=CTR_PARCEL ' +
                           '          AND CBI_ESPDOC=CTR_ESPDOC ' +
                           '          AND CBI_CODEMP=CTR_CODEMP ' +
                           '          AND CBI_CODCLI=CTR_CODCLI ) = 0 ';
    End;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;

      blnEspDocNaoPermitido := (strCodBco = 'BOA') And (blnMarca) And (RowsAffected < qryArqSer.RecordCount);

      LDuplicataExisteNaCADCBI := (strCodBco <> 'BOA') And (blnMarca) And (RowsAffected < qryArqSer.RecordCount);

      Close;
    End;

    qryArqSer.Close;
    qryArqSer.Open;

    (qryArqSer.FieldByName('CTR_VALDUP') as TFloatField).DisplayFormat := '#,##0.00';

    qryArqSer.RecNo := intRecNo;

    pAtualizaDadosContasReceber;
    pSetFocus(dbgDuplicatas);

    If (blnEspDocNaoPermitido) Then
      fMensagem('ATENÇÃO','Alguma(s) duplicata(s) não foi(ram) selecionada(s) pois possui(em) espécie de documento não permitida!', ['&OK']);

    If LDuplicataExisteNaCADCBI Then
      fMensagem('ATENÇÃO','Alguma(s) duplicata(s) não foi(ram) selecionada(s) pois já foi(ram) selecionada(s) para envio de remessa!', ['&OK']);
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmGeraArqSerasaSel.RetornaNumeroDuplicata(ANumDup: String): String;
begin
  Result := LeftStr(ANumDup, ANumDup.Length - 1);
  If ANumDup.Length > 13 Then
    Result := LeftStr(ANumDup, ANumDup.Length - 3);
end;

procedure TfrmGeraArqSerasaSel.btnProtestaClick(Sender: TObject);
begin
  inherited;
  pProtestaContasReceber;
  pAtualizaDadosContasReceber;
end;

procedure TfrmGeraArqSerasaSel.pProtestaContasReceber;
var
  strSQL: String;
  intRecNo: Integer;
  qryGen: TUniQuery;
begin
  try
    intRecNo := qryArqSer.RecNo;

    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '   TMP_GERSER ';
    strSQL := strSQL + 'SET ';

    If qryArqSer.FieldByName('CTR_PROTES').AsString = 'N' Then
      strSQL := strSQL + '   CTR_PROTES = "S" '
    Else
      strSQL := strSQL + '   CTR_PROTES = "N" ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := qryArqSer.FieldByName('CTR_NUMDUP').AsString;
      ParamByName('ESPDOC').AsString := qryArqSer.FieldByName('CTR_ESPDOC').AsString;
      ParamByName('CODEMP').AsString := qryArqSer.FieldByName('CTR_CODEMP').AsString;
      ParamByName('CODCLI').AsString := qryArqSer.FieldByName('CTR_CODCLI').AsString;
      ExecSQL;
      Close;
    End;

    With qryArqSer Do
    Begin
      Close;
      Open;

      (FieldByName('CTR_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';

      RecNo := intRecNo;
    End;

    pSetFocus(dbgDuplicatas);
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmGeraArqSerasaSel.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pCriarArquivoSerasa;
end;

procedure TfrmGeraArqSerasaSel.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  pSelTodosContasReceber(False);
end;

procedure TfrmGeraArqSerasaSel.FormShow(Sender: TObject);
begin
  inherited;
  qryArqSer.OnFilterRecord := pFilterRecord;
  dtsArqSer := TDataSource.Create(Self);
  dtsArqSer.DataSet := qryArqSer;
  dbgDuplicatas.DataSource := dtsArqSer;

  pSetFocus(dbgDuplicatas);
  pMudaOrdemContasReceber;
  pAtualizaDadosContasReceber;
end;

function TfrmGeraArqSerasaSel.fTemNaCadCbi(strNumDup, strEspDoc, strParcel,
  strCodEmp, strCodCli: String): Boolean;
  Var
    strSQL: String;
    qryCadCbi: TUniQuery;
begin
  qryCadCbi := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   COUNT(*) AS QTD, ';
  strSQL := strSQL + '   CBI_CODBCO ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADCBI ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CBI_NUMDUP = :NUMDUP ';
  strSQL := strSQL + '   AND CBI_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '   AND CBI_PARCEL = :PARCEL ';
  strSQL := strSQL + '   AND CBI_CODEMP = :CODEMP ';
  strSQL := strSQL + '   AND CBI_CODCLI = :CODCLI ';
  strSQL := strSQL + '   AND CBI_CODBCO = "SER" ';

  With qryCadCbi Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('PARCEL').AsString := strParcel;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;
    Open;

    Result := FieldByName('QTD').AsInteger > 0;
  End;

  FreeAndNil(qryCadCbi);

end;

function TfrmGeraArqSerasaSel.fTotalDup: string;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   SUM(CTR_VALDUP) AS CTR_TOTDUP ';
    strSQL := strSQL + ' FROM TMP_GERSER ';
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;
    Result := FormatFloat('#,##0.00', qryGen.FieldByName('CTR_TOTDUP').AsFloat);
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmGeraArqSerasaSel.fTotalDupSel: String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + ' SUM(CTR_VALDUP) AS CTR_TOTDUP ';
    strSQL := strSQL + ' FROM TMP_GERSER ';
    strSQL := strSQL + ' WHERE CTR_MARCAD = "M" ';
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;
    Result := FormatFloat('#,##0.00', qryGen.FieldByName('CTR_TOTDUP').AsFloat);
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmGeraArqSerasaSel.pConfirmaDupSerasa;
  Var
    LDtaDev: TDatetime;
begin

  If qryArqSer.IsEmpty Then
    Exit;

  Try
    Try
      fStartTransaction;

      qryArqSer.DisableControls;

      With qryArqSer Do
      Begin
        First;

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          {***********************************}
          {* PASSA APENAS SE ESTIVER MARCADO *}
          {********************************JU*}
          If FieldByName('CTR_MARCAD').AsString = 'M' Then
          Begin

            LDtaDev := 0;
            If (intOpcao <> 1) Then
              LDtaDev := FieldByName('DET_DTADEV').AsDateTime;

            frmModuloCadCbi.pGravaCadCbiGer(RetornaNumeroDuplicata(FieldByName('CTR_NUMDUP').AsString),
                                            FieldByName('CTR_PROTES').AsString,
                                            fRetCgcCpf(FieldByName('CTR_CODCLI').AsString),
                                            FieldByName('CTR_PARCEL').AsString,
                                            FieldByName('CTR_ESPDOC').AsString,
                                            FieldByName('CTR_CODEMP').AsString,
                                            FieldByName('CTR_CODCLI').AsString,
                                            IIF(fEmptyStr(strCodBco), 'SER', strCodBco),
                                            '',
                                            '',
                                            '',
                                            FieldByName('CTR_DTACAD').AsDateTime,
                                            FieldByName('CTR_DTAVEN').AsDateTime,
                                            FieldByName('CTR_VALDUP').AsCurrency,
                                            0,
                                            FieldByName('CTR_OBSAG1').AsString,
                                            FieldByName('CTR_OBSAG2').AsString,
                                            FieldByName('CTR_OBSAG3').AsString,
                                            '',
                                            '',
                                            0,
                                            '',
                                            '',
                                            IIF(intOpcao = 1, 'I', 'E'),
                                            dtaDtaIni,
                                            dtaDtaFin,
                                            '',
                                            False,
                                            LDtaDev);
          End;

          Next;
        End;
      End;

      fCommit;
      fMensagem('','Seleção efetuada com sucesso!',['&O K']);

      btnSair.Click;
    Except
      On E:Exception Do
      Begin
        fRollBack;

        raise Exception.CreateFmt(
          'Ocorreu um erro ao tentar gravar os dados da duplicata: ' + #13#10 +
          'Duplicata: %s' + #13#10 +
          'Parcela: %s' + #13#10 +
          'Espécie: %s' + #13#10 +
          'Empresa: %s' + #13#10 +
          'Cliente: %s-%s' + #13#10 + #13#10 + '%s',[
            qryArqSer.FieldByName('CTR_NUMDUP').AsString,
            qryArqSer.FieldByName('CTR_PARCEL').AsString,
            qryArqSer.FieldByName('CTR_ESPDOC').AsString,
            qryArqSer.FieldByName('CTR_CODEMP').AsString,
            qryArqSer.FieldByName('CTR_CODCLI').AsString,
            qryArqSer.FieldByName('CLI_NOMCLI').AsString,
            E.Message]);
      End;
    End;
  Finally
    qryArqSer.EnableControls;
  End;

end;

procedure TfrmGeraArqSerasaSel.pCriarArquivoSerasa;
Begin
  If fdupMarcadas Then
  Begin
    pConfirmaDupSerasa;
    Close;
  End
  Else
    fMensagem(Application.Title, 'Não existem duplicatas selecionadas', ['&O K'])
end;

function TfrmGeraArqSerasaSel.fdupMarcadas: Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + ' COUNT(*) AS QUANT ';
    strSQL := strSQL + ' FROM TMP_GERSER ';
    strSQL := strSQL + ' WHERE CTR_MARCAD = "M"' ;
    qryGen.Close;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;
    Result := (qryGen.FieldByName('QUANT').AsInteger > 0);
    qryGen.Close;
  Finally
    FreeAndNil(qryGen);
  end;
end;

procedure TfrmGeraArqSerasaSel.btnOrdemKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Escape: btnSair.Click;
    VK_Space : pSelecionaDuplicataContasReceber;
    VK_F3    : btnOrdem.Click;
    VK_F5    : btnBusca.Click;
    VK_F6    : btnProximo.Click;
    VK_F7    : btnSelTodos.Click;
    VK_F8    : btnDesmarcaTodos.Click;
    VK_F10   : btnConfirma.Click;
  End;
end;

procedure TfrmGeraArqSerasaSel.dbgDuplicatasKeyDown(Sender: TObject;
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
    VK_F5    : btnBusca.Click;
    VK_F6    : btnProximo.Click;
    VK_F7    : btnSelTodos.Click;
    VK_F8    : btnDesmarcaTodos.Click;
    VK_F10   : btnConfirma.Click;
  End;
end;

end.
