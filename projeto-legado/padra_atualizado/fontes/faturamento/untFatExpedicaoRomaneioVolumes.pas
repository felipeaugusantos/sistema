unit untFatExpedicaoRomaneioVolumes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Grids,
  DBGrids, EditFocus, UniDataSetProvider, DB, UniClientDataSet, untAtualizaOcorrenciasCRM,
  Uni, Mask, DBCtrls, DBEditFocus, MaskEditFocus, strUtils, cxProgressBar,
  BitBtnLockedIncrem, MemDS, DBAccess, Provider, frxClass, frxExportCSVTestabilidade,
  DBGridCitel;

type
  TfrmFatExpedicaoRomaneioVolumes = class(TfrmPai)
    dtsPedidos: TDataSource;
    btnConfirma: TBitBtnLocked;
    dbgPedidos: TDBGridCitel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgPedidosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgPedidosKeyPress(Sender: TObject; var Key: Char);
    procedure dbgPedidosColEnter(Sender: TObject);
  private
    { Private declarations }
    blnUtilizaSeparacaoExclusiva: Boolean;
    procedure pAfterInsert(DataSet: TDataSet);
    procedure pBeforePost(DataSet: TDataSet);
    procedure pCarregaDocumentos;
    function fAtualizarVolumes(pgbStatus: TcxProgressBar = nil): Boolean;
    procedure pAtualizarVolumes;
  protected

  public
    { Public declarations }
    cdsPedidos: TUniClientDataSet;
    strNumeroRomaneio: String;
  end;

var
  frmFatExpedicaoRomaneioVolumes: TfrmFatExpedicaoRomaneioVolumes;

implementation

uses untFuncoesSimples, untRomGer, untFatRomTransMot, untGravando, untFuncFat;

{$R *.dfm}

{ TfrmFatBaixaRomaneio }

procedure TfrmFatExpedicaoRomaneioVolumes.pCarregaDocumentos;
  Var
    strSQL: String;
    qryDocumentos: TUniQuery;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CONCAT(GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP) AS NUMPED, ';
  strSQL := strSQL + '  GER_NUMDOC NUMDOC, ';
  strSQL := strSQL + '  GER_ESPDOC ESPDOC, ';
  strSQL := strSQL + '  GER_CODEMP CODEMP, ';
  strSQL := strSQL + '  IF(GER_NOMCON = "" OR GER_NOMCON IS NULL, CLI_NOMCLI, GER_NOMCON) NOMCLI, ';
  strSQL := strSQL + '  CID_NOMCID AS NOMCID, ';
  strSQL := strSQL + '  GER_CODVEN AS CODVEN, ';
  strSQL := strSQL + '  FGO_VOLUME AS VOLUME, ';
  strSQL := strSQL + '  IFNULL(AUX_VOLEXS, 0) AS VOLEXS, ';
  strSQL := strSQL + '  IFNULL(AUX_VOLEXN, 0) AS VOLEXN, ';
  strSQL := strSQL + '  0 AS VOLUME_ALTERADO  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ROMGERX ';
  strSQL := strSQL + '  INNER JOIN FATGOR ON FGO_NUMDOC = GER_NUMDOC AND ';
  strSQL := strSQL + '                       FGO_ESPDOC = GER_ESPDOC AND ';
  strSQL := strSQL + '                       FGO_CODEMP = GER_CODEMP AND ';
  strSQL := strSQL + '                       FGO_CODCLI = GER_CODCLI     ';
  strSQL := strSQL + '  LEFT  JOIN AUXGOR  ON AUX_SEQGER = FATGOR.AUTOINCREM ';
  strSQL := strSQL + '  LEFT  JOIN CADTRA  ON TRA_CODTRA = GER_CODTRA ';
  strSQL := strSQL + '  INNER JOIN CADCLI  ON GER_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  INNER JOIN CADCID  ON IF( GER_CIDCON IS NULL, CLI_CODCID, GER_CIDCON) = CID_CODCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
  strSQL := strSQL + '  GER_EMPROM = :EMPROM ';
  strSQL := strSQL + 'ORDER BY FGO_CODEMP, FGO_NUMDOC, FGO_ESPDOC ';

  qryDocumentos := fCriaQuery(nil);

  With qryDocumentos Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('NUMROM').AsString := strNumeroRomaneio;
    ParamByName('EMPROM').AsString := VS_strCodEmp;

    Open;
  End;

  cdsPedidos := fCriaClientDatset(qryDocumentos);
  cdsPedidos.AfterInsert := pAfterInsert;
  cdsPedidos.BeforePost  := pBeforePost;
  dtsPedidos.DataSet := cdsPedidos;
  cdsPedidos.First;

  FreeAndNil(qryDocumentos);
end;

procedure TfrmFatExpedicaoRomaneioVolumes.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If fPergunta('Confirma digitação dos Volumes?') Then
  Begin
    pAtualizarVolumes;
    ModalResult := mrOk;
  End;
end;

procedure TfrmFatExpedicaoRomaneioVolumes.pAfterInsert(DataSet: TDataSet);
begin
  DataSet.Cancel;
end;

procedure TfrmFatExpedicaoRomaneioVolumes.pAtualizarVolumes;
  Var
    frmAguarde: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fAtualizarVolumes;
    frmAguarde.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pFreeAndNil(frmAguarde);
end;

