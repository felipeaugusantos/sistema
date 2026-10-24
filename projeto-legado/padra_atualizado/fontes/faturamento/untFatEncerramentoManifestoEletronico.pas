unit untFatEncerramentoManifestoEletronico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniDataSetProvider, AppEvnts, Uni, Menus, StdCtrls, EditFocus,
  Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, BitBtnLockedIncrem, ExtCtrls,
  UniClientDataSet, MemDS, DBAccess, Datasnap.Provider, Datasnap.DBClient,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxGroupBox, cxRadioGroup,
  cxCheckBox, untFuncoesConsulta, untTypesSistema;

type
  TfrmFatEncerramentoManifestoEletronico = class(TfrmPaiOrdena)
    Label7: TLabel;
    edtNumMan: TEditFocus;
    Label1: TLabel;
    mskDtaIniMan: TMaskEditFocus;
    mskDtaFinMan: TMaskEditFocus;
    lblCodEmp: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    lbl16: TLabel;
    mskPlaVei: TMaskEditFocus;
    edtMarVei: TEditFocus;
    edtModVei: TEditFocus;
    Label4: TLabel;
    btnGravar: TBitBtnLocked;
    rdgTipoDocumento: TcxRadioGroup;
    chkCarPos: TcxCheckBox;
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure mskPlaVeiKeyPress(Sender: TObject; var Key: Char);
    procedure chkCarPosClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  private
    arrEmpresa : TConsultasArray;
    procedure pEnviarEncerramentos;
    procedure pEncerraManifesto(strNumMan: String);
    procedure pLimparTela;
    procedure pLimparConsulta;
    procedure pRetornaDadosVeiculo(strPlaca: String; Var strMarca, strModelo: String);
    function fGetSqlNFe: string;
    function fGetSqlCTe: string;
    function fEhManifestoEncerrado: Boolean;
    function fEhManifestoAutorizado: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untLibNfe, untConsultas;

{ TfrmFatEncerramentoManifestoEletronico }

