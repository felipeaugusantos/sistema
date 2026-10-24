unit untFatCancBaixaRomaneio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  EditFocus, UniDataSetProvider, DB, UniClientDataSet, Uni, BitBtnLockedIncrem,
  MemDS, DBAccess, Provider, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient;

type
  TfrmFatCancBaixaRomaneio = class(TfrmPai)
    pnlCabecalho: TPanel;
    lblRomaneio: TLabel;
    edtNumRom: TEditFocus;
    edtNomMot: TEditFocus;
    lblMotorista: TLabel;
    dbgDocumentos: TDBGridCitel;
    dtsDocumentos: TDataSource;
    cdsDocumentos: TUniClientDataSet;
    dspDocumentos: TUniDataSetProvider;
    qryDocumentos: TUniQuery;
    btnConfirma: TBitBtnLocked;
    edtCodMot: TEditFocus;
    pnlInfAdd: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    edtNomRec: TEditFocus;
    edtNomAj1: TEditFocus;
    edtNomAj2: TEditFocus;
    edtNomAj4: TEditFocus;
    edtNomAj3: TEditFocus;
    procedure dbgDocumentosDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodMotKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure cdsDocumentosAfterScroll(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure pCarregaDocumentos;
    procedure pCancelarBaixa;
    function fConfirmaBaixa: Boolean;
    function fPodeCancelarBaixaDeRomaneioDoAppTaEntregue: Boolean;
    function fVerificaPodeCancelarBaixaSemConferenciaVolumes: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmFatCancBaixaRomaneio: TfrmFatCancBaixaRomaneio;

implementation

uses untFuncoesSimples, untFatBaixaRomaneioObs, untHisPed, untConsultas,
     untRomGer, System.UITypes, untTypesSistema, untFuncoesCRM,
     untAtualizaOcorrenciasCRM, untTSituacaoPedidoVenda, untTypesCRM,
     untLiberacao;

{$R *.dfm}

{ TfrmFatCancBaixaRomaneio }

function TfrmFatCancBaixaRomaneio.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtNumRom) Then
  Begin

    If not fPodeCancelarBaixaDeRomaneioDoAppTaEntregue Then
    Begin
      pCancelarBaixa;
      Result := False;
    End
    Else if (not fVerificaPodeCancelarBaixaSemConferenciaVolumes) then
    Begin
      fMensagem('ATENÇÃO!', 'Não é possível cancelar a baixa do romaneio pois há documentos ' +
        'que tiveram a conferência de volumes realizada para inclusão em novo romaneio!', ['&Ok']);
      pCancelarBaixa;
      Result := False;
    End
    Else
    Begin
      pCarregaDocumentos;
      if cdsDocumentos.IsEmpty then
      begin
        fMensagem('ATENÇÃO!', 'Esse romaneio não existe ou não está baixado!', ['&Ok']);
        pCancelarBaixa;
        Result := False;
      end;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmFatCancBaixaRomaneio.fPodeCancelarBaixaDeRomaneioDoAppTaEntregue: Boolean;
var
  objLiberacao: TLiberacao;
begin
  if (not fBaixaFeitaPeloAppTaEntregue(edtNumRom.Text)) then
    Exit(True);

  if (fTemDocumentoNaoLiberadoPelasPendenciasDoPainelDeEntrega(edtNumRom.Text)) then
  begin
    fMensagem('ATENÇÃO!', 'Existem documentos nesse romaneio que não foram liberados nas pendências do Painel de Entrega.'+sLineBreak+
                          'Faça a liberação dos documentos antes de proseguir com o cancelamento da baixa do romaneio!', ['&Ok']);
    Exit(False);
  end;

  objLiberacao := TLiberacao.Create;

  try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Permitir cancelar baixa de romaneio feita pelo App Tá Entregue');
    objLiberacao.objMsgLibera.pAddTexto('Romaneio: ' + edtNumRom.Text);
    objLiberacao.strDirAce := 'RCBAPP';
    objLiberacao.strMsgSen := 'Permitir cancelar baixa de romaneio feita pelo App Tá Entregue';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  finally
    FreeAndNil(objLiberacao);
  end;
end;

function TfrmFatCancBaixaRomaneio.fVerificaPodeCancelarBaixaSemConferenciaVolumes: Boolean;
var
  LQry: TUniQuery;