procedure TfrmFatExpedicaoRomaneioVolumes.pBeforePost(DataSet: TDataSet);
begin
  If blnUtilizaSeparacaoExclusiva Then
  Begin
    cdsPedidos.FieldByName('VOLEXN').AsFloat := cdsPedidos.FieldByName('VOLUME').AsFloat - cdsPedidos.FieldByName('VOLEXS').AsFloat;

    If fFormataFloat(cdsPedidos.FieldByName('VOLEXN').AsFloat, 3) < 0.0 Then
    Begin
      pMensagemOk('O campo "Volume dos itens de Separação não Exclusiva" não pode ficar negativo. '+
        'Ajuste o Volume para poder continuar (ele deve ser maior ou igual ao volume dos itens '+
        'de separação exclusiva) ou revise as configurações de cálculo de volume, pois o volume '+
        'dos itens de separação exclusiva devem seguir as configurações de cálculo de volume do Sistema.');
      Abort;
    End;

    If fFormataFloat(cdsPedidos.FieldByName('VOLUME').AsFloat, 3) <>
       fFormataFloat(cdsPedidos.FieldByName('VOLEXS').AsFloat + cdsPedidos.FieldByName('VOLEXN').AsFloat, 3) Then
    Begin
      pMensagemOk('O Volume deve ser igual à soma dos campos "Volume dos itens de Separação Exclusiva" e '+
        '"Volume dos itens de Separação Não Exclusiva". Realize o ajuste do campo do volume para poder continuar.');
      Abort;
    End;
  End;
end;

function TfrmFatExpedicaoRomaneioVolumes.fAtualizarVolumes(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    qryUpd: TUniQuery;
begin
  Try
    Result := True;

    If Not fStartTransaction Then
      Exit(False);

    pInformacao('Aguarde, Atualizando volumes dos pedidos.', pgbStatus);

    qryUpd := fCriaQuery;
    qryUpd.SQL.Add('SELECT * FROM FATGOR');
    qryUpd.SQL.Add('LEFT JOIN AUXGOR ON AUX_SEQGER = FATGOR.AUTOINCREM');
    qryUpd.SQL.Add('WHERE FGO_NUMDOC = :NUMDOC');
    qryUpd.SQL.Add('  AND FGO_ESPDOC = :ESPDOC');
    qryUpd.SQL.Add('  AND FGO_CODEMP = :CODEMP');

    cdsPedidos.First;

    While Not cdsPedidos.Eof Do
    Begin
      pProgresso(cdsPedidos.RecNo, cdsPedidos.RecordCount, pgbStatus);

      qryUpd.Close;
      qryUpd.ParamByName('NUMDOC').AsString := cdsPedidos.FieldByName('NUMDOC').AsString;
      qryUpd.ParamByName('ESPDOC').AsString := cdsPedidos.FieldByName('ESPDOC').AsString;
      qryUpd.ParamByName('CODEMP').AsString := cdsPedidos.FieldByName('CODEMP').AsString;
      qryUpd.Open;

      If fFormataFloat(qryUpd.FieldByName('FGO_VOLUME').AsFloat, 3) <>
         fFormataFloat(cdsPedidos.FieldByName('VOLUME').AsFloat, 3) Then
      Begin
        qryUpd.Edit;
        qryUpd.FieldByName('FGO_VOLUME').AsFloat := cdsPedidos.FieldByName('VOLUME').AsFloat;
        If blnUtilizaSeparacaoExclusiva Then
        Begin
          qryUpd.FieldByName('AUX_VOLEXN').AsFloat := cdsPedidos.FieldByName('VOLEXN').AsFloat;
          qryUpd.FieldByName('AUX_VOLEXS').AsFloat := cdsPedidos.FieldByName('VOLEXS').AsFloat;
        End;
        qryUpd.Post;

        cdsPedidos.Edit;
        cdsPedidos.FieldByName('VOLUME_ALTERADO').AsInteger := 1;
        cdsPedidos.Post;
      End;

      cdsPedidos.Next;
    End;

    If Result Then
      fCommit
    Else
      fRollback;

    If Result Then
      pMensagemOk('Atualização dos volumes concluída com sucesso!');

    FreeAndNil(qryUpd);
  Except
    On E: Exception Do
    Begin
      fRollback;
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmFatExpedicaoRomaneioVolumes.dbgPedidosColEnter(Sender: TObject);
begin
  inherited;
  If Assigned(cdsPedidos) And cdsPedidos.Active Then
    dbgPedidos.SelectedField := cdsPedidos.FindField('VOLUME');
end;

procedure TfrmFatExpedicaoRomaneioVolumes.dbgPedidosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: Begin
                 If cdsPedidos.State = dsEdit Then
                 Begin
                   cdsPedidos.Post;

                   If cdsPedidos.RecNo = cdsPedidos.RecordCount Then
                     pSetFocus(btnConfirma)
                   Else
                     cdsPedidos.Next;
                 End
                 Else
                   cdsPedidos.Edit;
               End;
  End;
end;

procedure TfrmFatExpedicaoRomaneioVolumes.dbgPedidosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Not CharInSet(Key, ['0'..'9', #8, #13]) Then Key := #0;
end;

procedure TfrmFatExpedicaoRomaneioVolumes.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgPedidos);
  dbgPedidosColEnter(dbgPedidos);
end;

procedure TfrmFatExpedicaoRomaneioVolumes.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(cdsPedidos) Then FreeAndNil(cdsPedidos);
end;

procedure TfrmFatExpedicaoRomaneioVolumes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10   : btnConfirma.Click;
    VK_ESCAPE: btnSair.Click;
  End;
end;

procedure TfrmFatExpedicaoRomaneioVolumes.FormShow(Sender: TObject);
begin
  inherited;
  blnUtilizaSeparacaoExclusiva := fCfgSis('SEPEXC', varBoolean);

  If Not blnUtilizaSeparacaoExclusiva Then
  Begin
    fFindColumnByName(dbgPedidos, 'VOLEXS').Visible := False;
    fFindColumnByName(dbgPedidos, 'VOLEXN').Visible := False;
    Self.Width := Self.Width - 200;
  End;

  pCarregaDocumentos;
end;

end.