procedure TfrmFatEncerramentoManifestoEletronico.btnAdicionarClick(
  Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    pLimpaPesquisa;
    fAbreConsulta(True);
    If cdsConsulta.IsEmpty Then
    Begin
      pMensagemOk('Não há manifesto(s) pendentes de encerramento com estes dados.');
    End
    Else If fEhManifestoEncerrado Then
    Begin
      pMensagemOk('O manifesto informado já foi encerrado.');
      pLimparConsulta;
    End
    Else If not fEhManifestoAutorizado Then
    Begin
      If fMensagem('Atenção', 'O manifesto informado não está autorizado na Sefaz.'+#13+
                              'Deseja encerrar esse manifesto apenas no Autcom?', ['&Sim', '&Não'], 2) = 2 Then
      Begin
        pLimparConsulta;
      End;
    End
    Else
    Begin
      pSetFocus(dbgConsulta);
    End;
  End;
end;

procedure TfrmFatEncerramentoManifestoEletronico.pLimparConsulta;
begin
  pLimpaPesquisa;
  cdsConsulta.EmptyDataSet;
  pLimparTela;
end;

function TfrmFatEncerramentoManifestoEletronico.fEhManifestoEncerrado: Boolean;
begin
  Result := False;

  If fEmptyStr(edtNumMan.Text) Then
    Exit;

  cdsConsulta.DisableControls;
  cdsConsulta.First;
  Try
    While not cdsConsulta.eof Do
    Begin
      If cdsConsulta.FieldByName('FIS_ENCERR').AsString = '1' Then
      Begin
        Result := True;
        Break;
      End;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.First;
    cdsConsulta.EnableControls;
  End;
end;

function TfrmFatEncerramentoManifestoEletronico.fEhManifestoAutorizado: Boolean;
begin
  Result := True;

  If fEmptyStr(edtNumMan.Text) Then
    Exit;

  cdsConsulta.DisableControls;
  cdsConsulta.First;
  Try
    While not cdsConsulta.eof Do
    Begin
      If fEmptyStr(cdsConsulta.FieldByName('FIS_ACEMAN').AsString) Then
      Begin
        Result := False;
        Break;
      End;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.First;
    cdsConsulta.EnableControls;
  End;
end;

procedure TfrmFatEncerramentoManifestoEletronico.btnGravarClick(
  Sender: TObject);
begin
  inherited;
  If stlListSelecao.Count <= 0 Then
  Begin
    pMensagemOk('É necessário selecionar pelo menos 1 documento para a emissão do manifesto.');
    Exit;
  End;

  pEnviarEncerramentos;
  pMensagemOk('Encerramentos enviados com sucesso.');
  pLimparTela;
end;

procedure TfrmFatEncerramentoManifestoEletronico.chkCarPosClick(
  Sender: TObject);
begin
  inherited;

  edtCodEmp.NormalColor := $00FFDFB8;
  edtCodEmp.ReadOnly    := True;
  edtCodEmp.TabStop     := False;

  If chkCarPos.Checked Then
  Begin
    edtCodEmp.NormalColor := clWindow;
    edtCodEmp.ReadOnly    := False;
    edtCodEmp.TabStop     := True;
  End;

end;

procedure TfrmFatEncerramentoManifestoEletronico.edtCodEmpKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa, False, False) Then
  Begin
    fValidaCampos(edtCodEmp,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatEncerramentoManifestoEletronico.pEnviarEncerramentos;
  Var
    qryDocs: TUniQuery;
begin
  Screen.Cursor := crHourGlass;
  qryDocs := fCriaQuery(Self);

  Try
    qryDocs.SQL.Add('SELECT FIS_NUMMAN, FIS_ACEMAN, FIS_ENCERR FROM CADFIS WHERE AUTOINCREM IN (' + stlListSelecao.CommaText + ') ');
    qryDocs.Open;

    qryDocs.First;
    While Not qryDocs.Eof Do
    Begin

      If not (qryDocs.FieldByName('FIS_ENCERR').AsString = '1') Then
      Begin
        If fEmptyStr(qryDocs.FieldByName('FIS_ACEMAN').AsString) Then
        Begin
          pEncerraManifesto(qryDocs.FieldByName('FIS_NUMMAN').AsString);
        End
        Else
        If fEnviarEncerramentoManifesto(qryDocs.FieldByName('FIS_NUMMAN').AsString, edtCodEmp.Text) Then
        Begin
          pEncerraManifesto(qryDocs.FieldByName('FIS_NUMMAN').AsString);
        End
        Else
        Begin
          pMensagemOk('Não foi possível encerrar todos os manifestos. Por favor, tente novamente.');
          Exit;
        End;
      End;

      qryDocs.Next;
    End;
  Finally
    FreeAndNil(qryDocs);
    Screen.Cursor := crDefault;
  End;
end;

function TfrmFatEncerramentoManifestoEletronico.fGetSql(
  blnLike: Boolean): String;
begin
  if (rdgTipoDocumento.ItemIndex = 0) then
    Result := fGetSqlNFe
  else
    Result := fGetSqlCTe;
end;

function TfrmFatEncerramentoManifestoEletronico.fGetSqlCTe: string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  FIS_NUMMAN AS NUMMAN, ';
  Result := Result + '  FIS_DTAMAN AS DTAMAN, ';
  Result := Result + '  FIS_ESTADO AS ESTADO, ';
  Result := Result + '  FIS_NUMMAN, FIS_ACEMAN, FIS_ENCERR, ';
  Result := Result + '  CADFIS.AUTOINCREM AS AUTOINCREM, ';
  Result := Result + '  IF(IFNULL(FIS_MOTMAN, "") = "", ';
  Result := Result + '    CAST((SELECT GROUP_CONCAT(CONCAT(FMO_CODMOT, "-", MOT_NOMMOT) SEPARATOR ", ") ';
  Result := Result + '      FROM FISMOT ';
  Result := Result + '      JOIN CADMOT ON FMO_CODMOT = MOT_CODMOT ';
  Result := Result + '      WHERE FMO_SEQGER = CADFIS.AUTOINCREM) AS CHAR(200)), ';
  Result := Result + '    CONCAT(FIS_MOTMAN,"-",MOT_NOMMOT)) AS NOMMOT, ';
  Result := Result + '  FIS_PLAMAN AS PLAMAN, ';
  Result := Result + '  FIS_PLAMA2 AS PLAMA2 ';
  Result := Result + 'FROM ';
  Result := Result + '  CADFIS ';
  Result := Result + '  LEFT JOIN CADMOT ON MOT_CODMOT = FIS_MOTMAN ';
  Result := Result + 'WHERE ';

  If fEmptyStr(edtNumMan.Text) Then
    Result := Result + '  IFNULL(FIS_ACEMAN, "") <> "" AND ';

  Result := Result + '  FIS_ESPDOC = "CT" AND ';
  Result := Result + '  FIS_ENTSAI = "S" AND ';
  Result := Result + '  FIS_EMPMAN = :CODEMP AND ';
  Result := Result + '  FIS_NUMMAN IS NOT NULL ';

  If fEmptyStr(edtNumMan.Text) Then
    Result := Result + '  AND FIS_ENCERR IS NULL ';

  If Not fEmptyStr(edtNumMan.Text) Then
    Result := Result + '  AND FIS_NUMMAN = :NUMMAN ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskPlaVei.Text)) Then
    Result := Result + '  AND FIS_PLAMAN = :PLAMAN ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniMan.Text)) Then
    Result := Result + '  AND FIS_DTAMAN BETWEEN :DTAINI_MAN AND :DTAFIN_MAN ';

  Result := Result + 'GROUP BY FIS_NUMMAN, FIS_ESTADO, IFNULL(FIS_PLAMAN, ""), IFNULL(FIS_PLAMA2, "") ';
end;

function TfrmFatEncerramentoManifestoEletronico.fGetSqlNFe: string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  FIS_NUMMAN AS NUMMAN, ';
  Result := Result + '  FIS_DTAMAN AS DTAMAN, ';
  Result := Result + '  FIS_ESTADO AS ESTADO, ';
  Result := Result + '  FIS_NUMMAN, FIS_ACEMAN, FIS_ENCERR, ';
  Result := Result + '  CADFIS.AUTOINCREM AS AUTOINCREM, ';
  Result := Result + '  IF(IFNULL(FIS_MOTMAN, "") = "", ';
  Result := Result + '    CAST((SELECT GROUP_CONCAT(CONCAT(FMO_CODMOT, "-", MOT_NOMMOT) SEPARATOR ", ") ';
  Result := Result + '      FROM FISMOT ';
  Result := Result + '      JOIN CADMOT ON FMO_CODMOT = MOT_CODMOT ';
  Result := Result + '      WHERE FMO_SEQGER = CADFIS.AUTOINCREM) AS CHAR(200)), ';
  Result := Result + '    CONCAT(FIS_MOTMAN,"-",MOT_NOMMOT)) AS NOMMOT, ';
  Result := Result + '  FIS_PLAMAN AS PLAMAN, ';
  Result := Result + '  FIS_PLAMA2 AS PLAMA2 ';
  Result := Result + 'FROM ';
  Result := Result + '  CADFIS ';
  Result := Result + '  LEFT JOIN CADMOT ON MOT_CODMOT = FIS_MOTMAN ';
  Result := Result + 'WHERE ';

  If fEmptyStr(edtNumMan.Text) Then
    Result := Result + '  IFNULL(FIS_ACEMAN, "") <> "" AND ';

  Result := Result + '  FIS_ESPDOC IN ("NF", "EL") AND ';
  Result := Result + ' '+fSqlManifestoDocumentosPermitidos+' AND ';
  Result := Result + '  FIS_EMPMAN = :CODEMP AND ';
  Result := Result + '  FIS_NUMMAN IS NOT NULL ';

  If fEmptyStr(edtNumMan.Text) Then
    Result := Result + '  AND FIS_ENCERR IS NULL ';

  If Not fEmptyStr(edtNumMan.Text) Then
    Result := Result + '  AND FIS_NUMMAN = :NUMMAN ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskPlaVei.Text)) Then
    Result := Result + '  AND FIS_PLAMAN = :PLAMAN ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniMan.Text)) Then
    Result := Result + '  AND FIS_DTAMAN BETWEEN :DTAINI_MAN AND :DTAFIN_MAN ';

  Result := Result + 'GROUP BY FIS_NUMMAN, FIS_ESTADO, IFNULL(FIS_PLAMAN, ""), IFNULL(FIS_PLAMA2, "") ';
end;

procedure TfrmFatEncerramentoManifestoEletronico.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key = VK_ESCAPE Then
  Begin
    If dbgConsulta.Focused Then
    Begin
      If fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não'], 2) = 1 Then
      Begin
        pLimparTela;
      End;
    End
    Else
      inherited;
  End
  Else If Key = VK_F10 Then
  Begin
    btnGravar.Click;
  End
  Else
    inherited;
end;

procedure TfrmFatEncerramentoManifestoEletronico.FormShow(Sender: TObject);
begin
  inherited;
  blnSempreRelerBanco := False;
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;
  rdgTipoDocumento.Enabled := fCfgSis('EMICTE', varBoolean);
  rdgTipoDocumento.ItemIndex := IIF(rdgTipoDocumento.Enabled, 1, 0);
  pSetFocus(edtNumMan);
end;

function TfrmFatEncerramentoManifestoEletronico.fSetParametros: Boolean;
begin
  qryConsulta.ParamByName('CODEMP').AsString := edtCodEmp.Text;
  If Not fEmptyStr(edtNumMan.Text) Then
    qryConsulta.ParamByName('NUMMAN').AsString := edtNumMan.Text;

  If Not fEmptyStr(fTiraCaracEspeciais(mskPlaVei.Text)) Then
    qryConsulta.ParamByName('PLAMAN').AsString := fTiraCaracEspeciais(mskPlaVei.Text);

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniMan.Text)) Then
  Begin
    qryConsulta.ParamByName('DTAINI_MAN').AsDateTime := StrToDate(mskDtaIniMan.Text);
    qryConsulta.ParamByName('DTAFIN_MAN').AsDateTime := StrToDate(mskDtaFinMan.Text);
  End;

  Result := True;