begin
  Result := True;

  if (not fUtilizaConferenciaDocsRemovidosRomaneio) then
    Exit;

  LQry := fCriaQuery;

  try
    LQry.SQL.Add('SELECT COUNT(1) QTD ');
    LQry.SQL.Add('FROM ROMCNF ');
    LQry.SQL.Add('WHERE RCF_NUMROM = :NUMROM ');
    LQry.SQL.Add('  AND RCF_DTACNF IS NOT NULL ');
    LQry.ParamByName('NUMROM').AsString := edtNumRom.Text;
    LQry.Open;

    Result := (LQry.FieldByName('QTD').AsInteger = 0);
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmFatCancBaixaRomaneio.pCarregaDocumentos;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GER_ROMIMP, ';
  strSQL := strSQL + '  GER_DTAENT, ';
  strSQL := strSQL + '  GER_HORENT, ';
  strSQL := strSQL + '  CONCAT(GER_NUMDOC, "-", GER_ESPDOC) GER_NUMDOC, ';
  strSQL := strSQL + '  GER_NUMDOC GER_DOCORI, ';
  strSQL := strSQL + '  GER_ESPDOC GER_ESPORI, ';
  strSQL := strSQL + '  GER_CODCLI GER_CLIORI, ';
  strSQL := strSQL + '  GER_CODEMP, ';
  strSQL := strSQL + '  IF(GER_NOMCON = "" OR GER_NOMCON IS NULL, CLI_NOMCLI, GER_NOMCON) GER_NOMCLI, ';
  strSQL := strSQL + '  CID_NOMCID, ';
  strSQL := strSQL + '  GER_CODVEN, ';
  strSQL := strSQL + '  TRA_NOMTRA, ';
  strSQL := strSQL + '  FORMAT(GER_VLRCON, 2) GER_VLRCON, ';
  strSQL := strSQL + '  CONCAT(GER_CODMOT, "-", MOT_NOMMOT) MOT_NOMMOT, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ1, "-", A1.AJU_NOMAJU) AJU_NOMAJ1, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ2, "-", A2.AJU_NOMAJU) AJU_NOMAJ2, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ3, "-", A3.AJU_NOMAJU) AJU_NOMAJ3, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ4, "-", A4.AJU_NOMAJU) AJU_NOMAJ4, ';
  strSQL := strSQL + '  GER_NUMROM, ';
  strSQL := strSQL + '  GER_DTABAI, ';
  strSQL := strSQL + '  GER_HORBAI, ';
  strSQL := strSQL + '  GER_NOMREC, ';
  strSQL := strSQL + '  "M" GER_MARDES, ';
  strSQL := strSQL + '  GER_NOMREC, ';
  strSQL := strSQL + '  REPEAT(" ", 10000) GER_OBSERV, ';
  strSQL := strSQL + '  "ROMGERX" AS TABELA ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ROMGERX ';
  strSQL := strSQL + '  LEFT JOIN CADTRA    ON TRA_CODTRA = GER_CODTRA ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A1 ON GER_CODAJ1 = A1.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A2 ON GER_CODAJ2 = A2.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A3 ON GER_CODAJ3 = A3.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A4 ON GER_CODAJ4 = A4.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADMOT    ON GER_CODMOT = MOT_CODMOT ';
  strSQL := strSQL + '  LEFT JOIN CADCLI    ON GER_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADCID ON IF( GER_CIDCON IS NULL, CLI_CODCID, GER_CIDCON) = CID_CODCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
  strSQL := strSQL + '  GER_EMPROM = :EMPROM AND ';
  strSQL := strSQL + '  GER_DTABAI IS NOT NULL ';

  strSQL := strSQL + '  UNION ';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GER_ROMIMP, ';
  strSQL := strSQL + '  GER_DTAENT, ';
  strSQL := strSQL + '  GER_HORENT, ';
  strSQL := strSQL + '  CONCAT(GER_NUMDOC, "-", GER_ESPDOC) GER_NUMDOC, ';
  strSQL := strSQL + '  GER_NUMDOC GER_DOCORI, ';
  strSQL := strSQL + '  GER_ESPDOC GER_ESPORI, ';
  strSQL := strSQL + '  GER_CODCLI GER_CLIORI, ';
  strSQL := strSQL + '  GER_CODEMP, ';
  strSQL := strSQL + '  IF(GER_NOMCON = "" OR GER_NOMCON IS NULL, CLI_NOMCLI, GER_NOMCON) GER_NOMCLI, ';
  strSQL := strSQL + '  CID_NOMCID, ';
  strSQL := strSQL + '  GER_CODVEN, ';
  strSQL := strSQL + '  TRA_NOMTRA, ';
  strSQL := strSQL + '  FORMAT(GER_VLRCON, 2) GER_VLRCON, ';
  strSQL := strSQL + '  CONCAT(GER_CODMOT, "-", MOT_NOMMOT) MOT_NOMMOT, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ1, "-", A1.AJU_NOMAJU) AJU_NOMAJ1, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ2, "-", A2.AJU_NOMAJU) AJU_NOMAJ2, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ3, "-", A3.AJU_NOMAJU) AJU_NOMAJ3, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ4, "-", A4.AJU_NOMAJU) AJU_NOMAJ4, ';
  strSQL := strSQL + '  GER_NUMROM, ';
  strSQL := strSQL + '  GER_DTABAI, ';
  strSQL := strSQL + '  GER_HORBAI, ';
  strSQL := strSQL + '  GER_NOMREC, ';
  strSQL := strSQL + '  "M" GER_MARDES, ';
  strSQL := strSQL + '  GER_NOMREC, ';
  strSQL := strSQL + '  REPEAT(" ", 10000) GER_OBSERV, ';
  strSQL := strSQL + '  "DEL_ROMGERX" AS TABELA ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  DEL_ROMGERX ';
  strSQL := strSQL + '  LEFT JOIN CADTRA    ON TRA_CODTRA = GER_CODTRA ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A1 ON GER_CODAJ1 = A1.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A2 ON GER_CODAJ2 = A2.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A3 ON GER_CODAJ3 = A3.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A4 ON GER_CODAJ4 = A4.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADMOT    ON GER_CODMOT = MOT_CODMOT ';
  strSQL := strSQL + '  LEFT JOIN CADCLI    ON GER_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADCID ON IF( GER_CIDCON IS NULL, CLI_CODCID, GER_CIDCON) = CID_CODCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
  strSQL := strSQL + '  GER_EMPROM = :EMPROM AND ';
  strSQL := strSQL + '  GER_DTABAI IS NOT NULL ';

  cdsDocumentos.Close;
  qryDocumentos.Close;

  qryDocumentos.SQL.Clear;
  qryDocumentos.SQL.Add(strSQL);

  qryDocumentos.ParamByName('NUMROM').AsString := edtNumRom.Text;
  qryDocumentos.ParamByName('EMPROM').AsString := VS_strCodEmp;

  qryDocumentos.Open;
  pSetaClient(qryDocumentos);
  cdsDocumentos.Open;
  cdsDocumentos.DisableControls;

  While (Not cdsDocumentos.Eof) Do
  Begin
    cdsDocumentos.Edit;
    cdsDocumentos.FieldByName('GER_OBSERV').AsString := '';
    cdsDocumentos.Post;
    cdsDocumentos.Next;
  End;
  cdsDocumentos.First;

  cdsDocumentos.EnableControls;

  edtNomMot.Text := cdsDocumentos.FieldByName('MOT_NOMMOT').AsString;
