unit untPainelFusion;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Datasnap.DBClient,
  UniClientDataSet, Datasnap.Provider, UniDataSetProvider, MemDS, DBAccess, Uni,
  Vcl.Mask, MaskEditFocus, EditFocus, untTypesSistema;

type
  TfrmPainelFusion = class(TfrmPai)
    pnlFiltros: TPanel;
    pnlRodape: TPanel;
    cxgPedidos: TcxGrid;
    cxgPedidosDBTableView: TcxGridDBTableView;
    cxgPedidosLevel: TcxGridLevel;
    btnReenviar: TBitBtnLocked;
    btnRegrasDeEnvio: TBitBtnLocked;
    btnCarregar: TBitBtnLocked;
    qryPedidos: TUniQuery;
    dtsPedidos: TDataSource;
    cxgPedidosDBTableViewDOCUMENTO: TcxGridDBColumn;
    cxgPedidosDBTableViewEMPDOC: TcxGridDBColumn;
    cxgPedidosDBTableViewDTAEMI: TcxGridDBColumn;
    cxgPedidosDBTableViewCLIENTE: TcxGridDBColumn;
    cxgPedidosDBTableViewEMPFAT: TcxGridDBColumn;
    cxgPedidosDBTableViewSTATUS: TcxGridDBColumn;
    cxgPedidosDBTableViewNUMROM: TcxGridDBColumn;
    cxgPedidosDBTableViewEMPROM: TcxGridDBColumn;
    lblStatus: TLabel;
    chkAguardandoEnvio: TCheckBox;
    chkEnviado: TCheckBox;
    chkRoteirizado: TCheckBox;
    lblEmissaoDoPedido: TLabel;
    mskDtaIni: TMaskEditFocus;
    lblA: TLabel;
    mskDtaFin: TMaskEditFocus;
    lblEmp: TLabel;
    edtEmpFat: TEditFocus;
    edtNomEmpFat: TEditFocus;
    edtNumPed: TEditFocus;
    lblPedido: TLabel;
    lblEmpresa: TLabel;
    edtEmpPed: TEditFocus;
    edtNomEmpPed: TEditFocus;
    procedure btnCarregarClick(Sender: TObject);
    procedure edtEmpPedExit(Sender: TObject);
    procedure edtEmpFatExit(Sender: TObject);
    procedure edtEmpPedKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpFatKeyPress(Sender: TObject; var Key: Char);
    procedure btnRegrasDeEnvioClick(Sender: TObject);
    procedure btnReenviarClick(Sender: TObject);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private
    arrEmp : TConsultasArray;

    function GetSQL : String;
    function fGetSQLOpcRom_1: String;
    function fGetSQLOpcRom_2: String;
    function GetStatus : String;
    procedure SetParametros;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untFuncoesConsulta, untConsultas, untObservacao,
  untRomaneioTarefasFusion;

{ TfrmPainelFusion }

