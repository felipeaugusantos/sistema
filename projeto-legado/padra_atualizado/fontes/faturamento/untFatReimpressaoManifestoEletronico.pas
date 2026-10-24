unit untFatReimpressaoManifestoEletronico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniDataSetProvider, AppEvnts, Uni, Menus, StdCtrls, EditFocus,
  Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, BitBtnLockedIncrem, ExtCtrls,
  UniClientDataSet, MemDS, DBAccess, Datasnap.Provider, Datasnap.DBClient,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxGroupBox, cxRadioGroup,
  cxCheckBox, untFuncoesConsulta, untTypesSistema, untCfgRel;

type
  TfrmFatReimpressaoManifestoEletronico = class(TfrmPaiOrdena)
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
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure mskPlaVeiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  private
    arrEmpresa : TConsultasArray;
    procedure pCarregaFila(const strNomPro : String; Var strNomeFila, strTipImp : String);
    procedure pGeraReimpressao;
    procedure pLimparTela;
    procedure pLimparConsulta;
    procedure pRetornaDadosVeiculo(strPlaca: String; Var strMarca, strModelo: String);
    function fGetSqlNFe: string;
    function fGetSqlCTe: string;
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

{ TfrmFatReimpressaoManifestoEletronico }

procedure TfrmFatReimpressaoManifestoEletronico.btnAdicionarClick(
  Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    pDesmarcaTodos;
    pLimpaPesquisa;
    fAbreConsulta(True);
    If cdsConsulta.IsEmpty Then
    Begin
      pMensagemOk('Não existe manifesto(s) com estes dados.');
    End
    Else If not fEhManifestoAutorizado Then
    Begin
      pMensagemOk('O manifesto informado não está autorizado na Sefaz.');
      pLimparConsulta;
    End
    Else
    Begin
      pSetFocus(dbgConsulta);
    End;
  End;
end;

procedure TfrmFatReimpressaoManifestoEletronico.pLimparConsulta;
begin
  pLimpaPesquisa;
  cdsConsulta.EmptyDataSet;
  pLimparTela;
end;

function TfrmFatReimpressaoManifestoEletronico.fEhManifestoAutorizado: Boolean;
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

procedure TfrmFatReimpressaoManifestoEletronico.btnGravarClick(
  Sender: TObject);
begin
  inherited;
  If stlListSelecao.Count <= 0 Then
  Begin
    pMensagemOk('Selecione pelo menos 1 manifesto para reimpressão.');
    Exit;
  End;

  pGeraReimpressao;
end;

procedure TfrmFatReimpressaoManifestoEletronico.edtCodEmpKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa, False, False) Then
  Begin
    fValidaCampos(edtCodEmp,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatReimpressaoManifestoEletronico.pCarregaFila(const strNomPro : String; Var strNomeFila, strTipImp : String);
  Var
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  Try
    pCarregaConfImpr(qryCfgRel, strNomPro);
    strNomeFila := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
    strTipImp   := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
    fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);
  Finally
    FreeAndNil(qryCfgRel);
  End;
end;

procedure TfrmFatReimpressaoManifestoEletronico.pGeraReimpressao;
  Var
    qryDocs: TUniQuery;
    strTipImp: String;
    strImpressora: String;
begin

  If fMensagem('', 'Confirma Impressão?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  pCarregaFila(Self.Name, strImpressora, strTipImp);

  If fEmptyStr(strImpressora) Then
  Begin
    pMensagemOk('Selecione uma impressora para continuar.');
    Exit;
  End;

  Screen.Cursor := crHourGlass;
  qryDocs := fCriaQuery(Self);

  Try
    qryDocs.SQL.Add('SELECT FIS_NUMMAN, FIS_EMPMAN FROM CADFIS WHERE AUTOINCREM IN (' + stlListSelecao.CommaText + ') ');
    qryDocs.Open;

    qryDocs.First;
    While Not qryDocs.Eof Do
    Begin

      pImprimirManifesto(qryDocs.FieldByName('FIS_NUMMAN').AsString,
                         qryDocs.FieldByName('FIS_EMPMAN').AsString,
                         strImpressora);

      Sleep(200);

      qryDocs.Next;
    End;
  Finally
    FreeAndNil(qryDocs);
    Screen.Cursor := crDefault;
  End;

  pMensagemOk('Reimpressão solicitada com sucesso.');
end;

function TfrmFatReimpressaoManifestoEletronico.fGetSql(
  blnLike: Boolean): String;
begin
  if (rdgTipoDocumento.ItemIndex = 0) then
    Result := fGetSqlNFe
  else
    Result := fGetSqlCTe;
end;

function TfrmFatReimpressaoManifestoEletronico.fGetSqlCTe: string;
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

  If Not fEmptyStr(edtNumMan.Text) Then
    Result := Result + '  AND FIS_NUMMAN = :NUMMAN ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskPlaVei.Text)) Then
    Result := Result + '  AND FIS_PLAMAN = :PLAMAN ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniMan.Text)) Then
    Result := Result + '  AND FIS_DTAMAN BETWEEN :DTAINI_MAN AND :DTAFIN_MAN ';

  Result := Result + 'GROUP BY FIS_NUMMAN, FIS_ESTADO, IFNULL(FIS_PLAMAN, ""), IFNULL(FIS_PLAMA2, "") ';
end;

function TfrmFatReimpressaoManifestoEletronico.fGetSqlNFe: string;
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

  If Not fEmptyStr(edtNumMan.Text) Then
    Result := Result + '  AND FIS_NUMMAN = :NUMMAN ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskPlaVei.Text)) Then
    Result := Result + '  AND FIS_PLAMAN = :PLAMAN ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniMan.Text)) Then
    Result := Result + '  AND FIS_DTAMAN BETWEEN :DTAINI_MAN AND :DTAFIN_MAN ';

  Result := Result + 'GROUP BY FIS_NUMMAN, FIS_ESTADO, IFNULL(FIS_PLAMAN, ""), IFNULL(FIS_PLAMA2, "") ';
end;

procedure TfrmFatReimpressaoManifestoEletronico.FormKeyDown(Sender: TObject;
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

procedure TfrmFatReimpressaoManifestoEletronico.FormShow(Sender: TObject);
begin
  inherited;
  blnSempreRelerBanco := False;
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;
  rdgTipoDocumento.Enabled := fCfgSis('EMICTE', varBoolean);
  rdgTipoDocumento.Visible := rdgTipoDocumento.Enabled;
  rdgTipoDocumento.ItemIndex := IIF(rdgTipoDocumento.Enabled, 1, 0);
  pSetFocus(edtNumMan);
end;

function TfrmFatReimpressaoManifestoEletronico.fSetParametros: Boolean;
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

function TfrmFatReimpressaoManifestoEletronico.fValidaCampos(
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
        fMensagem('ATENÇÃO!', 'A Data Final do manifesto deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaPeriodo(mskDtaIniMan.Text, mskDtaFinMan.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final do manifesto deve ser maior ou igual a Data Inicial  do manifesto !', ['&O k']);
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

procedure TfrmFatReimpressaoManifestoEletronico.mskPlaVeiKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrVei: TConsultasArray;
begin
  inherited;

  If fPesqVeiculos(Self, mskPlaVei, nil, Nil, Key, arrVei, True, False,  ' VEI_STATUS = "A" ') Then
  Begin
    If fValidaCampos(mskPlaVei, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatReimpressaoManifestoEletronico.pLimparTela;
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

procedure TfrmFatReimpressaoManifestoEletronico.pRetornaDadosVeiculo(strPlaca: String; Var strMarca, strModelo: String);
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