end;

procedure TfrmFatCancBaixaRomaneio.dbgDocumentosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If (Not cdsDocumentos.Active) Then
    Exit;

  If (cdsDocumentos.IsEmpty) Then
    Exit;

  If cdsDocumentos.FieldByName('GER_MARDES').AsString = 'M' Then
  Begin
    If dbgDocumentos.Canvas.Brush.Color = clHighLight Then
    Begin
      dbgDocumentos.Canvas.Font.Color := clLime;
    End
    Else
    Begin
      dbgDocumentos.Canvas.Font.Color := clBlue;
    End;
  End;

  dbgDocumentos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmFatCancBaixaRomaneio.dbgDocumentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) And (Not cdsDocumentos.IsEmpty) Then
  Begin
    If fMensagem('', 'Deseja realmente abortar a operação?', ['&Sim', '&Não']) = 2 Then
    Begin
      Exit;
    End;
    pCancelarBaixa;
  End
  Else If (Key = VK_ESCAPE) And (cdsDocumentos.IsEmpty) Then
    pSetFocus(edtNumRom);
end;

procedure TfrmFatCancBaixaRomaneio.pCancelarBaixa;
begin
  cdsDocumentos.Close;
  edtNomMot.Clear;
  edtNumRom.Clear;
  edtNomRec.Clear;
  pSetFocus(edtNumRom);