procedure TfrmPainelFusion.btnCarregarClick(Sender: TObject);
begin
  inherited;

  If chkAguardandoEnvio.Checked And chkEnviado.Checked And chkRoteirizado.Checked Then
  Begin
    If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Or
       (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe um período de emissão dos documentos para não sobrecarregar a consulta!', ['&OK']);
      Exit;
    End;
  End;

  qryPedidos.Close;
  qryPedidos.SQL.Clear;
  qryPedidos.SQL.Add(GetSQL);

  SetParametros;
  qryPedidos.Open;

end;

procedure TfrmPainelFusion.btnReenviarClick(Sender: TObject);
begin
  inherited;

  If Not qryPedidos.Active Then
    Exit;

  If qryPedidos.IsEmpty Then
    Exit;

  If Not qryPedidos.FieldByName('INTFUS').AsString.Equals('E') Then
    Exit;

  If (fMensagem('', 'Deseja reenviar o documento ' + qryPedidos.FieldByName('NUMDOC').AsString + '?', ['&Sim', '&Não'], 2) = 2) Then
    Exit;

  TRomaneioTarefasFusion.pInsereTarFus('',
                                       '',
                                       qryPedidos.FieldByName('NUMDOC').AsString,
                                       qryPedidos.FieldByName('ESPDOC').AsString,
                                       qryPedidos.FieldByName('EMPDOC').AsString,
                                       'A');

  fMensagem('ATENÇÃO!', 'Documento reenviado com sucesso!', ['&OK']);

end;

procedure TfrmPainelFusion.btnRegrasDeEnvioClick(Sender: TObject);
  var
    LRegras : TStringList;
begin
  inherited;

  LRegras := TStringList.Create;

  Try

    LRegras.Add(' - STATUS INTEGRAÇÃO (NÃO ENVIADO)');
    LRegras.Add(' - ESPÉCIE '+IIF(fCfgSis('OPCROM', varInteger) = 2, '(NF, IF)', '(PD)'));

    if fCfgSis('OPCROM', varInteger) = 1 then
      LRegras.Add(' - LIBERAÇÃO DE PEDIDOS - FINANCEIRO E COMERCIAL');

    LRegras.Add(' - DESTINO (ENTREGA IMEDIATA)');
    LRegras.Add(' - CFOP CONFIGURADA NA [CFG_CLAVEN]');

    if fCfgSis('OPCROM', varInteger) = 1 then
      LRegras.Add(' - SE CONDIÇÃO (A VISTA), POSSUIR ADIANTAMENTO');

    LRegras.Add(' - TRANSPORTADOR MARCADA COMO (INTEGRAÇÃO FUSION)');

    if fCfgSis('OPCROM', varInteger) = 1 then
      LRegras.Add(' - NÃO FATURADO');

    LRegras.Add(' - NÃO POSSUIR ROMANEIO');

    TfrmObservacao.fObservacao('Regras de Envio:', LRegras.Text);

  Finally
    FreeAndNil(LRegras);
  End;

end;

procedure TfrmPainelFusion.edtEmpFatExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtEmpFat, edtNomEmpFat, arrEmp, fRetNomeEmpresa, Nil, 'da Empresa', 0, False, 'Código', True);
end;

procedure TfrmPainelFusion.edtEmpFatKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if fPesqEmpresa(conEmpSimples, Self, edtEmpFat, edtNomEmpFat, Nil, Key, arrEmp, False, True) then
  begin
    if fValidaCampos(edtEmpFat) then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmPainelFusion.edtEmpPedExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtEmpPed, edtNomEmpPed, arrEmp, fRetNomeEmpresa, Nil, 'da Empresa', 0, False, 'Código', True);
end;

procedure TfrmPainelFusion.edtEmpPedKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if fPesqEmpresa(conEmpSimples, Self, edtEmpPed, edtNomEmpPed, Nil, Key, arrEmp, False, True) then
  begin
    if fValidaCampos(edtEmpPed) then
      SelectNext(ActiveControl, True, True);
  end;
end;

