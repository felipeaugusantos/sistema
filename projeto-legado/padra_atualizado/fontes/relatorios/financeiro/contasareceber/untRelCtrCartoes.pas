unit untRelCtrCartoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, Mask, MaskEditFocus, RLFilters, RLDraftFilter,
  Menus, StdCtrls, EditFocus, QColorLabel, Buttons, ExtCtrls, frxDesgn,
  frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML, DB,
  frxExportXLS, frxExportRTF, Uni, AppEvnts, untTypesSistema,
  untFuncoesFactory,  BitBtnLockedIncrem, StrUtils, frxExportCSVTestabilidade,
  untIFuncoes, ComboBoxFocus;

type
  TRecTot = Record
    fltValBru,
    fltValTax,
    fltValLiq,
    fltTaxRec,
    fltValRec: Double;
  End;

type
  TfrmRelCtrCartoes = class(TfrmPaiRelatorio)
    gpbTitulos: TGroupBox;
    ColorLabel2: TColorLabel;
    edtTitulos: TEditFocus;
    gbpOpcDta: TGroupBox;
    ColorLabel3: TColorLabel;
    edtOpcaoData: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    Label6: TLabel;
    lblDtaIni: TLabel;
    lblDtaFin: TLabel;
    Label5: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label1: TLabel;
    edtCodCartoes: TEditFocus;
    edtDesCartoes: TEditFocus;
    gbpVenCar: TGroupBox;
    edtVenCar: TEditFocus;
    ColorLabel5: TColorLabel;
    rdgEmpresa: TRadioGroup;
    Label2: TLabel;
    edtCodBan: TEditFocus;
    edtDesBan: TEditFocus;
    gpbTipoBai: TGroupBox;
    ColorLabel6: TColorLabel;
    edtTipBai: TEditFocus;
    gpbOrdDta: TGroupBox;
    ColorLabel7: TColorLabel;
    edtOrdenarData: TEditFocus;
    chkAjuDta: TCheckBox;
    lbl1: TLabel;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    edtSeqCon: TEditFocus;
    Label3: TLabel;
    rdgTipCar: TRadioGroup;
    chkNaoExibeVend: TCheckBox;
    edtDesOpe: TEditFocus;
    edtCodOpe: TEditFocus;
    Label4: TLabel;
    Label7: TLabel;
    cmbOpcao: TComboBoxFocus;
    Label8: TLabel;
    edtPorBai: TEditFocus;
    edtDesPorBai: TEditFocus;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    mskVenIni: TMaskEditFocus;
    Label12: TLabel;
    mskVenFin: TMaskEditFocus;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    mskRecIni: TMaskEditFocus;
    Label16: TLabel;
    mskRecFin: TMaskEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure edtCodCartoesExit(Sender: TObject);
    procedure edtCodCartoesKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);

    procedure pCarregaCartoes(Var qryCadCar: TUniQuery);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodBanExit(Sender: TObject);
    procedure edtCodBanKeyPress(Sender: TObject; var Key: Char);
    procedure edtDestinoExit(Sender: TObject);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure cmbOpcaoChange(Sender: TObject);
    procedure edtPorBaiKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorBaiExit(Sender: TObject);

  private
    { Private declarations }
    arrCartao ,
    arrEmpresa,
    arrBandeira,
    arrVendedor,
    arrOperador,
    arrPorBai   : TConsultasArray;

    qryRelatorio: TUniQuery;

    strCartao,
    strBandeira,
    strEmpresa,
    strVendedor,
    strOperador,
    strPorBai   : String;

    procedure pGeraExcel;

    procedure pCriaQryRelatorio;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelCtrCartoes: TfrmRelCtrCartoes;

implementation

uses untPai, untExcel, untQckCtrCartoes;

{$R *.dfm}

procedure TfrmRelCtrCartoes.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtTitulos);
end;

procedure TfrmRelCtrCartoes.FormCreate(Sender: TObject);
begin
  inherited;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',Vs_date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',Vs_date);
  mskVenIni.Text := FormatDateTime('dd/mm/yyyy',Vs_date);
  mskVenFin.Text := FormatDateTime('dd/mm/yyyy',Vs_date);
  mskRecIni.Text := FormatDateTime('dd/mm/yyyy',Vs_date);
  mskRecFin.Text := FormatDateTime('dd/mm/yyyy',Vs_date);
  
end;

procedure TfrmRelCtrCartoes.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelCtrCartoes.edtPorBaiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtPorBai, edtDesPorBai, arrPorBai, Nil, fRetNomPortador, 'do Portador');
end;