end;

function TfrmFatCancBaixaRomaneio.fConfirmaBaixa: Boolean;
  Var
    strEntreg: String;
    objHisPed: THisPed;
    intContador: Integer;
    objOcoCrm : TAtuOcoCrm;
    qryPedido: TUniQuery;

    procedure fAtualizaInformacoesCRMLocal(strNumDoc, strEspDoc, strCodEmp: String; strNumOrc: String = ''; strEspOrc: String = '');
    begin
      objOcoCrm := fAtualizaInformacoesCRM(strNumDoc,
                                           strEspDoc,
                                           strCodEmp,
                                           cdsDocumentos.FieldByName('GER_CLIORI').AsString,
                                           strNumOrc,
                                           strEspOrc,
                                           strLoginUsuarioLogado,
                                           afcRomaneioCancelamento);

      objOcoCrm.strDHBaix := FormatDateTime('dd/mm/yyyy', VS_Date) + ' ' + FormatDateTime('hh:mm:ss', fNow);
      objOcoCrm.strNumRom := cdsDocumentos.FieldByName('GER_NUMROM').AsString;
      objOcoCrm.blnReabreOcorrencia := True;
      TAtuOcoCrm(objOcoCrm).pProcessaFatOcorrenciasCRM;
    end;

begin

  Result := False;

  cdsDocumentos.DisableControls;
  objHisPed := THisPed.Create(Self);
  qryPedido := fCriaQuery(Self);
  qryPedido.SQL.Add('SELECT DISTINCT FDO_NUMDOC AS FGO_NUMDOC, FDO_ESPDOC AS FGO_ESPDOC, FDO_CODEMP AS FGO_CODEMP');
  qryPedido.SQL.Add('FROM FATDOR');
  qryPedido.SQL.Add('WHERE FDO_NUMFAT = :NUMDOC');
  qryPedido.SQL.Add('  AND FDO_TIPFAT = :ESPDOC');
  qryPedido.SQL.Add('  AND FDO_EMPFAT = :CODEMP');
  qryPedido.SQL.Add(fSQLPDRomaneioPeloDocConf);

  Try
    Try
      cdsDocumentos.First;
      fStartTransaction;
      intContador := 0;

      While (Not cdsDocumentos.Eof) Do
      Begin
        if cdsDocumentos.FieldByName('TABELA').AsString = 'DEL_ROMGERX' then
        begin
          if not fReverterDEL('DEL_ROMGERX',
                              ['GER_NUMROM',
                               'GER_EMPROM',
                               'GER_NUMDOC',
                               'GER_ESPDOC',
                               'GER_CODEMP',
                               'GER_CODCLI'],
                               [cdsDocumentos.FieldByName('GER_NUMROM').AsString,
                                VS_strCodEmp,
                                cdsDocumentos.FieldByName('GER_DOCORI').AsString,
                                cdsDocumentos.FieldByName('GER_ESPORI').AsString,
                                cdsDocumentos.FieldByName('GER_CODEMP').AsString,
                                cdsDocumentos.FieldByName('GER_CLIORI').AsString]) then
            raise Exception.Create('Ocorreu um erro. Entre em contato com a Citel!');

          if not fReverterDEL('DEL_ROMDETX',
                             ['DET_NUMROM',
                              'DET_EMPROM',
                              'DET_NUMDOC',
                              'DET_ESPDOC',
                              'DET_CODEMP',
                              'DET_CODCLI'],
                              [cdsDocumentos.FieldByName('GER_NUMROM').AsString,
                               VS_strCodEmp,
                               cdsDocumentos.FieldByName('GER_DOCORI').AsString,
                               cdsDocumentos.FieldByName('GER_ESPORI').AsString,
                               cdsDocumentos.FieldByName('GER_CODEMP').AsString,
                               cdsDocumentos.FieldByName('GER_CLIORI').AsString]) then
            raise Exception.Create('Ocorreu um erro. Entre em contato com a Citel!');
        end;

        If (cdsDocumentos.FieldByName('GER_MARDES').AsString = 'M') Then
          strEntreg := 'S'
        Else
          strEntreg := 'N';

        {*****************************************************************}
        {*GRAVA NA TABELA DE LOG(LOGROM) A DATA, HORA E NOME DO RECEBEDOR*}
        {*REFERENTE AO ROMANEIO QUE TEVE SUA BAIXA CANCELADA             *}
        {**************************************************************PZ*}
        If(intContador = 0) Then
        Begin
          fGravaLogRom(cdsDocumentos.FieldByName('GER_NUMROM').AsString,
                    'GER_DTABAI',
                    cdsDocumentos.FieldByName('GER_DTABAI').AsString,
                    'NULL');

          fGravaLogRom(cdsDocumentos.FieldByName('GER_NUMROM').AsString,
                    'GER_HORBAI',
                    cdsDocumentos.FieldByName('GER_HORBAI').AsString,
                    'NULL');

          fGravaLogRom(cdsDocumentos.FieldByName('GER_NUMROM').AsString,
                    'GER_NOMREC',
                    cdsDocumentos.FieldByName('GER_NOMREC').AsString,
                    'NULL');

          intContador := 1;
        End;

        Result := objHisPed.fAtualizarHistorico(cdsDocumentos.FieldByName('GER_DOCORI').AsString,
                                                cdsDocumentos.FieldByName('GER_ESPORI').AsString,
                                                cdsDocumentos.FieldByName('GER_CODEMP').AsString,
                                                cdsDocumentos.FieldByName('GER_NUMROM').AsString,
                                                '',
                                                0,
                                                0,
                                                '',
                                                '');

        If (Not Result) Then
        Begin
          Exit;
        End;

        If strEntreg = 'N' Then
        Begin
          Result := fRemoverDocumento(cdsDocumentos.FieldByName('GER_DOCORI').AsString,
                                      cdsDocumentos.FieldByName('GER_ESPORI').AsString,
                                      cdsDocumentos.FieldByName('GER_CODEMP').AsString,
                                      cdsDocumentos.FieldByName('GER_CLIORI').AsString,
                                      cdsDocumentos.FieldByName('GER_NUMROM').AsString,
                                      cdsDocumentos.FieldByName('GER_CODVEN').AsString,
                                      cdsDocumentos.FieldByName('GER_CODMOT').AsString,
                                      cdsDocumentos.FieldByName('GER_DTAENT').AsDateTime,
                                      cdsDocumentos.FieldByName('GER_HORENT').AsDateTime,
                                      cdsDocumentos.FieldByName('GER_OBSERV').AsString);
        End
        Else
        Begin
          Result := fBaixarDocumento(cdsDocumentos.FieldByName('GER_DOCORI').AsString,
                                     cdsDocumentos.FieldByName('GER_ESPORI').AsString,
                                     cdsDocumentos.FieldByName('GER_CODEMP').AsString,
                                     cdsDocumentos.FieldByName('GER_CLIORI').AsString,
                                     cdsDocumentos.FieldByName('GER_NUMROM').AsString,
                                     '',
                                     0,
                                     0,
                                     'N');

          If (Result) And (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
          begin
            If fCfgSis('OPCROM', varInteger) = 1 Then
            Begin
              fAtualizaInformacoesCRMLocal(cdsDocumentos.FieldByName('GER_DOCORI').AsString,
                                           cdsDocumentos.FieldByName('GER_ESPORI').AsString,
                                           cdsDocumentos.FieldByName('GER_CODEMP').AsString);
            End
            Else
            Begin
              qryPedido.Close;
              qryPedido.ParamByName('NUMDOC').AsString := cdsDocumentos.FieldByName('GER_DOCORI').AsString;
              qryPedido.ParamByName('ESPDOC').AsString := cdsDocumentos.FieldByName('GER_ESPORI').AsString;
              qryPedido.ParamByName('CODEMP').AsString := cdsDocumentos.FieldByName('GER_CODEMP').AsString;
              qryPedido.Open;

              If Not qryPedido.IsEmpty Then
              Begin
                qryPedido.First;
                While Not qryPedido.Eof Do
                Begin
                  fAtualizaInformacoesCRMLocal(cdsDocumentos.FieldByName('GER_DOCORI').AsString,
                                               cdsDocumentos.FieldByName('GER_ESPORI').AsString,
                                               qryPedido.FieldByName('FGO_CODEMP').AsString,
                                               qryPedido.FieldByName('FGO_NUMDOC').AsString,
                                               qryPedido.FieldByName('FGO_ESPDOC').AsString);


                  qryPedido.Next;
                End;
              End;
            End;
          end;

        End;

        If fCfgSis('EXISTA', varBoolean) And (Result) Then
        Begin
          qryPedido.Close;
          qryPedido.ParamByName('NUMDOC').AsString := cdsDocumentos.FieldByName('GER_DOCORI').AsString;
          qryPedido.ParamByName('ESPDOC').AsString := cdsDocumentos.FieldByName('GER_ESPORI').AsString;
          qryPedido.ParamByName('CODEMP').AsString := cdsDocumentos.FieldByName('GER_CODEMP').AsString;
          qryPedido.Open;

          If Not qryPedido.IsEmpty Then
          Begin
            qryPedido.First;
            While Not qryPedido.Eof Do
            Begin
              TUpdateStatus.New(TParamStatus.New()
                                  .NumDoc(qryPedido.FieldByName('FGO_NUMDOC').AsString)
                                  .EspDoc(qryPedido.FieldByName('FGO_ESPDOC').AsString)
                                  .CodEmp(qryPedido.FieldByName('FGO_CODEMP').AsString)).pExecute();


              qryPedido.Next;
            End;
          End;
        End;

        If (Not Result) Then
        Begin
          Exit;
        End;

        cdsDocumentos.Next;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fConfirmaBaixa]');
      End;
    End;

  Finally
    If Assigned(objHisPed) Then
      FreeAndNil(objHisPed);

    If Assigned(qryPedido) Then
      FreeAndNil(qryPedido);

    cdsDocumentos.EnableControls;

    If (Result) Then
    Begin
      fCommit;
    End
    Else
      fRollBack;
  End;