end;

function TfrmFatEncerramentoManifestoEletronico.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    strMarca: String;
    strModelo: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaFinMan)                                  And
       (Not mskDtaFinMan.ReadOnly)                              And
       (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniMan.Text)))  Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFinMan.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final  do manifesto deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaPeriodo(mskDtaIniMan.Text, mskDtaFinMan.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final  do manifesto deve ser maior ou igual a Data Inicial  do manifesto !', ['&O k']);
        Result := False;
      End;

    End
    Else If (Sender = mskPlaVei) Then
    Begin

      If fVeiculoInativo(mskPlaVei.Text) Then
      Begin
        edtMarVei.Text := '';
        edtModVei.Text := '';
        fMensagem('','Este veículo está inativo.',['&O k']);
        Result := False;
      End
      Else
      Begin
        If fEmptyStr(mskPlaVei.Text) Then
        Begin
          edtMarVei.Clear;
          edtModVei.Clear;
        End
        Else
        Begin
          pRetornaDadosVeiculo(mskPlaVei.Text, strMarca, strModelo);
          If fEmptyStr(strMarca) And fEmptyStr(strModelo) Then
          Begin
            pMensagemOk('Este veículo não está cadastrado.');
            Result := False;
          End
          Else
          Begin
            edtMarVei.Text := strMarca;
            edtModVei.Text := strModelo;
          End;
        End;
      End;
    End

    Else If (Sender = edtCodEmp) And (not edtCodEmp.ReadOnly) Then
    Begin
      edtNomEmp.Clear;

      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe a empresa do manifesto!', ['&Ok']);
        Result := False;
        pSetFocus(edtCodEmp);
        Exit;
      End;

      edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

      If fEmptyStr(edtNomEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&Ok']);
        Result := False;
        pSetFocus(edtCodEmp);
        Exit;
      End;
    End;
  End;
end;

procedure TfrmFatEncerramentoManifestoEletronico.mskPlaVeiKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrVei: TConsultasArray;
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE VEICULOS *}
  {**************************MM*}
  If fPesqVeiculos(Self, mskPlaVei, nil, Nil, Key, arrVei, True, False,  ' VEI_STATUS = "A" ') Then
  Begin
    If fValidaCampos(mskPlaVei, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatEncerramentoManifestoEletronico.pEncerraManifesto(strNumMan: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('UPDATE CADFIS SET FIS_ENCERR = 1 WHERE FIS_NUMMAN = :NUMMAN AND FIS_EMPMAN = :CODEMP');
  qryAux.ParamByName('NUMMAN').AsString := strNumMan;
  qryAux.ParamByName('CODEMP').AsString := edtCodEmp.text;
  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

procedure TfrmFatEncerramentoManifestoEletronico.pLimparTela;
begin
  pDesmarcaTodos;
  qryConsulta.Close;
  cdsConsulta.Close;
  edtNumMan.Clear;
  mskPlaVei.Clear;
  mskDtaIniMan.Clear;
  mskDtaFinMan.Clear;
  pSetFocus(edtNumMan);
end;

procedure TfrmFatEncerramentoManifestoEletronico.pRetornaDadosVeiculo(strPlaca: String; Var strMarca, strModelo: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT MAR_DESMAR, MOD_DESMOD FROM ');
  qryAux.SQL.Add('CADVEI ');
  qryAux.SQL.Add('JOIN MARVEI ON MAR_CODMAR = VEI_CODMAR ');
  qryAux.SQL.Add('JOIN MODVEI ON MOD_CODMOD = VEI_CODMOD ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  VEI_PLAVEI = :PLACA ');

  qryAux.ParamByName('PLACA').AsString := strPlaca;
  qryAux.Open;

  strMarca := qryAux.FieldByName('MAR_DESMAR').AsString;
  strModelo := qryAux.FieldByName('MOD_DESMOD').AsString;

  FreeAndNil(qryAux);
end;

end.