procedure TfrmRelCtrCartoes.edtPorBaiKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtPorBai, edtDesPorBai, nil, Key, arrPorBai, False) Then
  Begin
    If fValidaCampos(edtPorBai, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrCartoes.edtCodCartoesExit(Sender: TObject);
begin
  inherited;
  If Not edtCodCartoes.ReadOnly Then
    pEdtCodSelectExit(edtCodCartoes, edtDesCartoes, arrCartao, fRetNomeCartao, Nil, 'do cartão');

end;

procedure TfrmRelCtrCartoes.edtCodCartoesKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  {*****************************}
  {* NOVA CONSULTA DE CARTOES  *}
  {**************************DP*}
  If fPesqCartao(Self, edtCodCartoes, edtDesCartoes, Nil, Key, arrCartao, False) Then
  Begin
    fValidaCampos(edtCodCartoes,False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrCartoes.pCarregaCartoes(Var qryCadCar: TUniQuery);
begin

  If Not (fEmptyStr(edtCodCartoes.Text)) Then
    edtDesCartoes.Text := qryCadCar.FieldByName('CAR_DESCAR').AsString
  Else
    edtDesCartoes.Text := '';

end;

procedure TfrmRelCtrCartoes.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelCtrCartoes.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  If Not edtCodEmpresa.ReadOnly Then
    pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da empresa');

end;

procedure TfrmRelCtrCartoes.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False, True) Then
  Begin
    fValidaCampos(edtCodEmpresa,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrCartoes.edtCodVenExit(Sender: TObject);
begin
  inherited;
  If Not edtCodVen.ReadOnly Then
    pEdtCodSelectExit(edtCodVen, edtDesVen, arrVendedor, fRetNomeOperador, Nil, 'do vendedor');
end;

procedure TfrmRelCtrCartoes.edtCodVenKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodVen, edtDesVen, Nil, Key, arrVendedor, False, True) Then
  Begin
    fValidaCampos(edtCodVen,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrCartoes.edtDestinoExit(Sender: TObject);
begin
//  inherited;

  If fEmptyStr(edtDestino.Text) Then
  Begin
    fMensagem('', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
    pSetFocus(edtDestino);
  End
  Else If (Copy(edtDestino.Text, 1, 1) <> 'V') And
          (Copy(edtDestino.Text, 1, 1) <> 'I') And
          (Copy(edtDestino.Text, 1, 1) <> 'E') Then
  Begin
    pSetFocus(edtDestino);
  End;

end;

function TfrmRelCtrCartoes.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        mskDtaFin.Clear;
        mskDtaFin.Enabled := False;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;

        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final (CADASTRO) deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial (CADASTRO) deve ser menor ou igual que a data final (CADASTRO)!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End

    Else If (Sender = mskVenIni) Or (Sender = mskVenFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
      Begin
        mskVenFin.Clear;
        mskVenFin.Enabled := False;
      End
      Else
      Begin
        mskVenFin.Enabled := True;

        If (Sender = mskVenFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskVenFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final (VENCIMENTO) deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskVenIni.Text) > StrToDate(mskVenFin.Text) Then
            Begin
              fMensagem('','A data inicial (VENCIMENTO) deve ser menor ou igual a data final (VENCIMENTO)!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End

    Else If (Sender = mskRecIni) Or (Sender = mskRecFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskRecIni.Text)) Then
      Begin
        mskRecFin.Clear;
        mskRecFin.Enabled := False;
      End
      Else
      Begin
        mskRecFin.Enabled := True;

        If (Sender = mskRecFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskRecFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final (RECEBIMENTO) deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskRecIni.Text) > StrToDate(mskRecFin.Text) Then
            Begin
              fMensagem('','A data inicial (RECEBIMENTO) deve ser menor ou igual a data final (RECEBIMENTO)!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End

    Else If (Sender = edtTitulos) Then
    Begin

      If fEmptyStr(edtTitulos.Text) Then
      Begin
        fMensagem('AVISO','O campo Titulos deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      If (edtTitulos.Text <> 'A') And (edtTitulos.Text <> 'Q') And (edtTitulos.Text <> 'T') Then
      Begin
        fMensagem('AVISO','O campo Titulos deve conter Somente A, Q ou T!',['&O K']);
        Result := False;
      End;

    End
    Else If (Sender = edtOpcaoData) Then
    Begin

      If fEmptyStr(edtOpcaoData.Text) Then
      Begin
        fMensagem('AVISO','O campo Filtrar por Data de deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      If (edtOpcaoData.Text <> 'V') And (edtOpcaoData.Text <> 'C') And (edtOpcaoData.Text <> 'R') Then
      Begin
        fMensagem('AVISO','O campo Filtrar por Data de deve conter somente V, C ou R!',['&O K']);
        Result := False;
      End;

    End
    {*************************************************}
    {* CAMPO INDEPENDENTE DE ORDENAÇÃO PARA AS DATAS *}
    {**22/02/2011 - 10:43**************************DP*}
    Else If (Sender = edtOrdenarData) Then
    Begin
      If fEmptyStr(edtOrdenarData.Text) Then
      Begin
        fMensagem('AVISO','O campo Ordenar por Data de deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      If (edtOrdenarData.Text <> 'V') And (edtOrdenarData.Text <> 'C') And (edtOrdenarData.Text <> 'R') Then
      Begin
        fMensagem('AVISO','O campo Ordenar por Data de deve conter somente V, C ou R!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtTipBai) Then
    Begin

      If fEmptyStr(edtTipBai.Text) Then
      Begin
        fMensagem('AVISO','O campo "Cartões por" deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      If Pos(edtTipBai.Text, 'T_V_R_') <= 0 Then
      Begin
        fMensagem('AVISO','O campo "Cartões por" deve conter somente T, V ou R!',['&O K']);
        Result := False;
      End;

    End
    Else If (Sender = edtVenCar) Then
    Begin

      If fEmptyStr(edtVenCar.Text) Then
      Begin
        fMensagem('AVISO','O campo de Agrupamento do Relatório deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      If (edtVenCar.Text <> 'D') And (edtVenCar.Text <> 'C') Then
      Begin
        fMensagem('AVISO','O campo Agrupamento do Relatório deve conter somente C ou D!',['&O K']);
        Result := False;
      End;

    End
    Else If (Sender = edtCodEmpresa) Then
    Begin

      If Not fEmptyStr(edtCodEmpresa.Text) And (edtCodEmpresa.Text <> '000') Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodVen) Then
      pDesmarcaLista(edtCodVen, arrVendedor, 'TMP_VENDEDOR')

    Else If (Sender = edtCodOpe) Then
    Begin
      If Not fEmptyStr(edtCodOpe.Text) Then
      Begin
        If edtCodOpe.Text <> '000' Then
        Begin
          edtDesOpe.Text := fRetNomeOperador(edtCodOpe.Text);
          If fEmptyStr(edtDesOpe.Text) Then
          Begin
            fMensagem('','Operador não cadastrado!', ['&Ok']);
            Result := False;
          End;
        End;
      End
      Else
        edtDesOpe.Text := 'TODOS';
    End
    Else If (Sender = edtPorBai) Then
    Begin
      pDesmarcaLista(edtPorBai, arrPorBai, 'TMP_PORBAI');
    End;
  End;


end;

procedure TfrmRelCtrCartoes.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
    strMesAno : String;
    strMesAnoO : String;
begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;
  strMesAno := '';

  If (edtDestino.Text <> 'E') then
    inherited
  Else blnImprime := fVerificaCampos;

  If blnImprime Then
  Begin

    strSQL := 'SELECT * FROM (';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

    If (cmbOpcao.ItemIndex = 0) Then
    Begin
      strSQL := strSQL + '  CONCAT(ME.MCA_NUMDUP,"-",ME.MCA_PARCEL) AS NUMDUP, ';

      If rdgEmpresa.ItemIndex = 0 Then
        strSQL := strSQL + '  ME.MCA_CODEMP AS CODEMP, '
      Else
        strSQL := strSQL + '  ME.MCA_EMPRCX AS CODEMP, ';

      strSQL := strSQL + '  ME.MCA_DTACAD AS DTACAD, ';
      strSQL := strSQL + '  ME.MCA_DTAVEN AS DTAVEN, ';
      strSQL := strSQL + '  ME.MCA_HIST01 AS HIST01, ';
      strSQL := strSQL + '  ME.MCA_NUMCCD AS NUMCCD, ';
      strSQL := strSQL + '  ME.MCA_VALSTA AS VALBRU, ';
      strSQL := strSQL + '  ME.MCA_PORBAI AS PORBAI, ';
      strSQL := strSQL + '  ME.MCA_NUMNSU AS NUMNSU, ';
      strSQL := strSQL + '  SUBSTR(ME.MCA_DOCUME,1,21) AS DOCUME, ';
      strSQL := strSQL + '  IF((MCA_DTAREC IS NOT NULL) AND (COALESCE(MCA_TAXANT, 0) > 0), MCA_TAXANT, MCA_VALTAX) AS VALTAX, ';
      strSQL := strSQL + '  IF(MCA_DTAREC IS NULL, 0, IFNULL(ME.MCA_VALSTA,0) - IFNULL(ME.MCA_VALREC,0)) AS TAXREC, ';
      strSQL := strSQL + '  IF(ME.MCA_VALORI IS NULL,0,ME.MCA_VALORI) AS VALORI, ';
      strSQL := strSQL + '  ME.MCA_VALSTA - IF((MCA_DTAREC IS NOT NULL) AND (COALESCE(MCA_TAXANT, 0) > 0), MCA_TAXANT, MCA_VALTAX) AS VALLIQ, ';
      strSQL := strSQL + '  IF(ME.MCA_VALREC IS NULL,0,ME.MCA_VALREC) AS VALREC, ';
      strSQL := strSQL + '  ME.MCA_DTAREC AS DTAREC, ';
      strSQL := strSQL + '  CONCAT(ME.MCA_CODCAR,"-",CAR_DESCAR) AS CODCAR, ';
      strSQL := strSQL + '  CAR_DESCAR AS DESCAR, ';

      strSQL := strSQL + '  IF(IFNULL(MCA_CODVEN,"") = "", (SELECT ';
      strSQL := strSQL + '     CONCAT(CTR_CODVEN, "-", OPE_NOMOPE) ';
      strSQL := strSQL + '   FROM ';
      strSQL := strSQL + '     CADREC, ';
      strSQL := strSQL + '     CADOPE  ';
      strSQL := strSQL + '   WHERE CTR_CODVEN = OPE_CODOPE ';
      strSQL := strSQL + '     AND LEFT(ME.MCA_DOCUME, 12) = CTR_NUMDUP ';
      strSQL := strSQL + '     AND SUBSTR(ME.MCA_DOCUME, 16, 2) = CTR_ESPDOC ';
      strSQL := strSQL + '     AND SUBSTR(ME.MCA_DOCUME, 19, 3) = CTR_CODEMP ';
      strSQL := strSQL + '     AND ME.MCA_CODCLI = CTR_CODCLI ';
      strSQL := strSQL + '   LIMIT 1), CONCAT(MCA_CODVEN, "-", OPE_NOMOPE)) AS CODVEN, ';


      If edtVenCar.Text = 'C' Then
        strSQL := strSQL + '  CONCAT(ME.MCA_CODCAR,"-",CAR_DESCAR) AS GRUPOS, '
      Else
      Begin

        If edtOpcaoData.Text = 'V' Then
          strSQL := strSQL + '  ME.MCA_DTAVEN AS GRUPOS, '
        Else If edtOpcaoData.Text = 'C' Then
          strSQL := strSQL + '  ME.MCA_DTACAD AS GRUPOS, '
        Else
          strSQL := strSQL + '  ME.MCA_DTAREC AS GRUPOS, ';

      End;

      {*****************************************}
      {* CALCULA O TOTAL DE DETERMINADO CARTÃO *}
      {**************************************MV*}
      strSQL := strSQL + '  (SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '    SUM(MI.MCA_VALSTA) ';
      strSQL := strSQL + '   FROM ';
      strSQL := strSQL + '    MOVCAR MI ';
      strSQL := strSQL + '   WHERE ';
      strSQL := strSQL + '    MI.MCA_SEQCON = ME.MCA_SEQCON AND ';
      strSQL := strSQL + '    MI.MCA_CODEMP = ME.MCA_CODEMP AND ';
      strSQL := strSQL + '    MI.MCA_SEQCON > 0) AS TOTORI ';

    End
    Else If (cmbOpcao.ItemIndex = 1) Then
    Begin
      strSQL := strSQL + '  CONCAT(ME.MCA_CODCAR, " - ", CAR_DESCAR) AS DESCAR, ';
      strSQL := strSQL + '  SUM(ME.MCA_VALSTA) AS VALBRU, ';
       strSQL := strSQL + '  SUM(IF((MCA_DTAREC IS NOT NULL) AND (COALESCE(MCA_TAXANT, 0) > 0), MCA_TAXANT, MCA_VALTAX)) AS VALTAX, ';
      strSQL := strSQL + '  SUM(IF(MCA_DTAREC IS NULL, 0, IFNULL(ME.MCA_VALSTA,0) - IFNULL(ME.MCA_VALREC,0))) AS TAXREC, ';
      strSQL := strSQL + '  SUM(IF(ME.MCA_VALORI IS NULL,0,ME.MCA_VALORI)) AS VALORI, ';
      strSQL := strSQL + '  SUM(ME.MCA_VALSTA - IF((MCA_DTAREC IS NOT NULL) AND (COALESCE(MCA_TAXANT, 0) > 0), MCA_TAXANT, MCA_VALTAX)) AS VALLIQ, ';
      strSQL := strSQL + '  SUM(IF(ME.MCA_VALREC IS NULL,0,ME.MCA_VALREC)) AS VALREC ';

    End
    Else If (cmbOpcao.ItemIndex = 2) Then
    Begin
      strSQL := strSQL + '  ME.MCA_DTAVEN AS DTAVEN, ';
      strSQL := strSQL + '  SUM(ME.MCA_VALSTA) AS VALBRU, ';  // * OK *
      strSQL := strSQL + '  SUM(IF((MCA_DTAREC IS NOT NULL) AND (COALESCE(MCA_TAXANT, 0) > 0), MCA_TAXANT, MCA_VALTAX)) AS VALTAX, ';
      strSQL := strSQL + '  SUM(IF(MCA_DTAREC IS NULL, 0, IFNULL(ME.MCA_VALSTA,0) - IFNULL(ME.MCA_VALREC,0))) AS TAXREC, ';
      strSQL := strSQL + '  SUM(IF(ME.MCA_VALORI IS NULL,0,ME.MCA_VALORI)) AS VALORI, ';
      strSQL := strSQL + '  SUM(ME.MCA_VALSTA - IF((MCA_DTAREC IS NOT NULL) AND (COALESCE(MCA_TAXANT, 0) > 0), MCA_TAXANT, MCA_VALTAX)) AS VALLIQ, ';
      strSQL := strSQL + '  SUM(IF(ME.MCA_VALREC IS NULL,0,ME.MCA_VALREC)) AS VALREC, ';
      strSQL := strSQL + '  CONCAT(ME.MCA_CODCAR,"-",CAR_DESCAR) AS CODCAR, ';
      strSQL := strSQL + '  CAR_DESCAR AS DESCAR, ';
      strSQL := strSQL + '  CONCAT(ME.MCA_CODCAR,"-",CAR_DESCAR) AS GRUPOS ';
    End
    Else If (cmbOpcao.ItemIndex = 3) Then
    Begin
      If edtOpcaoData.Text = 'V' Then
      Begin
        strMesAno := ' CONCAT(RIGHT( CONCAT("00",EXTRACT(MONTH FROM ME.MCA_DTAVEN)),2),"/", EXTRACT(YEAR FROM ME.MCA_DTAVEN)) ';
        strMesAnoO := ' CONCAT( EXTRACT(YEAR FROM ME.MCA_DTAVEN),"/", RIGHT( CONCAT("00",EXTRACT(MONTH FROM ME.MCA_DTAVEN)),2) ) ';
      End
      Else If edtOpcaoData.Text = 'C' Then
      Begin
        strMesAno := ' CONCAT(RIGHT( CONCAT("00",EXTRACT(MONTH FROM ME.MCA_DTACAD)),2),"/", EXTRACT(YEAR FROM ME.MCA_DTACAD)) ';
        strMesAnoO := ' CONCAT( EXTRACT(YEAR FROM ME.MCA_DTACAD),"/", RIGHT( CONCAT("00",EXTRACT(MONTH FROM ME.MCA_DTACAD)),2) ) ';
      End
      Else
      Begin
        strMesAno := ' CONCAT(RIGHT( CONCAT("00",EXTRACT(MONTH FROM ME.MCA_DTAREC)),2),"/", EXTRACT(YEAR FROM ME.MCA_DTAREC)) ';
        strMesAnoO := ' CONCAT( EXTRACT(YEAR FROM ME.MCA_DTAREC),"/", RIGHT( CONCAT("00",EXTRACT(MONTH FROM ME.MCA_DTAREC)),2) ) ';
      End;

      strSQL := strSQL + strMesAno + ' AS MESANO, ';
      strSQL := strSQL + '  SUM(ME.MCA_VALSTA) AS VALBRU, ';
      strSQL := strSQL + '  SUM(IF((MCA_DTAREC IS NOT NULL) AND (COALESCE(MCA_TAXANT, 0) > 0), ';
      strSQL := strSQL + '  MCA_TAXANT, MCA_VALSTA - MCA_VALORI)) AS VALTAX, ';
      strSQL := strSQL + '  SUM(IF(ME.MCA_VALORI IS NULL,0,ME.MCA_VALORI)) AS VALORI, ';
      strSQL := strSQL + '  SUM(IF(MCA_DTAREC IS NULL, 0, IFNULL(ME.MCA_VALSTA,0) - IFNULL(ME.MCA_VALREC,0))) AS TAXREC, ';
      strSQL := strSQL + '  SUM(ME.MCA_VALSTA - IF((MCA_DTAREC IS NOT NULL) AND (COALESCE(MCA_TAXANT, 0) > 0), MCA_TAXANT, MCA_VALTAX)) AS VALLIQ, ';
      strSQL := strSQL + '  SUM(IF(ME.MCA_VALREC IS NULL,0,ME.MCA_VALREC)) AS VALREC ';

    End;

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCAR ';
    strSQL := strSQL + '  JOIN MOVCAR ME ON ME.MCA_CODCAR = CAR_CODCAR ';

    If rdgEmpresa.ItemIndex = 0 Then
      strSQL := strSQL + ' JOIN CADEMP ON ME.MCA_CODEMP = EMP_CODEMP '
    Else
      strSQL := strSQL + ' JOIN CADEMP ON ME.MCA_EMPRCX = EMP_CODEMP ';

    strSQL := strSQL + '  LEFT JOIN CADOPE ON OPE_CODOPE = MCA_CODVEN ';
    strSQL := strSQL + 'WHERE TRUE ';

    Case rdgTipCar.ItemIndex Of
      0: strSQL := strSQL + ' AND ME.MCA_TIPCAR = "TEF" ';
      1: strSQL := strSQL + ' AND ME.MCA_TIPCAR = "POS" ';
    End;

    If edtTitulos.Text = 'Q' Then
      strSQL := strSQL + ' AND ME.MCA_DTAREC IS NOT NULL '
    Else If edtTitulos.Text = 'A' Then
      strSQL := strSQL + ' AND ME.MCA_DTAREC IS NULL ';

    If edtTipBai.Text = 'V' Then
      strSQL := strSQL + ' AND ME.MCA_TIPBAI="F" '
    Else If edtTipBai.Text = 'R' Then
      strSQL := strSQL + ' AND COALESCE(ME.MCA_TIPBAI,"") IN ("", "B") ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
      strSQL := strSQL + '  AND ME.MCA_DTAVEN BETWEEN :VENINI AND :VENFIN ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      strSQL := strSQL + '  AND ME.MCA_DTACAD BETWEEN :CADINI AND :CADFIN ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskRecIni.Text)) Then
      strSQL := strSQL + '  AND ME.MCA_DTAREC BETWEEN :RECINI AND :RECFIN ';


    If Not fEmptyStr(edtCodCartoes.Text) Then
      strSQL := strSQL + fStrLocate(edtCodCartoes, arrCartao,  'CAR_CODCAR', 'CODCAR');

    strSQL := strSQL + fStrLocate(edtCodBan, arrBandeira,  'CAR_CODBAN', 'CODBAN');

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + fStrLocate(edtCodEmpresa,  arrEmpresa,  'EMP_CODEMP', 'CODEMP')
    Else
      strSQL := strSQL + '  AND LOCATE(EMP_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    If Not fEmptyStr(edtPorBai.Text) Then
      strSQL := strSQL + fStrLocate(edtPorBai, arrPorBai, 'MCA_PORBAI', 'PORBAI')
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND (IFNULL(MCA_PORBAI, "") = "" ';
      strSQL := strSQL + ' OR LOCATE(MCA_PORBAI, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;


    {****************************************}
    {* FILTRA VENDEDOR QUANDO FOR SINTÉTICO *}
    {*************************************AL*}
    If (cmbOpcao.ItemIndex <> 0) And (Not fEmptyStr(edtCodVen.Text)) Then
    Begin
      strSQL := strSQL + '  AND EXISTS (SELECT ';
      strSQL := strSQL + '                CTR_NUMDUP ';
      strSQL := strSQL + '              FROM ';
      strSQL := strSQL + '                CADREC ';
      strSQL := strSQL + '              WHERE CTR_NUMDUP = LEFT(ME.MCA_DOCUME, 12) ';
      strSQL := strSQL + '                AND CTR_ESPDOC = SUBSTR(ME.MCA_DOCUME, 16, 2) ';
      strSQL := strSQL + '                AND CTR_CODEMP = SUBSTR(ME.MCA_DOCUME, 19, 3) ';
      strSQL := strSQL + '                AND CTR_CODCLI = ME.MCA_CODCLI ';
      strSQL := strSQL + fStrLocate(edtCodVen, arrVendedor, 'CTR_CODVEN', 'CODVEN') + ') ';
    End;

    If Not fEmptyStr(edtSeqCon.Text) Then
      strSQL := strSQL + '  AND ME.MCA_SEQCON = :SEQCON ';

    If Not fEmptyStr(edtCodOpe.Text) Then
      strSQL := strSQL + fStrLocate(edtCodOpe, arrOperador, 'MCA_CODOPE', 'CODOPE');

    If (cmbOpcao.ItemIndex = 1) Then
      strSQL := strSQL + '  GROUP BY ME.MCA_CODCAR '
    Else If (cmbOpcao.ItemIndex = 2) Then
      strSQL := strSQL + ' GROUP BY CODCAR, DTAVEN '
    Else If (cmbOpcao.ItemIndex = 3) Then
      strSQL := strSQL + ' GROUP BY ' + strMesAno + ' ';

    strSQL := strSQL + 'ORDER BY ';

    {*****************************************************}
    {* CRIOU CAMPO INDEPENDENTE PARA ORDENACAO DAS DATAS *}
    {**22/02/2011 - 10:33******************************DP*}
    If (cmbOpcao.ItemIndex = 0) Then
    Begin
      If (edtVenCar.Text = 'C') Then
      Begin
        If (edtOrdenarData.Text = 'V') Then
          strSQL := strSQL + '  CODCAR, DTAVEN, NUMDUP '
        Else
        Begin
          If (edtOrdenarData.Text = 'C') Then
            strSQL := strSQL + '  CODCAR, DTACAD, NUMDUP '
          Else
            strSQL := strSQL + '  CODCAR, DTAREC, NUMDUP '
        End;
      End
      Else
      Begin
        If (edtOrdenarData.Text = 'V') Then
          strSQL := strSQL + '  DTAVEN, CODCAR, NUMDUP '
        Else
        Begin
          If (edtOrdenarData.Text = 'C') Then
            strSQL := strSQL + '  DTACAD, CODCAR, NUMDUP '
          Else
            strSQL := strSQL + '  DTAREC, CODCAR, NUMDUP '
        End;
      End;
    End
    Else If (cmbOpcao.ItemIndex = 1) Then
    Begin
      strSQL := strSQL + '  ME.MCA_CODCAR ';
    End
    Else If (cmbOpcao.ItemIndex = 2) Then
      strSQL := strSQL + '  CODCAR, DTAVEN '
    Else If (cmbOpcao.ItemIndex = 3) Then
      strSQL := strSQL + strMesAnoO + ' DESC ';


    strSQL := strSQL + ') TAB ';

    If (Not fEmptyStr(edtCodVen.Text)) And (cmbOpcao.ItemIndex = 0) Then
      strSQL := strSQL + ' WHERE ' + fStrLocate(edtCodVen, arrVendedor, 'LEFT(CODVEN, 3)', 'CODVEN', True);

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        ParamByName('CADINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('CADFIN').AsDate := StrToDate(mskDtaFin.Text);
      End;

      If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
      Begin
        ParamByName('VENINI').AsDate := StrToDate(mskVenIni.Text);
        ParamByName('VENFIN').AsDate := StrToDate(mskVenFin.Text);
      End;

      If Not fEmptyStr(fTiraCaracEspeciais(mskRecIni.Text)) Then
      Begin
        ParamByName('RECINI').AsDate := StrToDate(mskRecIni.Text);
        ParamByName('RECFIN').AsDate := StrToDate(mskRecFin.Text);
      End;

      If Not fEmptyStr(edtCodCartoes.Text) Then
        pSetaParam(edtCodCartoes.Text, arrCartao, strCartao, 'CODCAR', qryRelatorio);

      pSetaParam(edtCodBan.Text, arrBandeira, strBandeira, 'CODBAN', qryRelatorio);

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryRelatorio);

      pSetaParam(edtCodVen.Text, arrVendedor, strVendedor, 'CODVEN', qryRelatorio);

      If Not fEmptyStr(edtSeqCon.Text) Then
        ParamByName('SEQCON').AsInteger := StrToInt(edtSeqCon.Text);

      If Not fEmptyStr(edtCodOpe.Text) Then
        pSetaParam(edtCodOpe.Text, arrOperador, strOperador, 'CODOPE', qryRelatorio);

      If Not fEmptyStr(edtPorBai.Text) Then
        pSetaParam(edtPorBai.Text, arrPorBai, strPorBai, 'PORBAI', qryRelatorio);

      Open;
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin

      If edtDestino.Text = 'E' Then
      Begin
        pGeraExcel;

        pnlInfo.Caption := '';
        btnImprimir.Enabled := True;

        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckCtrCartoes,frmQckCtrCartoes);

        frmQckCtrCartoes.dtsRelatorio.DataSet := qryRelatorio;

        frmQckCtrCartoes.blnAjuDta := chkAjuDta.Checked;

        If strTipImp = 'M' Then
        begin
          frmQckCtrCartoes.qckPagina.DefaultFilter := rldFiltro;
        end
        Else
        begin
          frmQckCtrCartoes.qckPagina.DefaultFilter := Nil;
        end;

        {*****************}
        {* CABEÇALHO QCK *}
        {**************LB*}

        If edtTitulos.Text = 'T' Then
        Begin
          If strTipImp = 'M' Then
          begin
            frmQckCtrCartoes.rllTitulo.Caption := 'TITULOS: TODOS';
          end
          else
          begin
            frmQckCtrCartoes.rllTitulo.Caption := 'TÍTULOS: TODOS';
          end;
        end
        Else
        Begin
          If edtTitulos.Text = 'A' Then
          Begin
            If strTipImp = 'M' Then
            begin
              frmQckCtrCartoes.rllTitulo.Caption := 'TITULOS: ABERTOS';
            end
            else
            begin
              frmQckCtrCartoes.rllTitulo.Caption := 'TÍTULOS: ABERTOS';
            end;
          end
          Else
          If edtTitulos.Text = 'Q' Then
          Begin
            If strTipImp = 'M' Then
            begin
              frmQckCtrCartoes.rllTitulo.Caption := 'TITULOS: QUITADOS';
            end
            else
            begin
              frmQckCtrCartoes.rllTitulo.Caption := 'TÍTULOS: QUITADOS';
            end;
          end;
        End;

        If edtOpcaoData.Text = 'V' Then
        Begin
          If strTipImp = 'M' Then
          begin
            frmQckCtrCartoes.rllOpcaoCartao.Caption := 'AGRUPADO POR DATA: VENCIMENTO';
          end
          else
          begin
            frmQckCtrCartoes.rllOpcaoCartao.Caption := 'AGRUPADO POR DATA: VENCIMENTO';
          end;
        End
        Else
        Begin
          If edtOpcaoData.Text = 'C' Then
          Begin
            If strTipImp = 'M' Then
            begin
              frmQckCtrCartoes.rllOpcaoCartao.Caption := 'AGRUPADO POR DATA: CADASTRO';
            end
            else
            begin
              frmQckCtrCartoes.rllOpcaoCartao.Caption := 'AGRUPADO POR DATA: CADASTRO';
            end;
          End
          Else
            If strTipImp = 'M' Then
            begin
              frmQckCtrCartoes.rllOpcaoCartao.Caption := 'AGRUPADO POR DATA: RECEBIMENTO';
            end
            else
            begin
              frmQckCtrCartoes.rllOpcaoCartao.Caption := 'AGRUPADO POR DATA: RECEBIMENTO';
            end;
        End;

        If fEmptyStr(edtCodCartoes.Text) Then
        Begin
          If strTipImp = 'M' Then
          begin
            frmQckCtrCartoes.rllNomCartao.Caption := 'CARTAO: TODOS';
          end
          else
          begin
            frmQckCtrCartoes.rllNomCartao.Caption := 'CARTÃO: TODOS';
          end;
        End
        Else
        Begin
          If strTipImp = 'M' Then
          begin
            frmQckCtrCartoes.rllNomCartao.Caption:= fStrTitulo(edtCodCartoes.Text, edtDesCartoes, arrCartao, strCartao, 'CARTAO');
          end
          else
          begin
            frmQckCtrCartoes.rllNomCartao.Caption:= fStrTitulo(edtCodCartoes.Text, edtDesCartoes, arrCartao, strCartao, 'CARTÃO');
          end;
        End;

        frmQckCtrCartoes.rllNomBan.Caption:= fStrTitulo(edtCodBan.Text, edtDesBan, arrBandeira, strBandeira, 'BANDEIRA');

        If edtTipBai.Text = 'V' Then
        Begin
          If strTipImp = 'M' Then
          begin
            frmQckCtrCartoes.rllTipoBaixa.Caption := 'FILTRO: CARTOES POR VENDA';
          end
          else
          begin
            frmQckCtrCartoes.rllTipoBaixa.Caption := 'FILTRO: CARTÕES POR VENDA';
          end;
        End
        Else
        If edtTipBai.Text = 'R' Then
        Begin
          If strTipImp = 'M' Then
          begin
            frmQckCtrCartoes.rllTipoBaixa.Caption := 'FILTRO: CARTOES POR RECEBIMENTO';
          end
          else
          begin
            frmQckCtrCartoes.rllTipoBaixa.Caption := 'FILTRO: CARTÕES POR RECEBIMENTO';
          end;
        end
        Else
        Begin
          frmQckCtrCartoes.rllTipoBaixa.Caption := 'FILTRO: TODOS';
        end;

        If fEmptyStr(edtCodEmpresa.Text) Then
          frmQckCtrCartoes.rllNomeEmp.Caption := 'EMPRESA: TODOS'
        Else
          frmQckCtrCartoes.rllNomeEmp.Caption := fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmpresa, strEmpresa, 'EMPRESA');

        frmQckCtrCartoes.rllVendedor.Caption := fStrTitulo(edtCodVen.Text, edtDesVen, arrVendedor, strVendedor, 'VENDEDOR');

        If fEmptyStr(edtCodOpe.Text) Then
          frmQckCtrCartoes.rllOperador.Caption := 'OPERADOR: TODOS'
        Else
          frmQckCtrCartoes.rllOperador.Caption:= fStrTitulo(edtCodOpe.Text, edtDesOpe, arrOperador, strOperador, 'OPERADOR');

        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          frmQckCtrCartoes.strOrdem := 'REFERENTE AO PERIODO ' + lblDtaIni.Caption + ' DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text
        Else
          frmQckCtrCartoes.strOrdem := 'REFERENTE AO PERIODO ' + lblDtaIni.Caption + ' TODOS';

        If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
          frmQckCtrCartoes.rllCabDtaVen.Caption := 'REFERENTE AO PERIODO (VENCIMENTO) DE ' + mskVenIni.Text + ' A ' + mskVenFin.Text
        Else
          frmQckCtrCartoes.rllCabDtaVen.Caption := 'REFERENTE AO PERIODO (VENCIMENTO) TODOS';

        If Not fEmptyStr(fTiraCaracEspeciais(mskRecIni.Text)) Then
          frmQckCtrCartoes.rllCabDtaRec.Caption := 'REFERENTE AO PERIODO (RECEBIMENTO) DE ' + mskRecIni.Text + ' A ' + mskRecFin.Text
        Else
          frmQckCtrCartoes.rllCabDtaRec.Caption := 'REFERENTE AO PERIODO (RECEBIMENTO) TODOS';

        frmQckCtrCartoes.rllTipoEmpresa.Caption := 'EMPRESA DE: ' + IfThen(rdgEmpresa.ItemIndex = 0, 'FATURAMENTO', 'ORIGEM');

        If strTipImp = 'M' Then
        begin
          frmQckCtrCartoes.rllTipCar.Caption := 'TIPO DE CARTAO: ' + IfThen(rdgTipCar.ItemIndex = 0, 'TEF', IfThen(rdgTipCar.ItemIndex = 1, 'POS', 'TODOS'));
        end
        else
        begin
          frmQckCtrCartoes.rllTipCar.Caption := 'TIPO DE CARTÃO: ' + IfThen(rdgTipCar.ItemIndex = 0, 'TEF', IfThen(rdgTipCar.ItemIndex = 1, 'POS', 'TODOS'));
        end;

        If fEmptyStr(edtPorBai.Text) Then
          frmQckCtrCartoes.rllPorBai.Caption := 'PORTADOR DA BAIXA: TODOS'
        Else
          frmQckCtrCartoes.rllPorBai.Caption := fStrTitulo(edtPorBai.Text, edtDesPorBai, arrPorBai, strPorBai, 'PORTADOR DA BAIXA');

        If (cmbOpcao.ItemIndex = 3) Then
        Begin
          If strTipImp = 'M' Then
          begin
            frmQckCtrCartoes.rllNomeRelatorio.Caption := 'RELATORIO DE CARTOES - SINTETICO POR MES/ANO';
          end
          else
          begin
            frmQckCtrCartoes.rllNomeRelatorio.Caption := 'RELATÓRIO DE CARTÕES - SINTÉTICO POR MES/ANO';
          end;

          frmQckCtrCartoes.rlbGrupo.Visible := False;
          frmQckCtrCartoes.rlbTitulo.Visible := False;
          frmQckCtrCartoes.rlbSintetico.Visible := True;
          frmQckCtrCartoes.rlbTituloSintetico.Visible := True;

          frmQckCtrCartoes.rldGrupoSint.DataField := 'MESANO';
          frmQckCtrCartoes.rllDescricao.Caption := 'MES/ANO';
        End
        Else
        If (cmbOpcao.ItemIndex = 1) Then
        Begin
          If strTipImp = 'M' Then
          begin
            frmQckCtrCartoes.rllNomeRelatorio.Caption := 'RELATORIO DE CARTOES - SINTETICO POR CARTAO';
          end
          else
          begin
            frmQckCtrCartoes.rllNomeRelatorio.Caption := 'RELATÓRIO DE CARTÕES - SINTÉTICO POR CARTÃO';
          end;

          frmQckCtrCartoes.rlbGrupo.Visible := False;
          frmQckCtrCartoes.rlbTitulo.Visible := False;
          frmQckCtrCartoes.rlbSintetico.Visible := True;
          frmQckCtrCartoes.rlbTituloSintetico.Visible := True;
        End
        Else If (cmbOpcao.ItemIndex = 2) Then
        Begin
          frmQckCtrCartoes.RLDBText6.Visible   := False;   // NumCCD
          frmQckCtrCartoes.RLDBText12.Visible  := False;   // NumDOC
          frmQckCtrCartoes.RLDBText2.Visible   := False;   // NumDup
          frmQckCtrCartoes.RLDBText3.Visible   := False;   // CodEmp
          frmQckCtrCartoes.RLDBText4.Visible   := False;   // DtaCad
          frmQckCtrCartoes.RLDBText9.Visible   := False;   // DtaRec
          frmQckCtrCartoes.RLDBText13.Visible  := False;   // PorBai
          frmQckCtrCartoes.RLDBText7.Visible   := False;   // TotOri
          frmQckCtrCartoes.rllTitDtaVen.Visible:= True;
          frmQckCtrCartoes.rllDtaVen.Visible   := True;

          frmQckCtrCartoes.RLDBText1.Left := 1;
          frmQckCtrCartoes.RLDBText5.Left := 27;

          If strTipImp = 'M' Then
          begin
            frmQckCtrCartoes.rllNomeRelatorio.Caption := 'RELATORIO DE CARTOES - SINTETICO POR CARTAO / VENCTO';
          end
          else
          begin
            frmQckCtrCartoes.rllNomeRelatorio.Caption := 'RELATÓRIO DE CARTÕES - SINTÉTICO POR CARTÃO / VENCTO';
          end;

          frmQckCtrCartoes.rlbGrupo.Visible := False;
          frmQckCtrCartoes.rlbTitulo.Visible := False;
          frmQckCtrCartoes.rlbSintetico.Visible := True;
          frmQckCtrCartoes.rlbTituloSintetico.Visible := True;

          frmQckCtrCartoes.rlbGrupo.DataFields := 'CODCAR';
          frmQckCtrCartoes.RLLabel11.Caption   := '';
          frmQckCtrCartoes.RLDBText1.DataField := 'CODCAR';
          frmQckCtrCartoes.RLLabel12.Caption   := 'TOTAL DO VENCTO.:';
          frmQckCtrCartoes.RLLabel4.Caption    := 'CARTAO';
          frmQckCtrCartoes.RLDBText5.DataField := 'DESCAR';
        End
        Else
        Begin
          If strTipImp = 'M' Then
          begin
            frmQckCtrCartoes.rllNomeRelatorio.Caption := 'RELATORIO DE CARTOES - ANALITICO';
          end
          else
          begin
            frmQckCtrCartoes.rllNomeRelatorio.Caption := 'RELATÓRIO DE CARTÕES - ANALÍTICO';
          end;

          If edtVenCar.Text = 'C' Then
          Begin
            If strTipImp = 'M' Then
            begin
              frmQckCtrCartoes.RLLabel11.Caption   := 'CARTAO DE CREDITO:';
              frmQckCtrCartoes.RLLabel12.Caption   := 'TOTAL DO CARTAO:';
            end
            else
            begin
              frmQckCtrCartoes.RLLabel11.Caption   := 'CARTÃO DE CRÉDITO:';
              frmQckCtrCartoes.RLLabel12.Caption   := 'TOTAL DO CARTÃO:';
            end;

            frmQckCtrCartoes.rlbGrupo.DataFields := 'CODCAR';
            frmQckCtrCartoes.RLDBText1.DataField := 'CODCAR';
          End
          Else
          Begin
            If edtOpcaoData.Text = 'V' Then
            Begin
              frmQckCtrCartoes.rlbGrupo.DataFields := 'DTAVEN';
              frmQckCtrCartoes.RLLabel11.Caption   := 'DATA DE VENCIMENTO:';
              frmQckCtrCartoes.RLDBText1.DataField := 'DTAVEN';
              frmQckCtrCartoes.RLLabel12.Caption   := 'TOTAL DO VENCTO.:';
              If strTipImp = 'M' Then
              begin
                frmQckCtrCartoes.RLLabel4.Caption    := 'CARTAO';
              end
              else
              begin
                frmQckCtrCartoes.RLLabel4.Caption    := 'CARTÃO';
              end;

              frmQckCtrCartoes.RLDBText5.DataField := 'DESCAR';
            End
            Else
            If edtOpcaoData.Text = 'C' Then
            Begin
              If strTipImp = 'M' Then
              begin
                frmQckCtrCartoes.RLLabel3.Caption    := 'CARTAO';
              end
              else
              begin
                frmQckCtrCartoes.RLLabel3.Caption    := 'CARTÃO';
              end;
              frmQckCtrCartoes.rlbGrupo.DataFields := 'DTACAD';
              frmQckCtrCartoes.RLLabel11.Caption   := 'DATA DE CADASTRO:';
              frmQckCtrCartoes.RLDBText1.DataField := 'DTACAD';
              frmQckCtrCartoes.RLLabel12.Caption   := 'TOTAL DA DATA:';
              frmQckCtrCartoes.RLDBText4.DataField := 'DESCAR';
            End
            Else
            Begin
              If strTipImp = 'M' Then
              begin
                frmQckCtrCartoes.RLLabel8.Caption    := 'CARTAO';
              end
              else
              begin
                frmQckCtrCartoes.RLLabel8.Caption    := 'CARTÃO';
              end;
              frmQckCtrCartoes.rlbGrupo.DataFields := 'DTAREC';
              frmQckCtrCartoes.RLLabel11.Caption   := 'DATA DE RECEBIMENTO:';
              frmQckCtrCartoes.RLDBText1.DataField := 'DTAREC';
              frmQckCtrCartoes.RLLabel12.Caption   := 'TOTAL DA RECTO.:';
              frmQckCtrCartoes.RLDBText9.DataField := 'DESCAR';
            End;
          End;
        End;

        If chkNaoExibeVend.Checked Then
        Begin
          frmQckCtrCartoes.rlbTitulo.Height       := frmQckCtrCartoes.rlbTitulo.Height - frmQckCtrCartoes.rllTitVen.Height;
          frmQckCtrCartoes.rllTitVen.Visible      := False;
          frmQckCtrCartoes.rllTitLib.Visible      := False;
          frmQckCtrCartoes.rlltitNumNsu.Visible   := False;
          frmQckCtrCartoes.rlbDetalheGrupo.Height := frmQckCtrCartoes.rlbDetalheGrupo.Height - frmQckCtrCartoes.rdbCODVEN.Height;
          frmQckCtrCartoes.rdbCODVEN.Visible      := False;
        End;

        If edtDestino.Text = 'V' Then
          frmQckCtrCartoes.qckPagina.PreviewModal
        Else
          frmQckCtrCartoes.qckPagina.Print;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;

      pFreeAndNil(frmQckCtrCartoes);

    End

    Else
    Begin
      pTabelaVazia;
    End;

  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
end;

procedure TfrmRelCtrCartoes.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  inherited;
end;

procedure TfrmRelCtrCartoes.edtCodOpeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodOpe, edtDesOpe, Nil, Key, arrOperador, False, True) Then
  Begin
    fValidaCampos(edtCodOpe,False);
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrCartoes.cmbOpcaoChange(Sender: TObject);
begin
  inherited;
  gbpVenCar.Enabled      := (cmbOpcao.ItemIndex = 0);
  edtVenCar.Enabled      := (cmbOpcao.ItemIndex = 0);
  edtOpcaoData.Enabled   := (cmbOpcao.ItemIndex = 0) Or (cmbOpcao.ItemIndex = 3);

  If cmbOpcao.ItemIndex = 2 Then
    edtOpcaoData.Text := 'V';
end;

procedure TfrmRelCtrCartoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If ((ActiveControl) = Nil) Or (SameText(ActiveControl.ClassName, 'TGroupButton')) Or ((ActiveControl) Is TRadioButton) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmRelCtrCartoes.edtCodBanExit(Sender: TObject);
begin
  inherited;

  If Not edtCodBan.ReadOnly Then
    pEdtCodSelectExit(edtCodBan, edtDesBan, arrBandeira, fRetNomBandeira, Nil, 'da bandeira');

end;

procedure TfrmRelCtrCartoes.edtCodBanKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE BANDEIRAS DE CARTOES *}
  {**************************************DP*}
  If fPesqCartaoBandeira(Self, edtCodBan, edtDesBan, Nil, Key, arrBandeira, False) Then
  Begin
    fValidaCampos(edtCodBan,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrCartoes.pGeraExcel;

  var
    arrAnalitico: Array Of Array Of String;
    arrSintetico: Array Of Array Of String;

    intCont  : Integer;
    intQtdCol: Integer;
    strUltCol: String;
    strGrupo : String;
    objExcel : TExcel;
    strOperadora : String;

    RecTotGru: TRecTot;
    RecTotGer: TRecTot;

    procedure pZeraTotais(Var recTotais: TRecTot);
    begin
      With recTotais Do
      Begin
        fltValBru := 0;
        fltValTax := 0;
        fltValLiq := 0;
        fltTaxRec := 0;
        fltValRec := 0;
      End;
    end;

    procedure pSomaTotais(Var recTotais: TRecTot);
    begin
      With recTotais Do
      Begin
        fltValBru := fltValBru + qryRelatorio.FieldByName('VALBRU').AsCurrency;
        fltValTax := fltValTax + qryRelatorio.FieldByName('VALTAX').AsCurrency;
        fltValLiq := fltValLiq + qryRelatorio.FieldByName('VALLIQ').AsCurrency;
        fltTaxRec := fltTaxRec + qryRelatorio.FieldByName('TAXREC').AsCurrency;
        fltValRec := fltValRec + qryRelatorio.FieldByName('VALREC').AsCurrency;
      End;
    End;

    procedure pMontaResumo(Var recTotais: TRecTot; intResumo: Integer);
      Var
        strTotal: String;
        intColun: Integer;
    begin
      With objExcel, recTotais Do
      Begin

        intColun := 7;

        If (intResumo = 1) Then strTotal := 'TOTAL GRUPO: ';
        If (intResumo = 2) Then strTotal := 'TOTAL GERAL: ';
        If (cmbOpcao.ItemIndex = 1) Or (cmbOpcao.ItemIndex = 3) Then
          intColun := 1
        Else If (cmbOpcao.ItemIndex = 2) Then
          intColun := 2;


        ProximaLinha;

        Escrever(LinhaAtual, 01, strTotal);
        Escrever(LinhaAtual, intColun + 1, fPadL(FormatFloat('##,#0.00', fltValBru), 12));
        Escrever(LinhaAtual, intColun + 2, fPadL(FormatFloat('##,#0.00', fltValTax), 12));
        Escrever(LinhaAtual, intColun + 3, fPadL(FormatFloat('##,#0.00', fltValLiq), 12));
        Escrever(LinhaAtual, intColun + 4, fPadL(FormatFloat('##,#0.00', fltTaxRec), 12));
        Escrever(LinhaAtual, intColun + 5, fPadL(FormatFloat('##,#0.00', fltValRec), 12));

        Negrito(LinhaAtual, 01, True);
        Alinhamento('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Direita);
        If cmbOpcao.ItemIndex = 0 Then Mesclar ('A' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual));

        CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
        CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
        Bordas  ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

      End;
    end;

begin

  SetLength(arrAnalitico, 16, 2);
  If cmbOpcao.ItemIndex = 2 Then
    SetLength(arrSintetico, 07, 2)
  Else
    SetLength(arrSintetico, 06, 2);

  arrAnalitico[00][00] := 'DUPLICATA';
  arrAnalitico[01][00] := 'EMPRESA';
  arrAnalitico[02][00] := 'DTA.CAD.';
  arrAnalitico[03][00] := 'DTA.VEN.';
  arrAnalitico[04][00] := 'DOC.ORIG.';
  arrAnalitico[05][00] := 'DTA.REC.';
  arrAnalitico[06][00] := 'VL.TOTAL';
  arrAnalitico[07][00] := 'VL.BRUTO';
  arrAnalitico[08][00] := 'VL.TAXA';
  arrAnalitico[09][00] := 'VL.LIQUIDO';
  arrAnalitico[10][00] := 'VR.TAXA REC';
  arrAnalitico[11][00] := 'VL.RECEB.';
  arrAnalitico[12][00] := 'POR.BAIXA';
  arrAnalitico[13][00] := 'LIBERAÇÃO';
  arrAnalitico[14][00] := 'NUM. NSU';
  arrAnalitico[15][00] := 'VENDEDOR';

  arrAnalitico[00][01] := 'NUMDUP';
  arrAnalitico[01][01] := 'CODEMP';
  arrAnalitico[02][01] := 'DTACAD';
  arrAnalitico[03][01] := 'DTAVEN';
  arrAnalitico[04][01] := 'DOCUME';
  arrAnalitico[05][01] := 'DTAREC';
  arrAnalitico[06][01] := 'TOTORI';
  arrAnalitico[07][01] := 'VALBRU';
  arrAnalitico[08][01] := 'VALTAX';
  arrAnalitico[09][01] := 'VALLIQ';
  arrAnalitico[10][01] := 'TAXREC';
  arrAnalitico[11][01] := 'VALREC';
  arrAnalitico[12][01] := 'PORBAI';
  arrAnalitico[13][01] := 'NUMCCD';
  arrAnalitico[14][01] := 'NUMNSU';
  arrAnalitico[15][01] := 'CODVEN';

  If cmbOpcao.ItemIndex = 3 Then
    arrSintetico[00][00] := 'MÊS/ANO'
  Else
    arrSintetico[00][00] := 'OPERADORA';

  If cmbOpcao.ItemIndex = 2 Then
  Begin
    arrSintetico[01][00] := 'VENCIMENTO';
    arrSintetico[02][00] := 'VL.BRUTO';
    arrSintetico[03][00] := 'VL.TAXA';
    arrSintetico[04][00] := 'VL.LIQUIDO';
    arrSintetico[05][00] := 'VR.TAXA REC';
    arrSintetico[06][00] := 'VL.RECEB.';
  End
  Else
  Begin
    arrSintetico[01][00] := 'VL.BRUTO';
    arrSintetico[02][00] := 'VL.TAXA';
    arrSintetico[03][00] := 'VL.LIQUIDO';
    arrSintetico[04][00] := 'VR.TAXA REC';
    arrSintetico[05][00] := 'VL.RECEB.';
  End;

  If cmbOpcao.ItemIndex = 3 Then
    arrSintetico[00][01] := 'MESANO'
  Else If cmbOpcao.ItemIndex = 2 Then
  Begin
    arrSintetico[00][01] := 'CODCAR';
    arrSintetico[01][01] := 'DTAVEN';
    arrSintetico[02][01] := 'VALBRU';
    arrSintetico[03][01] := 'VALTAX';
    arrSintetico[04][01] := 'VALLIQ';
    arrSintetico[05][01] := 'TAXREC';
    arrSintetico[06][01] := 'VALREC';
  End
  Else If cmbOpcao.ItemIndex = 1 Then
    arrSintetico[00][01] := 'DESCAR';

  If cmbOpcao.ItemIndex <> 2 Then
  Begin
    arrSintetico[01][01] := 'VALBRU';
    arrSintetico[02][01] := 'VALTAX';
    arrSintetico[03][01] := 'VALLIQ';
    arrSintetico[04][01] := 'TAXREC';
    arrSintetico[05][01] := 'VALREC';
  End;

  objExcel := TExcel.fCriarExcel(Self);

  If Not objExcel.CriarArquivo Then
  begin
    FreeAndNil(objExcel);
    Exit;
  End;

  With objExcel Do
  Begin

    PintarTudo(Branco);
    DefinirFonte(CourierNew, 10);

    pZeraTotais(RecTotGru);
    pZeraTotais(RecTotGer);

    LinhaAtual := 1;
    pnlInfo.Caption       := 'Aguarde... Gerando Arquivo!';

    Escrever(ProximaLinha,01, fRetNomeEmpresa);
    Case cmbOpcao.ItemIndex Of
      0 : Escrever(ProximaLinha,01, 'RELATÓRIO DE CARTÕES - ANALÍTICO');
      1 : Escrever(ProximaLinha,01, 'RELATÓRIO DE CARTÕES - SINTÉTICO POR CARTÃO');
      2 : Escrever(ProximaLinha,01, 'RELATÓRIO DE CARTÕES - SINTÉTICO POR CARTÃO/VENCTO');
      3 : Escrever(ProximaLinha,01, 'RELATÓRIO DE CARTÕES - SINTÉTICO POR MÊS/ANO');
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Escrever(ProximaLinha,01, 'REFERENTE AO PERIODO DE (CADASTRO) DE ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaIni.Text)) + ' A ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaFin.Text)))
    Else
      Escrever(ProximaLinha,01, 'REFERENTE AO PERIODO DE (CADASTRO) TODOS ');

    If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
      Escrever(ProximaLinha,01, 'REFERENTE AO PERIODO DE (VENCIMENTO) DE ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskVenIni.Text)) + ' A ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskVenFin.Text)))
    Else
      Escrever(ProximaLinha,01, 'REFERENTE AO PERIODO DE (VENCIMENTO) TODOS ');

    If Not fEmptyStr(fTiraCaracEspeciais(mskRecIni.Text)) Then
      Escrever(ProximaLinha,01, 'REFERENTE AO PERIODO DE (RECEBIMENTO) DE ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskRecIni.Text)) + ' A ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskRecFin.Text)))
    Else
      Escrever(ProximaLinha,01, 'REFERENTE AO PERIODO DE (RECEBIMENTO) TODOS ');

    Escrever(ProximaLinha,01, 'TÍTULOS: ' + IfThen(edtTitulos.Text = 'T', 'TODOS', IfThen(edtTitulos.Text = 'A', 'ABERTOS', 'QUITADOS')));
    Escrever(ProximaLinha,01, 'FILTRO: '  + IfThen(edtTipBai.Text = 'V', 'CARTÕES POR VENDA', IfThen(edtTipBai.Text = 'R', 'CARTÕES POR RECEBIMENTO', 'TODOS')));
    Escrever(ProximaLinha,01, fStrTitulo(edtCodBan.Text, edtDesBan, arrBandeira, strBandeira, 'BANDEIRA'));
    Escrever(ProximaLinha,01, 'EMPRESA DE: ' + IfThen(rdgEmpresa.ItemIndex = 0, 'FATURAMENTO', 'ORIGEM'));
    Escrever(ProximaLinha,01, 'TIPO DE CARTÃO: ' + IfThen(rdgTipCar.ItemIndex = 0, 'TEF', IfThen(rdgTipCar.ItemIndex = 1, 'POS', 'TODOS')));
    Escrever(ProximaLinha,01, IfThen(fEmptyStr(edtCodCartoes.Text), 'CARTÃO: TODOS', fStrTitulo(edtCodCartoes.Text, edtDesCartoes, arrCartao, strCartao, 'CARTÃO')));
    Escrever(ProximaLinha,01, 'OPÇÕES POR DATA: ' + IfThen(edtOpcaoData.Text = 'V', 'VENCIMENTO', IfThen(edtOpcaoData.Text = 'C', 'CADASTRO', 'RECEBIMENTO')));
    Escrever(ProximaLinha,01, IfThen(fEmptyStr(edtCodEmpresa.Text), 'EMPRESA: TODAS', fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmpresa, strEmpresa, 'EMPRESA')));
    Escrever(ProximaLinha,01, IfThen(fEmptyStr(edtCodOpe.Text), 'OPERADOR: TODOS', fStrTitulo(edtCodOpe.Text, edtDesOpe, arrOperador, strOperador, 'OPERADOR')));
    Escrever(ProximaLinha,01, IfThen(fEmptyStr(edtCodVen.Text), 'VENDEDOR: TODOS', fStrTitulo(edtCodVen.Text, edtDesVen, arrVendedor, strVendedor, 'VENDEDOR')));
    Escrever(ProximaLinha,01, fStrTitulo(edtPorBai.Text, edtDesPorBai, arrPorBai, strPorBai, 'PORTADOR DA BAIXA'));

    With qryRelatorio Do
    Begin

      If cmbOpcao.ItemIndex = 0 Then
      Begin

        intQtdCol  := Length(arrAnalitico);
        // intQtdCol -3 Porque a coluna de Liberação, Número do NSU e Vendedor está na linha de baixo
        strUltCol  := fGetLetraAlfa(intQtdCol -3);

        For intCont := 1 To LinhaAtual Do
        Begin
          Mesclar('A' + IntToStr(intCont), strUltCol + IntToStr(intCont));
          Negrito('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), True);
          Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Centro);
        End;

        CorFundo('A2', strUltCol + '3', Cinza);
        Bordas('A2', strUltCol + '3',True,True,True,True);

        ProximaLinha;

        For intCont := 1 To intQtdCol Do
        Begin
          If Not chkNaoExibeVend.Checked Then
          Begin
            If (arrAnalitico[intCont -1, 01] = 'NUMCCD') Then
            Begin
              CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
              CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
              Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

              ProximaLinha;
              Escrever(LinhaAtual, 1, arrAnalitico[intCont - 1, 00]);
              Negrito(LinhaAtual, 1, True);

              If FieldByName(arrAnalitico[intCont - 1, 01]).DataType = ftFloat Then
                Alinhamento(LinhaAtual,1, Direita)
              Else
                Alinhamento(LinhaAtual,1, Esquerda);
            End
            Else
            Begin
              If arrAnalitico[intCont -1 ,01] = 'CODVEN' then
              Begin
                Escrever(LinhaAtual, 3, arrAnalitico[intCont - 1, 00]);
                Negrito(LinhaAtual, 3, True);
                Mesclar('C' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));
              End
              Else If arrAnalitico[intCont -1 ,01] = 'NUMNSU' then
              Begin
                Escrever(LinhaAtual, 2, arrAnalitico[intCont - 1, 00]);
                Negrito(LinhaAtual, 2, True);
              End
              Else
              Begin
                Escrever(LinhaAtual, intCont, arrAnalitico[intCont - 1, 00]);
                Negrito(LinhaAtual, intCont, True);
              End;

              If FieldByName(arrAnalitico[intCont - 1, 01]).DataType = ftFloat Then
                Alinhamento(LinhaAtual,intCont, Direita)
              Else
                Alinhamento(LinhaAtual,intCont, Esquerda);
            End;
          End
          Else If (arrAnalitico[intCont -1, 01] <> 'CODVEN') and
                  (arrAnalitico[intCont -1, 01] <> 'NUMCCD') and
                  (arrAnalitico[intCont -1, 01] <> 'NUMNSU') Then
          Begin
            Escrever(LinhaAtual, intCont, arrAnalitico[intCont - 1, 00]);
            Negrito(LinhaAtual, intCont, True);

            If FieldByName(arrAnalitico[intCont - 1, 01]).DataType = ftFloat Then
              Alinhamento(LinhaAtual,intCont, Direita)
            Else
              Alinhamento(LinhaAtual,intCont, Esquerda);
          End;
        End;

        CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
        CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
        Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

        First;

        While Not Eof Do
        Begin

          strGrupo := FieldByName('GRUPOS').AsString;
          Escrever(ProximaLinha, 01, strGrupo);
          Negrito(LinhaAtual, 01, True);

          Mesclar('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));
          CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Verde_Mar);
          CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
          Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True, True, False, False);

          While (Not Eof) And (FieldByName('GRUPOS').AsString = strGrupo) Do
          Begin

            ProximaLinha;

            For intCont := 1 To intQtdCol Do
            Begin
              If Not chkNaoExibeVend.Checked Then
              Begin
                If (arrAnalitico[intCont -1, 01] = 'NUMCCD') Then
                Begin
                  ProximaLinha;

                  If FieldByName(arrAnalitico[intCont - 1, 01]).DataType = ftFloat Then
                  Begin
                    Escrever(LinhaAtual, 1, FormatFloat('##,#0.00', FieldByName(arrAnalitico[intCont - 1, 01]).AsFloat));
                    Alinhamento(LinhaAtual, 1, Direita);
                  End
                  Else
                  Begin
                    Escrever(LinhaAtual, 1, '''' + FieldByName(arrAnalitico[intCont - 1, 01]).AsString);
                    Alinhamento(LinhaAtual, 1, Esquerda);
                  End;
                End
                Else
                Begin
                  If arrAnalitico[intCont -1 ,01] = 'CODVEN' then
                  Begin
                    If FieldByName(arrAnalitico[intCont - 1, 01]).DataType = ftFloat Then
                    Begin
                      Escrever(LinhaAtual, 3, FormatFloat('##,#0.00', FieldByName(arrAnalitico[intCont - 1, 01]).AsFloat));
                      Alinhamento(LinhaAtual, 3, Direita);
                    End
                    Else
                    Begin
                      Escrever(LinhaAtual, 3, '''' + FieldByName(arrAnalitico[intCont - 1, 01]).AsString);
                      Alinhamento(LinhaAtual, 3, Esquerda);
                    End;
                    Mesclar('C' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));
                  End
                  Else If arrAnalitico[intCont -1 ,01] = 'NUMNSU' then
                  Begin
                    If FieldByName(arrAnalitico[intCont - 1, 01]).DataType = ftFloat Then
                    Begin
                      Escrever(LinhaAtual, 2, FormatFloat('##,#0.00', FieldByName(arrAnalitico[intCont - 1, 01]).AsFloat));
                      Alinhamento(LinhaAtual, 2, Direita);
                    End
                    Else
                    Begin
                      Escrever(LinhaAtual, 2, '''' + FieldByName(arrAnalitico[intCont - 1, 01]).AsString);
                      Alinhamento(LinhaAtual, 2, Esquerda);
                    End;
                  End
                  Else
                  Begin
                    If FieldByName(arrAnalitico[intCont - 1, 01]).DataType = ftFloat Then
                    Begin
                      Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', FieldByName(arrAnalitico[intCont - 1, 01]).AsFloat));
                      Alinhamento(LinhaAtual, intCont, Direita);
                    End
                    Else
                    Begin
                      Escrever(LinhaAtual, intCont, '''' + FieldByName(arrAnalitico[intCont - 1, 01]).AsString);
                      Alinhamento(LinhaAtual, intCont, Esquerda);
                    End;
                  End;
                End;
              End
              Else If (arrAnalitico[intCont -1, 01] <> 'CODVEN') and
                      (arrAnalitico[intCont -1, 01] <> 'NUMCCD') and
                      (arrAnalitico[intCont -1, 01] <> 'NUMNSU') Then
              Begin
                If FieldByName(arrAnalitico[intCont - 1, 01]).DataType = ftFloat Then
                Begin
                  Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', FieldByName(arrAnalitico[intCont - 1, 01]).AsFloat));
                  Alinhamento(LinhaAtual, intCont, Direita);
                End
                Else
                Begin
                  Escrever(LinhaAtual, intCont, '''' + FieldByName(arrAnalitico[intCont - 1, 01]).AsString);
                  Alinhamento(LinhaAtual, intCont, Esquerda);
                End;
              End;
            End;

            Bordas('A' + IntToStr(LinhaAtual -1), strUltCol + IntToStr(LinhaAtual));

            If  (LinhaAtual Mod 4 = 0)    And
            Not (chkNaoExibeVend.Checked) Then
              CorFundo('A' + IntToStr(LinhaAtual -1), strUltCol + IntToStr(LinhaAtual), Cinza);

            pSomaTotais(RecTotGru);
            pSomaTotais(RecTotGer);

            Next;

          End;

          pMontaResumo(RecTotGru,1);
          pZeraTotais(RecTotGru);

        End;
      End
      Else If (cmbOpcao.ItemIndex = 1) or (cmbOpcao.ItemIndex = 3) Then
      Begin

        intQtdCol  := Length(arrSintetico);
        strUltCol  := fGetLetraAlfa(intQtdCol);

        For intCont := 1 To LinhaAtual Do
        Begin
          Mesclar('A' + IntToStr(intCont), strUltCol + IntToStr(intCont));
          Negrito('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), True);
          Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Centro);
        End;

        CorFundo('A2', strUltCol + '3', Cinza);
        Bordas('A2', strUltCol + '3',True,True,True,True);

        ProximaLinha;

        For intCont := 1 To intQtdCol Do
        Begin
          Escrever(LinhaAtual, intCont, arrSintetico[intCont - 1, 00]);
          Negrito(LinhaAtual, intCont, True);

          If FieldByName(arrSintetico[intCont - 1, 01]).DataType = ftFloat Then
            Alinhamento(LinhaAtual,intCont, Direita)
          Else
            Alinhamento(LinhaAtual,intCont, Esquerda);

        End;

        CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
        CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
        Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

        First;

        While Not Eof Do
        Begin

          ProximaLinha;

          For intCont := 1 To intQtdCol Do
          Begin

            If FieldByName(arrSintetico[intCont - 1, 01]).DataType = ftFloat Then
            Begin
              Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', FieldByName(arrSintetico[intCont - 1, 01]).AsFloat));
              Alinhamento(LinhaAtual, intCont, Direita);
            End
            Else
            Begin
              Escrever(LinhaAtual, intCont, '''' + FieldByName(arrSintetico[intCont - 1, 01]).AsString);
              Alinhamento(LinhaAtual, intCont, Esquerda);
            End;

          End;

          Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

          If  (LinhaAtual Mod 2 = 0)     And
          Not (chkNaoExibeVend.Checked) Then
            CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Cinza);

          pSomaTotais(RecTotGru);
          pSomaTotais(RecTotGer);

          Next;

        End;

      End
      Else
      Begin

        intQtdCol  := Length(arrSintetico);
        strUltCol  := fGetLetraAlfa(intQtdCol);

        For intCont := 1 To LinhaAtual Do
        Begin
          Mesclar('A' + IntToStr(intCont), strUltCol + IntToStr(intCont));
          Negrito('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), True);
          Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Centro);
        End;

        CorFundo('A2', strUltCol + '3', Cinza);
        Bordas('A2', strUltCol + '3',True,True,True,True);

        ProximaLinha;

        For intCont := 1 To intQtdCol Do
        Begin
          Escrever(LinhaAtual, intCont, arrSintetico[intCont - 1, 00]);
          Negrito(LinhaAtual, intCont, True);

          If FieldByName(arrSintetico[intCont - 1, 01]).DataType = ftFloat Then
            Alinhamento(LinhaAtual,intCont, Direita)
          Else
            Alinhamento(LinhaAtual,intCont, Esquerda);

        End;

        CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
        CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
        Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

        strOperadora := '';

        First;

        While Not Eof Do
        Begin

          ProximaLinha;

          For intCont := 1 To intQtdCol Do
          Begin

            If FieldByName(arrSintetico[intCont - 1, 01]).DataType = ftFloat Then
            Begin
              Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', FieldByName(arrSintetico[intCont - 1, 01]).AsFloat));
              Alinhamento(LinhaAtual, intCont, Direita);
            End
            Else
            Begin
              Escrever(LinhaAtual, intCont, '''' + FieldByName(arrSintetico[intCont - 1, 01]).AsString);
              Alinhamento(LinhaAtual, intCont, Esquerda);

              If cmbOpcao.ItemIndex <> 2 Then
              Begin
                If arrSintetico[intCont - 1, 01] = 'CODCAR' Then
                Begin
                  If strOperadora <> FieldByName('CODCAR').AsString Then
                  Begin
                    ProximaLinha;
                    Escrever(LinhaAtual, intCont, '''' + FieldByName('DTAVEN').AsString);
                    Alinhamento(LinhaAtual, intCont, Direita);
                    strOperadora := FieldByName('CODCAR').AsString;
                   End
                  Else
                  Begin
                    Escrever(LinhaAtual, intCont, '''' + FieldByName('DTAVEN').AsString);
                    Alinhamento(LinhaAtual, intCont, Direita);
                  End;
                End;
              End;

            End;

          End;

          Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

          If  (LinhaAtual Mod 2 = 0)     And
          Not (chkNaoExibeVend.Checked) Then
            CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Cinza);

          pSomaTotais(RecTotGru);
          pSomaTotais(RecTotGer);

          Next;

        End;

      End;

      pMontaResumo(RecTotGer,2);
      pZeraTotais(RecTotGer);

      OrientacaoPagina(Retrato);

      If cmbOpcao.ItemIndex = 0 Then
        CongelarPaines('A20')
      Else
        CongelarPaines('A19');

      AutoAjuste;
      SalvarArquivo;
      FecharArquivo;

      pnlInfo.Caption := '';

      fMensagem('ATENÇÃO','Arquivo gerado com sucesso!',['&OK']);
    End;
  End;

  FreeAndNil(objExcel);

end;

end.