end;

procedure TfrmFatCancBaixaRomaneio.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If Not cdsDocumentos.IsEmpty Then
  Begin
    If fMensagem('', 'Confirma o cancelamento do romaneio ' + edtNumRom.Text + '?', ['&Sim', '&Não']) = 2 Then
      Exit;

    If fConfirmaBaixa Then
    Begin
      fMensagem('', 'Cancelamento concluído com sucesso!', ['&Ok']);
      pCancelarBaixa;
    End;
  End
  Else
    fMensagem('', 'Não existem documentos para serem cancelados!', ['&Ok']);
end;

procedure TfrmFatCancBaixaRomaneio.edtCodMotKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrMot: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE MOTORISTAS *}
  {****************************RV*}
  If fPesqMotorista(Self, edtCodMot, edtNomMot, Nil, Key, arrMot) Then
  Begin
    If fValidaCampos(edtCodMot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatCancBaixaRomaneio.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtNumRom);
end;

procedure TfrmFatCancBaixaRomaneio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_F10 Then
  Begin
    Key := 0;
    btnConfirma.Click;
  End
  Else If (Key = VK_ESCAPE) And (Not cdsDocumentos.IsEmpty) Then
  Begin
    If fMensagem('', 'Deseja realmente abortar a operação?', ['&Sim', '&Não']) = 2 Then
    Begin
      Exit;
    End;
    pCancelarBaixa;
  End
  Else
    inherited;