function TfrmPainelFusion.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = edtNumPed) then
    Begin
      If (blnBuscaPorChave) And (Not fEmptyStr(edtNumPed.Text)) Then
      Begin
        edtNumPed.Text := fStrZero(edtNumPed.Text, edtNumPed.TamCampo);
      End;
    End

    Else If (Sender = mskDtaIni) Then
    Begin

      If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        mskDtaFin.Clear;
        mskDtaFin.Enabled := False;
      End
      Else
        mskDtaFin.Enabled := True;

    End

    Else If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
         (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
      Begin
        If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&OK']);
          Result := False;
        End;
      End;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmPainelFusion.GetSQL: String;
begin
  Result := IIF(fCfgSis('OPCROM', varInteger) = 2, fGetSQLOpcRom_2, fGetSQLOpcRom_1);
end;

function TfrmPainelFusion.fGetSQLOpcRom_1: String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  CASE ';
  Result := Result + '    WHEN (FGO_INTFUS = "N") THEN "Aguardando envio" ';
  Result := Result + '    WHEN (FGO_INTFUS = "E") THEN "Enviado"          ';
  Result := Result + '    WHEN (FGO_INTFUS = "R") THEN "Roteirizado"      ';
  Result := Result + '    ELSE ""                                         ';
  Result := Result + '  END AS STATUS,                                    ';

  Result := Result + '  FGO_INTFUS AS INTFUS, ';

  Result := Result + '  FGO_NUMDOC AS NUMDOC, ';
  Result := Result + '  FGO_ESPDOC AS ESPDOC, ';
  Result := Result + '  FGO_CODEMP AS EMPDOC, ';
  Result := Result + '  CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP) AS DOCUMENTO, ';
  Result := Result + '  CONCAT(FGO_CODCLI, " - ", CLI_NOMCLI) AS CLIENTE,                  ';
  Result := Result + '  FGO_DTAENT AS DTAEMI, ';
  Result := Result + '  IF(FGO_EMPFAT <> "", FGO_EMPFAT, IF(FDO_EMPFAT <> "", FDO_EMPFAT, IF(FGO_ENT_CD = "S", FGO_EMP_CD, FDO_EMPITE))) AS EMPFAT, ';
  Result := Result + '  FGO_NUMROM NUMROM,    ';
  Result := Result + '  FGO_EMPROM EMPROM,    ';
  Result := Result + '  FGO_CONPAG,           ';

  Result := Result + '  IFNULL((SELECT SUM(IF(ADT_TIPLAN = "C", ADT_VALLAN, -ADT_VALLAN)) ';
  Result := Result + '          FROM ADTCLI                                               ';
  Result := Result + '          WHERE ADT_NUMDOC = F.FGO_NUMDOC                           ';
  Result := Result + '            AND ADT_ESPDOC = F.FGO_ESPDOC                           ';
  Result := Result + '            AND ADT_CODEMP = F.FGO_CODEMP), 0)  AS VALADT           ';

  Result := Result + 'FROM ';
  Result := Result + '  FATGOR F ';
  Result := Result + '  INNER JOIN EXTGOR E  ON F.AUTOINCREM = E.FGO_SEQFGO  ';
  Result := Result + '  INNER JOIN FATDOR FD ON F.AUTOINCREM = FD.FDO_SEQGER ';
  Result := Result + '  INNER JOIN CADCLI C  ON F.FGO_CODCLI = C.CLI_CODCLI  ';
  Result := Result + 'WHERE                     ';
  Result := Result + '  F.FGO_ESPDOC = "PD" AND ';
  Result := Result + '  F.FGO_LIBERA > 0    AND ';
  Result := Result + '  F.FGO_LIBCOM = 1    AND ';
  Result := Result + '  (SELECT FDO_ENTRET FROM EXTDOR WHERE FDO_SEQFDO = FD.AUTOINCREM) = "E" AND ';
  Result := Result + '  F.FGO_ENTFUT = "N"  AND ';
  Result := Result + '  LOCATE(FDO_CLAFIS, :CLAVEN) > 0 AND ';
  Result := Result + '  F.FGO_JAFATU = 0    AND ';

  If Not fEmptyStr(edtEmpPed.Text) Then
    Result := Result + '  F.FGO_CODEMP = :CODEMP AND ';

  If Not fEmptyStr(edtNumPed.Text) Then
    Result := Result + '  F.FGO_NUMDOC = :NUMDOC AND ';

  If Not fEmptyStr(edtEmpFat.Text) Then
    Result := Result + '  IF(FGO_EMPFAT <> "", FGO_EMPFAT, IF(FDO_EMPFAT <> "", FDO_EMPFAT, IF(FGO_ENT_CD = "S", FGO_EMP_CD, FDO_EMPITE))) = :EMPFAT AND ';

  If Not (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
     Not (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
    Result := Result + '  ((F.FGO_DTAENT >= :DTAINI) AND (F.FGO_DTAENT <= :DTAFIN)) AND ';

  If GetStatus <> '' Then
    Result := Result + '  (LOCATE(FGO_INTFUS, :STATUS) > 0) AND ';

  Result := Result + '  NOT EXISTS (               ';
  Result := Result + '      SELECT FGO.AUTOINCREM  ';
  Result := Result + '      FROM FATGOR FGO        ';
  Result := Result + '      JOIN EXTGOR EGO ON EGO.FGO_SEQFGO = FGO.AUTOINCREM ';
  Result := Result + '      JOIN FATDOR FDO ON FDO.FDO_SEQGER = FGO.AUTOINCREM ';
  Result := Result + '      WHERE FGO.FGO_NUMDOC = F.FGO_NUMDOC ';
  Result := Result + '        AND FGO.FGO_ESPDOC = F.FGO_ESPDOC ';
  Result := Result + '        AND FGO.FGO_CODEMP = F.FGO_CODEMP ';
  Result := Result + '        AND EGO.FGO_EMP_TE IS NULL ';
  Result := Result + '        AND FGO.FGO_ENT_CD = "N"   ';
  Result := Result + '        AND IFNULL(FDO.FDO_EMPITE, FDO.FDO_CODEMP) <> FDO.FDO_CODEMP ';
  Result := Result + '        AND FGO.FGO_JAFATU = 0) AND ';

  If chkAguardandoEnvio.Checked Then
  Begin
    Result := Result + '  NOT EXISTS ( ';
    Result := Result + '        SELECT R.AUTOINCREM ';
    Result := Result + '        FROM ROMGERX R      ';
    Result := Result + '        WHERE R.GER_NUMDOC = F.FGO_NUMDOC      ';
    Result := Result + '          AND R.GER_ESPDOC = F.FGO_ESPDOC      ';
    Result := Result + '          AND R.GER_CODEMP = F.FGO_CODEMP) AND ';
  End;

  Result := Result + '  EXISTS (                           ';
  Result := Result + '      SELECT TRA_CODTRA              ';
  Result := Result + '      FROM CADTRA                    ';
  Result := Result + '      WHERE TRA_CODTRA = FGO_CODTRA  ';
  Result := Result + '        AND TRA_INTFUS = "S")        ';

  Result := Result + 'GROUP BY                             ';
  Result := Result + '  F.AUTOINCREM                       ';

  Result := Result + 'HAVING                               ';
  Result := Result + '  (F.FGO_CONPAG <> "01000") OR ((F.FGO_CONPAG = "01000") AND (VALADT > 0)) ';
end;

function TfrmPainelFusion.fGetSQLOpcRom_2: String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  CASE ';
  Result := Result + '    WHEN (A.AUX_INTFUS = "N") THEN "Aguardando envio" ';
  Result := Result + '    WHEN (A.AUX_INTFUS = "E") THEN "Enviado"          ';
  Result := Result + '    WHEN (A.AUX_INTFUS = "R") THEN "Roteirizado"      ';
  Result := Result + '    ELSE ""                                         ';
  Result := Result + '  END AS STATUS,                                    ';

  Result := Result + '  A.AUX_INTFUS AS INTFUS, ';

  Result := Result + '  G.GER_NUMDOC AS NUMDOC, ';
  Result := Result + '  G.GER_ESPDOC AS ESPDOC, ';
  Result := Result + '  G.GER_CODEMP AS EMPDOC, ';
  Result := Result + '  CONCAT(G.GER_NUMDOC, "-", G.GER_ESPDOC, "-", G.GER_CODEMP) AS DOCUMENTO, ';
  Result := Result + '  CONCAT(G.GER_CODCLI, " - ", C.CLI_NOMCLI) AS CLIENTE,                  ';
  Result := Result + '  G.GER_DTAENT AS DTAEMI, ';
  Result := Result + '  IF(G.GER_EMPFAT <> "", G.GER_EMPFAT, IF(D.DET_EMPFAT <> "", D.DET_EMPFAT, G.GER_CODEMP)) AS EMPFAT, ';
  Result := Result + '  G.GER_NUMROM NUMROM,    ';
  Result := Result + '  G.GER_EMPROM EMPROM     ';

  Result := Result + 'FROM ';
  Result := Result + '  MOVGER G ';
  Result := Result + '  INNER JOIN AUXMOV A ON G.AUTOINCREM = A.AUX_SEQGER  ';
  Result := Result + '  INNER JOIN MOVDET D ON G.AUTOINCREM = D.DET_SEQGER ';
  Result := Result + '  INNER JOIN CADCLI C ON G.GER_CODCLI = C.CLI_CODCLI  ';
  Result := Result + 'WHERE                     ';
  Result := Result + '  G.GER_ESPDOC IN ("NF","IF") AND ';
  Result := Result + '  G.GER_ENTFAT = "S" AND ';
  Result := Result + '  G.GER_ENTFUT = "N" AND ';
  Result := Result + '  LOCATE(D.DET_CLAFIS, CONCAT(:CLAVEN, "5117_6117_")) > 0 AND ';
  Result := Result + '  D.DET_CLAFIS > 5000 AND ';
  Result := Result + '  D.DET_CLAFIS NOT IN ("5922","6922") AND ';

  If Not fEmptyStr(edtEmpPed.Text) Then
    Result := Result + '  G.GER_CODEMP = :CODEMP AND ';

  If Not fEmptyStr(edtNumPed.Text) Then
    Result := Result + '  G.GER_NUMDOC = :NUMDOC AND ';

  If Not fEmptyStr(edtEmpFat.Text) Then
    Result := Result + '  IF(G.GER_EMPFAT <> "", G.GER_EMPFAT, IF(D.DET_EMPFAT <> "", D.DET_EMPFAT, G.GER_CODEMP)) = :EMPFAT AND ';

  If Not (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
     Not (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
    Result := Result + '  ((G.GER_DTAENT >= :DTAINI) AND (G.GER_DTAENT <= :DTAFIN)) AND ';

  If GetStatus <> '' Then
    Result := Result + '  (LOCATE(A.AUX_INTFUS, :STATUS) > 0) AND ';

  If chkAguardandoEnvio.Checked Then
  Begin
    Result := Result + '  NOT EXISTS ( ';
    Result := Result + '        SELECT R.AUTOINCREM ';
    Result := Result + '        FROM ROMGERX R      ';
    Result := Result + '        WHERE R.GER_NUMDOC = G.GER_NUMDOC      ';
    Result := Result + '          AND R.GER_ESPDOC = G.GER_ESPDOC      ';
    Result := Result + '          AND R.GER_CODEMP = G.GER_CODEMP) AND ';
  End;

  Result := Result + '  EXISTS (                           ';
  Result := Result + '      SELECT TRA_CODTRA              ';
  Result := Result + '      FROM CADTRA                    ';
  Result := Result + '      WHERE TRA_CODTRA = G.GER_CODTRA  ';
  Result := Result + '        AND TRA_INTFUS = "S")        ';

  Result := Result + 'GROUP BY                             ';
  Result := Result + '  G.AUTOINCREM                       ';
end;

function TfrmPainelFusion.GetStatus: String;
begin

  Result := '';
  If chkAguardandoEnvio.Checked Then
    Result := Result + 'N_';

  If chkEnviado.Checked Then
    Result := Result + 'E_';

  If chkRoteirizado.Checked Then
    Result := Result + 'R_';

end;

procedure TfrmPainelFusion.SetParametros;
begin

  If qryPedidos.FindParam('NUMDOC') <> Nil Then
    qryPedidos.ParamByName('NUMDOC').AsString := edtNumPed.Text;

  If qryPedidos.FindParam('CODEMP') <> Nil Then
    qryPedidos.ParamByName('CODEMP').AsString := edtEmpPed.Text;

  If qryPedidos.FindParam('CLAVEN') <> Nil Then
    qryPedidos.ParamByName('CLAVEN').AsString := VS_strClaVen;

  If (qryPedidos.FindParam('EMPFAT') <> Nil) Then
    qryPedidos.ParamByName('EMPFAT').AsString := edtEmpFat.Text;

  If (qryPedidos.FindParam('DTAINI') <> Nil) And
     (qryPedidos.FindParam('DTAFIN') <> Nil) Then
  Begin
    qryPedidos.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
    qryPedidos.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
  End;

  If (qryPedidos.FindParam('STATUS') <> Nil) Then
    qryPedidos.ParamByName('STATUS').AsString := GetStatus;

end;

end.