end;

procedure TfrmFatCancBaixaRomaneio.FormShow(Sender: TObject);
begin
  inherited;
  edtNomMot.Left    := edtCodMot.Left;
  edtNomMot.Width   := edtNomMot.Width + edtCodMot.Width;
  edtCodMot.Visible := False;
  lblMotorista.Top  := 38;
  edtNomMot.Top     := 51;
  pSetFocus(edtNumRom);
end;

procedure TfrmFatCancBaixaRomaneio.cdsDocumentosAfterScroll(
  DataSet: TDataSet);
begin
  inherited;

  If (cdsDocumentos.Active) And (Not cdsDocumentos.IsEmpty) Then
  Begin
    edtNomRec.Text := cdsDocumentos.FieldByName('GER_NOMREC').AsString;
    edtNomAj1.Text := cdsDocumentos.FieldByName('AJU_NOMAJ1').AsString;
    edtNomAj2.Text := cdsDocumentos.FieldByName('AJU_NOMAJ2').AsString;
    edtNomAj3.Text := cdsDocumentos.FieldByName('AJU_NOMAJ3').AsString;
    edtNomAj4.Text := cdsDocumentos.FieldByName('AJU_NOMAJ4').AsString;
  End
  Else
  Begin
    edtNomRec.Text := '';
    edtNomAj1.Text := '';
    edtNomAj2.Text := '';
    edtNomAj3.Text := '';
    edtNomAj4.Text := '';
  End;

end;

end.
