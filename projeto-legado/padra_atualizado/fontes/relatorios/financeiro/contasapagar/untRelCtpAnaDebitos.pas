unit untRelCtpAnaDebitos;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter,
  EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  QColorLabel, Menus, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  Uni, Db, AppEvnts, ComObj, untFuncoesFactory, UniDataSetProvider, UniClientDataSet,
  Windows, BitBtnLockedIncrem, untTypesSistema, frxExportCSVTestabilidade,
  untIFuncoes, untExcel, untIZClient, Vcl.ComCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore,
  cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, RLReport, cxProgressBar;

type
  TfrmRelCtpAnaDebitos = class(TfrmPaiRelatorio)
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    edtCodFornecedor: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtDesEmpresa: TEditFocus;
    Label1: TLabel;
    edtCodEve: TEditFocus;
    edtDesEve: TEditFocus;
    Label2: TLabel;
    mskCodCta: TMaskEditFocus;
    edtDesCta: TEditFocus;
    gpbOpcao: TGroupBox;
    chkResumoEmpresa: TCheckBox;
    svdExcel: TSaveDialog;
    chkAjuDta: TCheckBox;
    ColorLabel9: TColorLabel;
    ColorLabel10: TColorLabel;
    cbxOpcao: TComboBox;
    Label3: TLabel;
    edtCodAtv: TEditFocus;
    edtDesAtv: TEditFocus;
    edtDesPortador: TEditFocus;
    edtCodPor: TEditFocus;
    lblPortador: TLabel;
    chkExiCreditos: TCheckBox;
    chkNExiCreditos: TCheckBox;
    dtsRelatorio: TDataSource;
    mskCompet: TMaskEditFocus;
    Label4: TLabel;
    gpbVeioNF: TRadioGroup;
    rdgBoleto: TRadioGroup;
    rdgDeposito: TRadioGroup;
    rdgCheque: TRadioGroup;
    rdgForFil: TRadioGroup;
    rdgOrdem: TRadioGroup;
    rdgOrdemAnalitico: TRadioGroup;
    rdgIncPrevis: TRadioGroup;
    rdgValorASerExibido: TRadioGroup;
    rdgImpHistCmp: TRadioGroup;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    chkListaDesmembramento: TCheckBox;
    chkNovaPaginaQuebra: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure edtCodFornecedorExit(Sender: TObject);
    procedure edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodEveExit(Sender: TObject);
    procedure edtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure mskCodCtaExit(Sender: TObject);
    procedure mskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtDestinoExit(Sender: TObject);
    procedure cbxOpcaoChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodAtvExit(Sender: TObject);
    procedure edtCodAtvKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure chkExiCreditosClick(Sender: TObject);
    procedure chkNExiCreditosClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
  private
    { Private declarations }
    qryRelEmp: IZClient;
    qryRelatorio: TUniQuery;

    fltValChq: Double;
    fltValBol: Double;
    fltValDep: Double;
    fltValOut: Double;

    function fGeraExcel(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pGeraExcel;
    procedure pAjustaData(DataSet : TDataSet);
    procedure pCriaQryRelatorio;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
    arrFornecedor  : TConsultasArray;
    arrEvento      : TConsultasArray;
    arrCentroCusto : TConsultasArray;
    arrEmpresa     : TConsultasArray;
    arrAtividade   : TConsultasArray;
    arrPortador    : TConsultasArray;

    strFornecedor  : String;
    strEvento      : String;
    strCentroCusto : String;
    strEmpresa     : String;
    strAtividade   : String;
    strPortador    : String;

    cdsRelatorio: TUniClientDataSet;
  end;

var
  frmRelCtpAnaDebitos: TfrmRelCtpAnaDebitos;

const
  IDX_AN_ATI = 0; // Analítico por Atividade
  IDX_AN_VEN = 1; // Analítico por Data de Vencimento
  IDX_AN_EVE = 2; // Analítico por Evento
  IDX_AN_FOR = 3; // Analítico por Fornecedor
  IDX_AN_POR = 4; // Analítico por Portador
  IDX_SN_VEN = 5; // Síntético por Data de Vencimento
  IDX_SN_FOR = 6; // Sintético por Fornecedor

implementation

uses untQckCtpAnalDebitos,untPai,untGravando;

{$R *.dfm}

procedure TfrmRelCtpAnaDebitos.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaIni.Date := VS_Date;
  mskDtaFin.Date := VS_Date;

  inherited;
end;

procedure TfrmRelCtpAnaDebitos.edtCodFornecedorExit(Sender: TObject);
begin
  inherited;
  If Not edtCodFornecedor.ReadOnly Then
    pEdtCodSelectExit(edtCodFornecedor, edtDesFornecedor, arrFornecedor, fRetNomFornecedor, Nil, 'do fornecedor');
end;

procedure TfrmRelCtpAnaDebitos.edtCodFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFornecedor, edtDesFornecedor, Nil, Key, arrFornecedor, False) Then
  Begin
    fValidaCampos(edtCodFornecedor,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpAnaDebitos.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If Not edtCodPor.ReadOnly Then
    pEdtCodSelectExit(edtCodPor, edtDesPortador, arrPortador, Nil, fRetNomPortador, 'do portador');
end;

procedure TfrmRelCtpAnaDebitos.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPortador, nil, Key, arrPortador, False) Then
  Begin
    If fValidaCampos(edtCodPor,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpAnaDebitos.edtCodAtvExit(Sender: TObject);
begin
  inherited;
  If Not edtCodAtv.ReadOnly Then
    pEdtCodSelectExit(edtCodAtv, edtDesAtv, arrAtividade, Nil, fRetNomAtividade, 'da atividade');
end;

procedure TfrmRelCtpAnaDebitos.edtCodAtvKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqAtividade(Self, edtCodAtv, edtDesAtv, Nil, Key, arrAtividade, False) Then
  Begin
    fValidaCampos(edtCodAtv,False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpAnaDebitos.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  If Not edtCodEmpresa.ReadOnly Then
    pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmRelCtpAnaDebitos.edtCodEmpresaKeyPress(Sender: TObject;
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

function TfrmRelCtpAnaDebitos.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&Ok']);
          Sender := mskDtaIni;
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (StrToDateDef(mskDtaFin.Text, 0) <= 0) Then
          Begin
            fMensagem('', 'Data Final informada é invalida! Necessário correção.', ['&O k']);
            Result := False;
          End
          Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
          Begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
            Sender := mskDtaIni;
            Result := False;
          End;
        End;
      End;

    End
    Else
    If (Sender = mskDtaIni) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (StrToDateDef(mskDtaIni.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'Data Inicial informada é invalida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaIni;
      End;
    End;

    if (Sender = mskCompet) then
    Begin

      if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
      begin

        If not fValidaDataStr('01/'+ mskCompet.Text) Then
        Begin
          pMensagemOk('Data informada na Competência não é válida!');
          Result := False;
        End;

      end;

    End

    Else If (Sender = edtDestino) Then
    Begin
      If fEmptyStr(edtDestino.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido.', ['&Ok']);
        Result := False;
      End
      Else If (Pos(edtDestino.Text, 'V_I_E_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser V, I ou E.', ['&Ok']);
        Result := False;

      End;
    End

    {*********************************}
    {* VERIFICA CAMPO EMPRESA        *}
    {******************************LU*}
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

    Else If Sender = edtCodPor Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) And (edtCodPor.Text <> '00000') Then
      Begin

        edtDesPortador.Text := fRetNomPortador(edtCodPor.Text);

        If fEmptyStr(edtDesPortador.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else
        if (edtCodPor.Text = '00000') Then
          edtDesPortador.Text := '+1'
        else
          edtDesPortador.Text := 'TODOS';

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelCtpAnaDebitos.btnImprimirClick(Sender: TObject);

  Const STR_FILTRO = ' AND IFNULL(FILTRO,"N") = "S" '; //GROUP BY FILTRO ';

  {******************************}
  {* DEVE SEGUIR A HIERARQUIA   *}
  {* - BOLETO                   *}
  {* - CHEQUE                   *}
  {* - DEPOSITO                 *}
  {******************************}
  Const STR_VEIOBO = ' P.CTP_VEIOBO ';
  Const STR_USACHQ = ' IF(IF(P.CTP_VEIOBO = "S", "S", "N") = "S", "N", P.CTP_USACHQ) ';
  // ' IF(IFNULL(P.CTP_VEIOBO, "N") = "S", "N", P.CTP_USACHQ) ';
  Const STR_DEPOSI = ' IF(IF(P.CTP_VEIOBO = "S", "S", "N") = "S", "N", IF(IF(P.CTP_USACHQ = "S", "S", "N") = "S", "N", IF(IF(P.CTP_DEPOSI = "S", "S", "N") = "S", "S", "N"))) ';
  // ' IF(IFNULL(P.CTP_VEIOBO, "N") = "S", "N", IF(IFNULL(P.CTP_USACHQ, "N") = "S", "N", IF(IFNULL(P.CTP_DEPOSI, "N") = "S", "S", "N"))) ';//' IF(IFNULL(P.CTP_VEIOBO, "N") = "S", "N", IF(IFNULL(P.CTP_USACHQ, "N") = "S", "N", P.CTP_DEPOSI)) ';


  Var
    strSQL   : String;
    strSQL2  : String;
    strSQL3  : String;
    strSQL4  : String;
    strSQL5  : String;

    dtsGen   : TDataSource;
    qryRelRes: IZClient;

    intCont  : Integer;
    cdsAuxilia : TUniClientDataSet;

begin
  If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
     (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
  Begin
    fMensagem('', 'A data de Vencimento deve ser selecionada!', ['&OK']);
    pSetFocus(mskDtaIni);
    Exit;
  End;

  Try

    pnlInfo.Caption := 'Gerando Relatório...';
    pnlInfo.Repaint;
    Application.ProcessMessages;

    If SameText(edtDestino.Text, 'E') Then
    Begin
      btnImprimir.Enabled := False;
      blnImprime := fVerificaCampos;
    End
    Else
      inherited;

    dtsGen := fCriaDataSource(qryRelEmp.fGetDataset);

    {***********************************}
    {* ACRESCENTOU DETALHAMENTO CTPDET *}
    {**28/02/2011-08:54**************DP*}
    If (blnImprime) Then
    Begin

      If (cbxOpcao.ItemIndex = IDX_AN_VEN) Or (cbxOpcao.ItemIndex = IDX_AN_EVE) Or (cbxOpcao.ItemIndex = IDX_AN_ATI) Then
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
        strSQL := strSQL + '  P.CTP_DTACAD, ';
        strSQL := strSQL + '  P.CTP_DTAVEN, ';
        strSQL := strSQL + '  P.CTP_NUMDUP, ';
        strSQL := strSQL + '  P.CTP_PARCEL, ';
        strSQL := strSQL + '  P.CTP_HIST01, ';
        strSQL := strSQL + '  P.CTP_HIST02, ';

        If chkListaDesmembramento.Checked Then
        Begin
          strSQL := strSQL + '  IF(D.CTP_CODEMP IS NULL, P.CTP_CODEMP, D.CTP_CODEMP) AS CTP_CODEMP, ';
          strSQL := strSQL + '  IF(D.CTP_CODCTA IS NULL, P.CTP_CODCTA, D.CTP_CODCTA) AS CTP_CODCTA, ';
        End
        Else
        Begin
          strSQL := strSQL + '  P.CTP_CODEMP, ';
          strSQL := strSQL + '  P.CTP_CODCTA, ';
        End;

        strSQL := strSQL + '  ' + STR_VEIOBO + ' AS CTP_VEIOBO, ';
        strSQL := strSQL + '  ' + STR_DEPOSI + ' AS CTP_DEPOSI, ';
        strSQL := strSQL + '  IF(' + STR_USACHQ + ' = "" OR ' + STR_USACHQ + ' IS NULL, "N", ' + STR_USACHQ + ') AS CTP_USACHQ, ';
        strSQL := strSQL + '  REPLACE(CONCAT(IFNULL(P.CTP_HIST01, ""), " ", IFNULL(P.CTP_HIST02, "")), "<<csq>>", " ") AS CTP_HISCOM, ';
        strSQL := strSQL + '  P.CTP_PREVIS, ';
        strSQL := strSQL + '  P.CTP_DTAPAG, ';
        strSQL := strSQL + '  P.CTP_VALORI, ';

        If chkListaDesmembramento.Checked Then
        Begin
          strSQL := strSQL + '  (IF(D.CTP_FATCAL IS NULL, P.CTP_VALDUP, ROUND(P.CTP_VALDUP*D.CTP_FATCAL,2))) AS CTP_VALDUP, ';
          strSQL := strSQL + '  (IF(D.CTP_FATCAL IS NULL, P.CTP_DESSUJ, ROUND(P.CTP_DESSUJ*D.CTP_FATCAL,2))) AS CTP_DESSUJ, ';
          strSQL := strSQL + '  (IF(D.CTP_FATCAL IS NULL, P.CTP_JURSUJ, ROUND(P.CTP_JURSUJ*D.CTP_FATCAL,2))) AS CTP_JURSUJ, ';
          strSQL := strSQL + '  (IF(D.CTP_FATCAL IS NULL, P.CTP_VENDOR, ROUND(P.CTP_VENDOR*D.CTP_FATCAL,2))) AS CTP_VENDOR, ';
        End
        Else
        Begin
          strSQL := strSQL + '  P.CTP_VALDUP, ';
          strSQL := strSQL + '  P.CTP_DESSUJ, ';
          strSQL := strSQL + '  P.CTP_JURSUJ, ';
          strSQL := strSQL + '  P.CTP_VENDOR, ';
        End;

        strSQL := strSQL + '  P.CTP_CODEVE, ';
        strSQL := strSQL + '  P.CTP_CODFOR, ';
        strSQL := strSQL + '  P.CTP_TIPDOC, '; // Necessário para verificar se é tributo.
        strSQL := strSQL + '  F.FOR_NOMFOR, ';
        strSQL := strSQL + '  F.FOR_CODFOR, ';
        strSQL := strSQL + '  A.ATI_CODATI ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  CADPAG P ';
        strSQL := strSQL + '  JOIN CADFOR F ON P.CTP_CODFOR = F.FOR_CODFOR ';
        strSQL := strSQL + '  LEFT JOIN CADATI A ON A.ATI_CODATI = F.FOR_CODATI ';

        If chkListaDesmembramento.Checked Then
        Begin
          strSQL := strSQL + '  INNER JOIN CTPDET D ON P.CTP_CODFOR = D.CTP_CODFOR AND P.CTP_NUMDUP = D.CTP_NUMDUP AND ';
          strSQL := strSQL + '                         P.CTP_PARCEL = D.CTP_PARCEL AND P.CTP_CODEMP = D.CTP_EMPORI AND ';
          strSQL := strSQL + '                       ((P.CTP_SERIE_ = D.CTP_SERIE_) OR ';
          strSQL := strSQL + '                       (((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = "")) AND ((D.CTP_SERIE_ IS NULL) OR (D.CTP_SERIE_ = "")))) ';
        End;

        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  P.CTP_DTAPAG IS NULL AND ';
        strSQL := strSQL + '  P.CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

        if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
          strSQL := strSQL + '  AND P.CTP_COMPET = :COMPET ';

        If chkResumoEmpresa.Checked Then
        Begin
          strSQL2 := '';
          strSQL2 := strSQL2 + 'SELECT SQL_NO_CACHE ';

          If chkListaDesmembramento.Checked Then
            strSQL2 := strSQL2 + '  CONCAT(IF(D.CTP_CODEMP IS NULL,P.CTP_CODEMP,D.CTP_CODEMP), '
          Else
            strSQL2 := strSQL2 + '  CONCAT(P.CTP_CODEMP, ';

          strSQL2 := strSQL2 + '" - ", E.EMP_NOMEMP) AS CODEMP, ';

          If rdgValorASerExibido.ItemIndex = 0 Then
          Begin
            If chkListaDesmembramento.Checked Then
              strSQL2 := strSQL2 + '  (IF(D.CTP_FATCAL IS NULL, P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ,0) + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_VENDOR,0), ' +
                                   '                            ROUND(P.CTP_VALDUP*D.CTP_FATCAL,2) - ROUND(IFNULL(P.CTP_DESSUJ,0)*D.CTP_FATCAL,2) + ' +
                                   '                            ROUND(IFNULL(P.CTP_JURSUJ,0)*D.CTP_FATCAL,2) + ROUND(IFNULL(P.CTP_VENDOR,0)*D.CTP_FATCAL,2)) ' +
                                   ' ) AS VALOR '
            Else
              strSQL2 := strSQL2 + '  ((P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ,0) + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_VENDOR,0))) AS VALOR ';
          End
          Else
          Begin
            If chkListaDesmembramento.Checked Then
              strSQL2 := strSQL2 + '  (IF(D.CTP_FATCAL IS NULL, P.CTP_VALDUP + IFNULL(P.CTP_VENDOR,0), ROUND(P.CTP_VALDUP*D.CTP_FATCAL,2) + ROUND(IFNULL(P.CTP_VENDOR,0)*D.CTP_FATCAL,2)) '+
                                   ' ) AS VALOR '
            Else
              strSQL2 := strSQL2 + '  (P.CTP_VALDUP + IFNULL(P.CTP_VENDOR,0)) AS VALOR ';
          End;

          strSQL2 := strSQL2 + ', P.CTP_CODFOR, P.CTP_NUMDUP, CTP_DTAVEN, CTP_TIPDOC ';
          strSQL2 := strSQL2 + 'FROM ';
          strSQL2 := strSQL2 + '  CADPAG P ';
          strSQL2 := strSQL2 + '  JOIN CADFOR F    ON P.CTP_CODFOR  = F.FOR_CODFOR ';
          strSQL2 := strSQL2 + '  LEFT JOIN CADATI ON ATI_CODATI    = F.FOR_CODATI ';

          If chkListaDesmembramento.Checked Then
          Begin
            strSQL2 := strSQL2 + '  LEFT JOIN CTPDET D ON P.CTP_CODFOR   = D.CTP_CODFOR  '+
                                 '                    AND P.CTP_NUMDUP   = D.CTP_NUMDUP  '+
                                 '                    AND P.CTP_PARCEL   = D.CTP_PARCEL  '+
                                 '                    AND P.CTP_CODEMP   = D.CTP_EMPORI  '+
                                 '                    AND ((P.CTP_SERIE_ = D.CTP_SERIE_) '+
                                 '                     OR (((P.CTP_SERIE_ IS NULL)       '+
                                 '                     OR (P.CTP_SERIE_  = ""))          '+
                                 '                    AND ((D.CTP_SERIE_ IS NULL)        '+
                                 '                     OR (D.CTP_SERIE_  = ""))))        ';
            strSQL2 := strSQL2 + '  JOIN CADEMP E    ON IF(D.CTP_CODEMP IS NULL,P.CTP_CODEMP,D.CTP_CODEMP)  = E.EMP_CODEMP ';
          End
          Else
            strSQL2 := strSQL2 + '  JOIN CADEMP E    ON P.CTP_CODEMP = E.EMP_CODEMP ';

          strSQL2 := strSQL2 + 'WHERE ';
          strSQL2 := strSQL2 + '  P.CTP_DTAPAG IS NULL AND ';
          strSQL2 := strSQL2 + '  P.CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

          if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
            strSQL2 := strSQL2 + '  AND P.CTP_COMPET = :COMPET ';

        End;

        {***********************************}
        { SELECT RESUMO BOLETO\CHEQUE       }
        {********************************JB*}
        strSQL4 := '';
        strSQL4 := strSQL4 + 'SELECT ';

        If rdgValorASerExibido.ItemIndex = 0 Then
        Begin
          If chkListaDesmembramento.Checked Then
            strSQL4 := strSQL4 + '  SUM(IF(D.CTP_FATCAL IS NULL, P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ,0) + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_VENDOR,0), ' +
                                 '      ROUND(P.CTP_VALDUP*D.CTP_FATCAL,2) - ROUND(IFNULL(P.CTP_DESSUJ,0)*D.CTP_FATCAL,2) + ROUND(IFNULL(P.CTP_JURSUJ,0)*D.CTP_FATCAL,2) ' +
                                 '     + ROUND(IFNULL(P.CTP_VENDOR,0)*D.CTP_FATCAL,2) ) ' +
                                 '     ) AS VALOR '
          Else
            strSQL4 := strSQL4 + '  SUM(P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ,0) + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_VENDOR,0)) AS VALOR ';
        End
        Else
        Begin
          If chkListaDesmembramento.Checked Then
            strSQL4 := strSQL4 + '  SUM(IF(D.CTP_FATCAL IS NULL, P.CTP_VALDUP + IFNULL(P.CTP_VENDOR,0), ' +
                                 '      ROUND(P.CTP_VALDUP*D.CTP_FATCAL,2) + ROUND(IFNULL(P.CTP_VENDOR,0)*D.CTP_FATCAL,2))) AS VALOR '
          Else
            strSQL4 := strSQL4 + '  SUM(P.CTP_VALDUP + IFNULL(P.CTP_VENDOR,0)) AS VALOR ';
        End;

        strSQL4 := strSQL4 + ', CTP_DTAVEN, CTP_TIPDOC ';
        strSQL4 := strSQL4 + 'FROM ';
        strSQL4 := strSQL4 + '  CADPAG P ';
        strSQL4 := strSQL4 + '  JOIN CADFOR F      ON P.CTP_CODFOR = F.FOR_CODFOR ';
        strSQL4 := strSQL4 + '  LEFT JOIN CADATI   ON ATI_CODATI   = F.FOR_CODATI ';

        If chkListaDesmembramento.Checked Then
          strSQL4 := strSQL4 + '  LEFT JOIN CTPDET D ON P.CTP_CODFOR   = D.CTP_CODFOR  '+
                               '                    AND P.CTP_NUMDUP   = D.CTP_NUMDUP  '+
                               '                    AND P.CTP_PARCEL   = D.CTP_PARCEL  '+
                               '                    AND P.CTP_CODEMP   = D.CTP_EMPORI  '+
                               '                    AND ((P.CTP_SERIE_ = D.CTP_SERIE_) '+
                               '                     OR (((P.CTP_SERIE_ IS NULL)       '+
                               '                     OR (P.CTP_SERIE_  = ""))          '+
                               '                    AND ((D.CTP_SERIE_ IS NULL)        '+
                               '                     OR (D.CTP_SERIE_  = ""))))        ';

        strSQL4 := strSQL4 + 'WHERE ';
        strSQL4 := strSQL4 + '  P.CTP_DTAPAG IS NULL AND ';
        strSQL4 := strSQL4 + '  P.CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

        if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
          strSQL4 := strSQL4 + '  AND P.CTP_COMPET = :COMPET ';

      End
      Else If (cbxOpcao.ItemIndex = IDX_AN_FOR) Or (cbxOpcao.ItemIndex = IDX_AN_POR) Then
      Begin
        {********************************}
        {* ACRESCENTOU CTPDET           *}
        {**28/02/2011-09:55***********DP*}
        strSQL := '';
        strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
        strSQL := strSQL + '  P.CTP_DTACAD, ';
        strSQL := strSQL + '  P.CTP_DTAVEN, ';
        strSQL := strSQL + '  P.CTP_NUMDUP, ';
        strSQL := strSQL + '  P.CTP_PARCEL, ';
        strSQL := strSQL + '  P.CTP_HIST01, ';
        strSQL := strSQL + '  P.CTP_HIST02, ';

        If chkListaDesmembramento.Checked Then
        Begin
          strSQL := strSQL + '  IF(D.CTP_CODEMP IS NULL, P.CTP_CODEMP, D.CTP_CODEMP) AS CTP_CODEMP, ';
          strSQL := strSQL + '  IF(D.CTP_CODCTA IS NULL, P.CTP_CODCTA, D.CTP_CODCTA) AS CTP_CODCTA, ';
        End
        Else
        Begin
          strSQL := strSQL + '  P.CTP_CODEMP, ';
          strSQL := strSQL + '  P.CTP_CODCTA, ';
        End;

        strSQL := strSQL + '  ' + STR_VEIOBO + ' AS CTP_VEIOBO, ';
        strSQL := strSQL + '  ' + STR_DEPOSI + ' AS CTP_DEPOSI, ';
        strSQL := strSQL + '  IF(' + STR_USACHQ + ' = "" OR ' + STR_USACHQ + ' IS NULL, "N", ' + STR_USACHQ + ') AS CTP_USACHQ, ';
        strSQL := strSQL + '  REPLACE(CONCAT(IFNULL(P.CTP_HIST01, ""), " ", IFNULL(P.CTP_HIST02, "")), "<<csq>>", " ") AS CTP_HISCOM, ';
        strSQL := strSQL + '  P.CTP_PREVIS, ';
        strSQL := strSQL + '  P.CTP_DTAPAG, ';
        strSQL := strSQL + '  P.CTP_VALORI, ';

        If chkListaDesmembramento.Checked Then
        Begin
          strSQL := strSQL + '  (IF(D.CTP_FATCAL IS NULL, P.CTP_VALDUP, ROUND(P.CTP_VALDUP*D.CTP_FATCAL,2))) AS CTP_VALDUP, ';
          strSQL := strSQL + '  (IF(D.CTP_FATCAL IS NULL, P.CTP_DESSUJ, ROUND(P.CTP_DESSUJ*D.CTP_FATCAL,2))) AS CTP_DESSUJ, ';
          strSQL := strSQL + '  (IF(D.CTP_FATCAL IS NULL, P.CTP_JURSUJ, ROUND(P.CTP_JURSUJ*D.CTP_FATCAL,2))) AS CTP_JURSUJ, ';
          strSQL := strSQL + '  (IF(D.CTP_FATCAL IS NULL, P.CTP_VENDOR, ROUND(P.CTP_VENDOR*D.CTP_FATCAL,2))) AS CTP_VENDOR, ';
        End
        Else
        Begin
          strSQL := strSQL + '  P.CTP_VALDUP, ';
          strSQL := strSQL + '  P.CTP_DESSUJ, ';
          strSQL := strSQL + '  P.CTP_JURSUJ, ';
          strSQL := strSQL + '  P.CTP_VENDOR, ';
        End;

        strSQL := strSQL + '  P.CTP_CODFOR, ';
        strSQL := strSQL + '  P.CTP_TIPDOC, '; // Necessário para verificar se é tributo.
        strSQL := strSQL + '  F.FOR_NOMFOR, ';
        strSQL := strSQL + '  F.FOR_CODFOR, ';
        strSQL := strSQL + '  COALESCE(P.CTP_CODPOR, "") AS CTP_CODPOR, ';
        strSQL := strSQL + '  COALESCE(POR_NOMPOR, "") AS POR_NOMPOR, ';
        strSQL := strSQL + '  CONCAT(P.CTP_NUMDUP, P.CTP_PARCEL) AS PARCEL, ';
        strSQL := strSQL + '  CONCAT(F.FOR_CODFOR, " - ", F.FOR_NOMFOR) NOMFOR ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  CADPAG P ';

        strSQL := strSQL + '  JOIN CADEMP E    ON P.CTP_CODEMP = E.EMP_CODEMP ';
        strSQL := strSQL + '  JOIN CADFOR F    ON P.CTP_CODFOR = F.FOR_CODFOR ';
        strSQL := strSQL + '  LEFT JOIN CADATI ON ATI_CODATI   = F.FOR_CODATI ';
        strSQL := strSQL + '  LEFT JOIN CADPOR ON POR_CODPOR   = P.CTP_CODPOR ';

        If chkListaDesmembramento.Checked Then
        Begin
          strSQL := strSQL + '  INNER JOIN CTPDET D ON P.CTP_CODFOR = D.CTP_CODFOR AND P.CTP_NUMDUP = D.CTP_NUMDUP AND ';
          strSQL := strSQL + '                         P.CTP_PARCEL = D.CTP_PARCEL AND P.CTP_CODEMP = D.CTP_EMPORI AND ';
          strSQL := strSQL + '                       ((P.CTP_SERIE_ = D.CTP_SERIE_) OR ';
          strSQL := strSQL + '                       (((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = "")) AND ((D.CTP_SERIE_ IS NULL) OR (D.CTP_SERIE_ = "")))) ';
        End;

        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  P.CTP_DTAPAG IS NULL AND ';
        strSQL := strSQL + '  P.CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

        if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
          strSQL := strSQL + '  AND P.CTP_COMPET = :COMPET ';

        If chkResumoEmpresa.Checked Then
        Begin
          strSQL2 := '';
          strSQL2 := strSQL2 + 'SELECT SQL_NO_CACHE ';

          If chkListaDesmembramento.Checked Then
            strSQL2 := strSQL2 + '  CONCAT(IF(D.CTP_CODEMP IS NULL,P.CTP_CODEMP,D.CTP_CODEMP), '
          Else
            strSQL2 := strSQL2 + '  CONCAT(P.CTP_CODEMP, ';

          strSQL2 := strSQL2 + '" - ", E.EMP_NOMEMP) AS CODEMP, ';

          If rdgValorASerExibido.ItemIndex = 0 Then
          Begin
            If chkListaDesmembramento.Checked Then
              strSQL2 := strSQL2 + '  (IF(D.CTP_FATCAL IS NULL, P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ,0) + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_VENDOR,0), ' +
                                   '   ROUND(P.CTP_VALDUP*D.CTP_FATCAL,2) - ROUND(IFNULL(P.CTP_DESSUJ,0)*D.CTP_FATCAL,2) + ' +
                                   '   ROUND(IFNULL(P.CTP_JURSUJ,0)*D.CTP_FATCAL,2) + ROUND(IFNULL(P.CTP_VENDOR,0)*D.CTP_FATCAL,2))) AS VALOR '
            Else
              strSQL2 := strSQL2 + '  ((P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ,0) + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_VENDOR,0) + ' +
                                   '   ROUND(IFNULL(P.CTP_JURSUJ,0),2) + ROUND(IFNULL(P.CTP_VENDOR,0),2))) AS VALOR ';
          End
          Else
          Begin
            If chkListaDesmembramento.Checked Then
              strSQL2 := strSQL2 + '  (IF(D.CTP_FATCAL IS NULL, P.CTP_VALDUP + IFNULL(P.CTP_VENDOR,0), ' +
                                   '   ROUND(P.CTP_VALDUP*D.CTP_FATCAL,2) + ROUND(IFNULL(P.CTP_VENDOR,0)*D.CTP_FATCAL,2))) AS VALOR '
            Else
              strSQL2 := strSQL2 + '  (P.CTP_VALDUP + IFNULL(P.CTP_VENDOR,0)) AS VALOR ';
          End;
          strSQL2 := strSQL2 + ', CTP_DTAVEN, CTP_TIPDOC, ';
          strSQL2 := strSQL2 + '  F.FOR_CODFOR, ';
          strSQL2 := strSQL2 + '  CONCAT(P.CTP_NUMDUP, P.CTP_PARCEL) AS PARCEL ';
          strSQL2 := strSQL2 + 'FROM ';
          strSQL2 := strSQL2 + '  CADPAG P ';
          strSQL2 := strSQL2 + '  JOIN CADFOR F    ON P.CTP_CODFOR  = F.FOR_CODFOR ';
          strSQL2 := strSQL2 + '  LEFT JOIN CADATI ON ATI_CODATI    = F.FOR_CODATI ';
          strSQL2 := strSQL2 + '  LEFT JOIN CADPOR ON POR_CODPOR    = P.CTP_CODPOR ';

          If chkListaDesmembramento.Checked Then
          Begin
            strSQL2 := strSQL2 + '  LEFT JOIN CTPDET D ON P.CTP_CODFOR  = D.CTP_CODFOR  '+
                                 '                    AND P.CTP_NUMDUP  = D.CTP_NUMDUP  '+
                                 '                    AND P.CTP_PARCEL  = D.CTP_PARCEL  '+
                                 '                    AND P.CTP_CODEMP  = D.CTP_EMPORI  '+
                                 '                    AND ((P.CTP_SERIE_= D.CTP_SERIE_) '+
                                 '                     OR (((P.CTP_SERIE_ IS NULL)      '+
                                 '                     OR (P.CTP_SERIE_ = ""))          '+
                                 '                    AND ((D.CTP_SERIE_ IS NULL)       '+
                                 '                     OR (D.CTP_SERIE_ = ""))))        ';
            strSQL2 := strSQL2 + '  JOIN CADEMP E    ON IF(D.CTP_CODEMP IS NULL,P.CTP_CODEMP,D.CTP_CODEMP)  = E.EMP_CODEMP ';
          End
          Else
            strSQL2 := strSQL2 + '  JOIN CADEMP E    ON P.CTP_CODEMP = E.EMP_CODEMP ';

          strSQL2 := strSQL2 + 'WHERE ';
          strSQL2 := strSQL2 + '  P.CTP_DTAPAG IS NULL AND ';
          strSQL2 := strSQL2 + '  P.CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

          if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
            strSQL2 := strSQL2 + '  AND P.CTP_COMPET = :COMPET ';
        End;

        {***********************************}
        { SELECT RESUMO BOLETO\CHEQUE       }
        {********************************JB*}
        strSQL4 := '';
        strSQL4 := strSQL4 + 'SELECT ';

        If rdgValorASerExibido.ItemIndex = 0 Then
        Begin
          If chkListaDesmembramento.Checked Then
            strSQL4 := strSQL4 + '  SUM(IF(D.CTP_FATCAL IS NULL, P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ,0) + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_VENDOR,0), ' +
                                 '      ROUND(P.CTP_VALDUP*D.CTP_FATCAL,2) - ROUND(IFNULL(P.CTP_DESSUJ,0)*D.CTP_FATCAL,2) + ' +
                                 '      ROUND(IFNULL(P.CTP_JURSUJ,0)*D.CTP_FATCAL,2) + ROUND(IFNULL(P.CTP_VENDOR,0)*D.CTP_FATCAL,2))) AS VALOR '
          Else
            strSQL4 := strSQL4 + '  SUM(P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ,0) + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_VENDOR,0)) AS VALOR ';
        End
        Else
        Begin
          If chkListaDesmembramento.Checked Then
            strSQL4 := strSQL4 + '  SUM(IF(D.CTP_FATCAL IS NULL, P.CTP_VALDUP  + IFNULL(P.CTP_VENDOR,0), ' +
                                 '      ROUND(P.CTP_VALDUP*D.CTP_FATCAL,2) + ROUND(IFNULL(P.CTP_VENDOR,0)*D.CTP_FATCAL,2))) AS VALOR '
          Else
            strSQL4 := strSQL4 + '  SUM(P.CTP_VALDUP  + IFNULL(P.CTP_VENDOR,0)) AS VALOR ';
        End;
        strSQL4 := strSQL4 + ', CTP_DTAVEN, CTP_TIPDOC ';
        strSQL4 := strSQL4 + 'FROM ';
        strSQL4 := strSQL4 + '  CADPAG P ';
        strSQL4 := strSQL4 + '  JOIN CADFOR F    ON P.CTP_CODFOR    = F.FOR_CODFOR  ';
        strSQL4 := strSQL4 + '  LEFT JOIN CADATI ON ATI_CODATI      = F.FOR_CODATI  ';
        strSQL4 := strSQL4 + '  LEFT JOIN CADPOR ON POR_CODPOR   = P.CTP_CODPOR ';

        If chkListaDesmembramento.Checked Then
          strSQL4 := strSQL4 + '  LEFT JOIN CTPDET D ON P.CTP_CODFOR   = D.CTP_CODFOR  '+
                               '                    AND P.CTP_NUMDUP   = D.CTP_NUMDUP  '+
                               '                    AND P.CTP_PARCEL   = D.CTP_PARCEL  '+
                               '                    AND P.CTP_CODEMP   = D.CTP_EMPORI  '+
                               '                    AND ((P.CTP_SERIE_ = D.CTP_SERIE_) '+
                               '                     OR (((P.CTP_SERIE_ IS NULL)       '+
                               '                     OR (P.CTP_SERIE_  = ""))          '+
                               '                    AND ((D.CTP_SERIE_ IS NULL)        '+
                               '                     OR (D.CTP_SERIE_  = ""))))        ';

        strSQL4 := strSQL4 + 'WHERE ';
        strSQL4 := strSQL4 + '  P.CTP_DTAPAG IS NULL AND ';
        strSQL4 := strSQL4 + '  P.CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

        if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
          strSQL4 := strSQL4 + '  AND P.CTP_COMPET = :COMPET ';

      End
      Else
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
        strSQL := strSQL + '  P.CTP_CODFOR, ';
        strSQL := strSQL + '  F.FOR_NOMFOR, ';

        If rdgValorASerExibido.ItemIndex = 0 Then
        Begin
          If chkListaDesmembramento.Checked Then
            strSQL := strSQL + '  SUM(IF(D.CTP_FATCAL IS NULL, P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ,0) + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_VENDOR,0), ' +
                               '      ROUND(P.CTP_VALDUP*D.CTP_FATCAL,2) - ROUND(IFNULL(P.CTP_DESSUJ,0)*D.CTP_FATCAL,2) + ROUND(IFNULL(P.CTP_JURSUJ,0)*D.CTP_FATCAL,2) + ' +
                               '      ROUND(IFNULL(P.CTP_VENDOR,0)*D.CTP_FATCAL,2))) AS CTP_VALDUP, '
          Else
            strSQL := strSQL + '  SUM(P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ,0) + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_VENDOR,0)) AS CTP_VALDUP, ';
        End
        Else
        Begin
          If chkListaDesmembramento.Checked Then
            strSQL := strSQL + '  SUM(IF(D.CTP_FATCAL IS NULL, P.CTP_VALDUP + IFNULL(P.CTP_VENDOR,0), '+
                               '      ROUND(P.CTP_VALDUP*D.CTP_FATCAL,2) + ROUND(IFNULL(P.CTP_VENDOR,0)*D.CTP_FATCAL,2))) AS CTP_VALDUP, '
          Else
            strSQL := strSQL + '  SUM(P.CTP_VALDUP + IFNULL(P.CTP_VENDOR,0)) AS CTP_VALDUP, ';
        End;

        strSQL := strSQL + '  CONCAT(F.FOR_CODFOR, " - ", F.FOR_NOMFOR) NOMFOR, ';
        strSQL := strSQL + '  P.CTP_DTAVEN, ';
        strSQL := strSQL + '  P.CTP_NUMDUP, ';
        strSQL := strSQL + '  P.CTP_TIPDOC, '; // Necessário para verificar se é tributo.
        strSQL := strSQL + '  P.CTP_PARCEL ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  CADPAG P ';
        strSQL := strSQL + '  JOIN CADFOR F      ON P.CTP_CODFOR = F.FOR_CODFOR';
        strSQL := strSQL + '  LEFT JOIN CADATI   ON ATI_CODATI   = F.FOR_CODATI ';

        If chkListaDesmembramento.Checked Then
        Begin
          strSQL := strSQL + '  LEFT JOIN CTPDET D ON P.CTP_CODFOR = D.CTP_CODFOR AND P.CTP_NUMDUP = D.CTP_NUMDUP AND ';
          strSQL := strSQL + '                         P.CTP_PARCEL = D.CTP_PARCEL AND P.CTP_CODEMP = D.CTP_EMPORI AND ';
          strSQL := strSQL + '                       ((P.CTP_SERIE_ = D.CTP_SERIE_) OR ';
          strSQL := strSQL + '                       (((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = "")) AND ((D.CTP_SERIE_ IS NULL) OR (D.CTP_SERIE_ = "")))) ';
        End;

        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  P.CTP_DTAPAG IS NULL AND ';
        strSQL := strSQL + '  P.CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

        if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
          strSQL := strSQL + '  AND P.CTP_COMPET = :COMPET ';

        If chkResumoEmpresa.Checked Then
        Begin
          strSQL2 := '';
          strSQL2 := strSQL2 + 'SELECT SQL_NO_CACHE ';

          If chkListaDesmembramento.Checked Then
            strSQL2 := strSQL2 + '  CONCAT(IF(D.CTP_CODEMP IS NULL,P.CTP_CODEMP,D.CTP_CODEMP), '
          Else
            strSQL2 := strSQL2 + '  CONCAT(P.CTP_CODEMP, ';

          strSQL2 := strSQL2 + '" - ", E.EMP_NOMEMP) AS CODEMP, ';

          If rdgValorASerExibido.ItemIndex = 0 Then
          Begin
            If chkListaDesmembramento.Checked Then
              strSQL2 := strSQL2 + '  (IF(D.CTP_FATCAL IS NULL, P.CTP_VALDUP  - IFNULL(P.CTP_DESSUJ,0) + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_VENDOR,0), ' +
                                   '   ROUND(P.CTP_VALDUP*D.CTP_FATCAL,2) - ROUND(IFNULL(P.CTP_DESSUJ,0)*D.CTP_FATCAL,2) + ROUND(IFNULL(P.CTP_JURSUJ,0)*D.CTP_FATCAL,2) + ' +
                                   '   ROUND(IFNULL(P.CTP_VENDOR,0)*D.CTP_FATCAL,2))) AS VALOR '
            Else
              strSQL2 := strSQL2 + '  (P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ,0) + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_VENDOR,0)) AS VALOR ';
          End
          Else
          Begin
            If chkListaDesmembramento.Checked Then
              strSQL2 := strSQL2 + '  (IF(D.CTP_FATCAL IS NULL, P.CTP_VALDUP + IFNULL(P.CTP_VENDOR,0), ' +
                                   '   ROUND(P.CTP_VALDUP*D.CTP_FATCAL,2) + ROUND(IFNULL(P.CTP_VENDOR,0)*D.CTP_FATCAL,2))) AS VALOR '
            Else
              strSQL2 := strSQL2 + '  (P.CTP_VALDUP + IFNULL(P.CTP_VENDOR,0)) AS VALOR ';
          End;

          strSQL2 := strSQL2 + ', CTP_DTAVEN, CTP_TIPDOC ';
          strSQL2 := strSQL2 + 'FROM ';
          strSQL2 := strSQL2 + '  CADPAG P ';

          If chkListaDesmembramento.Checked Then
          Begin
            strSQL2 := strSQL2 + '  LEFT JOIN CTPDET D ON P.CTP_CODFOR = D.CTP_CODFOR AND P.CTP_NUMDUP = D.CTP_NUMDUP AND ';
            strSQL2 := strSQL2 + '                         P.CTP_PARCEL = D.CTP_PARCEL AND P.CTP_CODEMP = D.CTP_EMPORI AND ';
            strSQL2 := strSQL2 + '                       ((P.CTP_SERIE_ = D.CTP_SERIE_) OR ';
            strSQL2 := strSQL2 + '                       (((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = "")) AND ((D.CTP_SERIE_ IS NULL) OR (D.CTP_SERIE_ = "")))) ';
            strSQL2 := strSQL2 + '  JOIN CADEMP E ON E.EMP_CODEMP = IF(D.CTP_CODEMP IS NULL,P.CTP_CODEMP,D.CTP_CODEMP) ';
          End
          Else
            strSQL2 := strSQL2 + '  JOIN CADEMP E ON E.EMP_CODEMP = P.CTP_CODEMP ';

          strSQL2 := strSQL2 + '  JOIN CADFOR F ON P.CTP_CODFOR = F.FOR_CODFOR ';
          strSQL2 := strSQL2 + '  LEFT JOIN CADATI ON ATI_CODATI = F.FOR_CODATI  ';
          strSQL2 := strSQL2 + 'WHERE ';
          strSQL2 := strSQL2 + '  P.CTP_DTAPAG IS NULL AND ';
          strSQL2 := strSQL2 + '  P.CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

          if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
            strSQL2 := strSQL2 + '  AND P.CTP_COMPET = :COMPET ';

        End;

        {***********************************}
        { SELECT RESUMO BOLETO\CHEQUE       }
        {********************************JB*}
        strSQL4 := '';
        strSQL4 := strSQL4 + 'SELECT ';

        If rdgValorASerExibido.ItemIndex = 0 Then
        Begin
          If chkListaDesmembramento.Checked Then
            strSQL4 := strSQL4 + '  SUM(IF(D.CTP_FATCAL IS NULL, P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ,0) + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_VENDOR,0), '+
                                 '      ROUND(P.CTP_VALDUP*D.CTP_FATCAL,2) - ROUND(IFNULL(P.CTP_DESSUJ,0)*D.CTP_FATCAL,2) + ROUND(IFNULL(P.CTP_JURSUJ,0)*D.CTP_FATCAL,2) + ' +
                                 '      ROUND(IFNULL(P.CTP_VENDOR,0)*D.CTP_FATCAL,2))) AS VALOR '
          Else
            strSQL4 := strSQL4 + '  SUM(P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ,0) + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_VENDOR,0)) AS VALOR ';
        End
        Else
        Begin
          If chkListaDesmembramento.Checked Then
            strSQL4 := strSQL4 + '  SUM(IF(D.CTP_FATCAL IS NULL, P.CTP_VALDUP + IFNULL(P.CTP_VENDOR,0), ' +
                                 '      ROUND(P.CTP_VALDUP*D.CTP_FATCAL,2) + ROUND(IFNULL(P.CTP_VENDOR,0)*D.CTP_FATCAL,2))) AS VALOR '
          Else
            strSQL4 := strSQL4 + '  SUM(P.CTP_VALDUP + IFNULL(P.CTP_VENDOR,0)) AS VALOR ';
        End;
        strSQL4 := strSQL4 + ', CTP_DTAVEN, CTP_TIPDOC ';
        strSQL4 := strSQL4 + 'FROM ';
        strSQL4 := strSQL4 + '  CADPAG P  ';
        strSQL4 := strSQL4 + '  JOIN CADFOR F ON P.CTP_CODFOR = F.FOR_CODFOR ';
        strSQL4 := strSQL4 + '  LEFT JOIN CADATI ON ATI_CODATI = F.FOR_CODATI  ';

        If chkListaDesmembramento.Checked Then
        Begin
          strSQL4 := strSQL4 + '  LEFT JOIN CTPDET D ON P.CTP_CODFOR = D.CTP_CODFOR AND P.CTP_NUMDUP = D.CTP_NUMDUP AND ';
          strSQL4 := strSQL4 + '                         P.CTP_PARCEL = D.CTP_PARCEL AND P.CTP_CODEMP = D.CTP_EMPORI AND ';
          strSQL4 := strSQL4 + '                       ((P.CTP_SERIE_ = D.CTP_SERIE_) OR ';
          strSQL4 := strSQL4 + '                        (((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = "")) AND ((D.CTP_SERIE_ IS NULL) OR (D.CTP_SERIE_ = "")))) ';
        End;

        strSQL4 := strSQL4 + 'WHERE ';
        strSQL4 := strSQL4 + '  P.CTP_DTAPAG IS NULL AND ';
        strSQL4 := strSQL4 + '  P.CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

        if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
          strSQL4 := strSQL4 + '  AND P.CTP_COMPET = :COMPET ';

      End;

      {***************************************}
      {*  SEM PREVISOES NO RELATORIO         *}
      {************************************LA*}
      If (rdgIncPrevis.ItemIndex = 1) Then
      Begin
        strSQL  := strSQL + '  AND IFNULL(P.CTP_PREVIS, "N") <> "S" ';
        strSQL4 := strSQL4 + '  AND IFNULL(P.CTP_PREVIS, "N") <> "S" ';
        If chkResumoEmpresa.Checked Then
          strSQL2 := strSQL2 + '  AND IFNULL(P.CTP_PREVIS, "N") <> "S" ';
      End
      {***************************************}
      {*  APENAS PREVISOES NO RELATORIO      *}
      {************************************LA*}
      Else If (rdgIncPrevis.ItemIndex = 0) Then
      Begin
        strSQL  := strSQL + '  AND IFNULL(P.CTP_PREVIS, "N") = "S"  ';
        strSQL4 := strSQL4 + '  AND IFNULL(P.CTP_PREVIS, "N") = "S"  ';
        If chkResumoEmpresa.Checked Then
          strSQL2 := strSQL2 + '  AND IFNULL(P.CTP_PREVIS, "N") = "S"  ';
      End;

      If (chkExiCreditos.Checked) Then
      Begin
        strSQL := strSQL + '  AND (P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ, 0) + IFNULL(P.CTP_JURSUJ, 0) + IFNULL(P.CTP_VENDOR, 0)) < 0.0  ';
        strSQL4 := strSQL4 + '  AND (P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ, 0) + IFNULL(P.CTP_JURSUJ, 0) + IFNULL(P.CTP_VENDOR, 0)) < 0.0  ';
        If chkResumoEmpresa.Checked Then
          strSQL2 := strSQL2 + ' AND (P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ, 0) + IFNULL(P.CTP_JURSUJ, 0) + IFNULL(P.CTP_VENDOR, 0)) < 0.0  ';
      End;

      If (chkNExiCreditos.Checked) Then
      Begin
        strSQL := strSQL + '  AND (P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ, 0) + IFNULL(P.CTP_JURSUJ, 0) + IFNULL(P.CTP_VENDOR, 0)) > 0.0  ';
        strSQL4 := strSQL4 + '  AND (P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ, 0) + IFNULL(P.CTP_JURSUJ, 0) + IFNULL(P.CTP_VENDOR, 0)) > 0.0  ';
        If chkResumoEmpresa.Checked Then
          strSQL2 := strSQL2 + ' AND (P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ, 0) + IFNULL(P.CTP_JURSUJ, 0) + IFNULL(P.CTP_VENDOR, 0)) > 0.0  ';
      End;


      If rdgCheque.ItemIndex > 0 Then
      Begin
        strSQL  := strSQL  + ' AND IF(' + STR_USACHQ + ' = "" OR ' + STR_USACHQ + ' IS NULL, "N", ' + STR_USACHQ + ') = ' + QuotedStr(IfThen(rdgCheque.ItemIndex = 1,'S','N'));
        strSQL2 := strSQL2 + ' AND IF(' + STR_USACHQ + ' = "" OR ' + STR_USACHQ + ' IS NULL, "N", ' + STR_USACHQ + ') = ' + QuotedStr(IfThen(rdgCheque.ItemIndex = 1,'S','N'));
      End;

      If Not fEmptyStr(edtDesFornecedor.Text) Then
      Begin
        strSQL  := strSQL + fStrLocate(edtCodFornecedor,  arrFornecedor,  'P.CTP_CODFOR', 'CODFOR');
        strSQL4 := strSQL4 + fStrLocate(edtCodFornecedor,  arrFornecedor,  'P.CTP_CODFOR', 'CODFOR');
        If chkResumoEmpresa.Checked Then
          strSQL2 := strSQL2 + fStrLocate(edtCodFornecedor,  arrFornecedor,  'P.CTP_CODFOR', 'CODFOR');
      End;

      If Not fEmptyStr(edtDesAtv.Text) Then
      Begin
        strSQL  := strSQL + fStrLocate(edtCodAtv,  arrAtividade,  'ATI_CODATI', 'CODATI');
        strSQL4 := strSQL4 + fStrLocate(edtCodAtv,  arrAtividade,  'ATI_CODATI', 'CODATI');
        If chkResumoEmpresa.Checked Then
          strSQL2 := strSQL2 + fStrLocate(edtCodAtv,  arrAtividade,  'ATI_CODATI', 'CODATI');
      End;

      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        If chkListaDesmembramento.Checked Then
        Begin
          strSQL  := strSQL + fStrLocate(edtCodEmpresa,  arrEmpresa,  'IF(D.CTP_CODEMP IS NULL, P.CTP_CODEMP, D.CTP_CODEMP)', 'CODEMP');
          strSQL4 := strSQL4 + fStrLocate(edtCodEmpresa,  arrEmpresa,  'IF(D.CTP_CODEMP IS NULL, P.CTP_CODEMP, D.CTP_CODEMP)', 'CODEMP');
          If chkResumoEmpresa.Checked Then
            strSQL2 := strSQL2 + fStrLocate(edtCodEmpresa,  arrEmpresa,  'IF(D.CTP_CODEMP IS NULL, P.CTP_CODEMP, D.CTP_CODEMP)', 'CODEMP');
        End
        Else
        Begin
          strSQL  := strSQL + fStrLocate(edtCodEmpresa,  arrEmpresa,  'P.CTP_CODEMP', 'CODEMP');
          strSQL4 := strSQL4 + fStrLocate(edtCodEmpresa,  arrEmpresa,  'P.CTP_CODEMP', 'CODEMP');
          If chkResumoEmpresa.Checked Then
            strSQL2 := strSQL2 + fStrLocate(edtCodEmpresa,  arrEmpresa,  'P.CTP_CODEMP', 'CODEMP');
        End;
      End
      else
      begin
        If chkListaDesmembramento.Checked Then
        Begin
          strSQL := strSQL +  ' AND LOCATE(IF(D.CTP_CODEMP IS NULL, P.CTP_CODEMP, D.CTP_CODEMP), :CODEMP) > 0 ';
          strSQL4 := strSQL4 +  ' AND LOCATE(IF(D.CTP_CODEMP IS NULL, P.CTP_CODEMP, D.CTP_CODEMP), :CODEMP) > 0 ';

          If chkResumoEmpresa.Checked Then
            strSQL2 := strSQL2 +  ' AND LOCATE(IF(D.CTP_CODEMP IS NULL, P.CTP_CODEMP, D.CTP_CODEMP), :CODEMP) > 0 ';
        End
        Else
        Begin
          strSQL := strSQL +  ' AND LOCATE(P.CTP_CODEMP, :CODEMP) > 0 ';
          strSQL4 := strSQL4 +  ' AND LOCATE(P.CTP_CODEMP, :CODEMP) > 0 ';

          If chkResumoEmpresa.Checked Then
            strSQL2 := strSQL2 +  ' AND LOCATE(P.CTP_CODEMP, :CODEMP) > 0 ';
        End;
      end;

      If Not fEmptyStr(edtDesEve.Text) Then
      Begin
        strSQL  := strSQL + fStrLocate(edtCodEve,  arrEvento,  'P.CTP_CODEVE', 'CODEVE');
        strSQL4 := strSQL4 + fStrLocate(edtCodEve,  arrEvento,  'P.CTP_CODEVE', 'CODEVE');
        If chkResumoEmpresa.Checked Then
          strSQL2 := strSQL2 + fStrLocate(edtCodEve,  arrEvento,  'P.CTP_CODEVE', 'CODEVE');
      End;

      If (Not fEmptyStr(fTiraCaracEspeciais(mskCodCta.Text))) Then
      Begin
        If (cbxOpcao.ItemIndex = IDX_AN_VEN) Or (cbxOpcao.ItemIndex = IDX_AN_FOR) Or (cbxOpcao.ItemIndex = IDX_AN_EVE) Or (cbxOpcao.ItemIndex = IDX_AN_ATI) Or (cbxOpcao.ItemIndex = IDX_AN_POR) Then
        Begin
          If chkListaDesmembramento.Checked Then
          Begin
            strSQL := strSQL + fStrLocate(mskCodCta,  arrCentroCusto,  'IF(D.CTP_CODCTA IS NULL, P.CTP_CODCTA, D.CTP_CODCTA)', 'CODCTA');
            strSQL4 := strSQL4 + fStrLocate(mskCodCta,  arrCentroCusto,  'IF(D.CTP_CODCTA IS NULL, P.CTP_CODCTA, D.CTP_CODCTA)', 'CODCTA');
            If chkResumoEmpresa.Checked Then
              strSQL2 := strSQL2 + fStrLocate(mskCodCta,  arrCentroCusto,  'P.CTP_CODCTA', 'CODCTA');
          End
          Else
          Begin
            strSQL := strSQL + fStrLocate(mskCodCta,  arrCentroCusto,  'P.CTP_CODCTA', 'CODCTA');
            strSQL4 := strSQL4 + fStrLocate(mskCodCta,  arrCentroCusto,  'P.CTP_CODCTA', 'CODCTA');
            If chkResumoEmpresa.Checked Then
              strSQL2 := strSQL2 + fStrLocate(mskCodCta,  arrCentroCusto,  'P.CTP_CODCTA', 'CODCTA');
          End;
        End
        Else
        Begin
          strSQL := strSQL + fStrLocate(mskCodCta,  arrCentroCusto,  'P.CTP_CODCTA', 'CODCTA');
          strSQL4 := strSQL4 + fStrLocate(mskCodCta,  arrCentroCusto,  'P.CTP_CODCTA', 'CODCTA');
          If chkResumoEmpresa.Checked Then
            strSQL2 := strSQL2 + fStrLocate(mskCodCta,  arrCentroCusto,  'P.CTP_CODCTA', 'CODCTA');
        End;
      End;

      If Not fEmptyStr(edtCodPor.Text) Then
      Begin
        strSQL  := strSQL + fStrLocate(edtCodPor,  arrPortador,  'P.CTP_CODPOR', 'CODPOR');
        strSQL4 := strSQL4 + fStrLocate(edtCodPor,  arrPortador,  'P.CTP_CODPOR', 'CODPOR');
        If chkResumoEmpresa.Checked Then
          strSQL2 := strSQL2 + fStrLocate(edtCodPor,  arrPortador,  'P.CTP_CODPOR', 'CODPOR');
      End
      Else If fCfgSis('DACPOR', varBoolean) Then
      Begin
        strSQL := strSQL + ' AND (IFNULL(CTP_CODPOR, "") = "" ';
        strSQL := strSQL + ' OR LOCATE(CTP_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
        strSQL4 := strSQL4 + ' AND (IFNULL(CTP_CODPOR, "") = "" ';
        strSQL4 := strSQL4 + ' OR LOCATE(CTP_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
        If chkResumoEmpresa.Checked Then
        Begin
          strSQL2 := strSQL2 + ' AND (IFNULL(CTP_CODPOR, "") = "" ';
          strSQL2 := strSQL2 + ' OR LOCATE(CTP_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
        End;
      End;

      If (rdgBoleto.ItemIndex = 1) Then
      Begin
        strSQL := strSQL + '  AND IF(' + STR_VEIOBO + ' = "S", "S", "N") = ' + QuotedStr('S');
        If chkResumoEmpresa.Checked Then
         strSQL2 := strSQL2 + '  AND IF(' + STR_VEIOBO + ' = "S", "S", "N") = ' + QuotedStr('S');
      End

      Else If (rdgBoleto.ItemIndex = 2) Then
      Begin
        strSQL := strSQL + '  AND IF(' + STR_VEIOBO + ' = "S", "S", "N") = ' + QuotedStr('N');
        If chkResumoEmpresa.Checked Then
          strSQL2 := strSQL2 + '  AND IF(' + STR_VEIOBO + ' = "S", "S", "N") = ' + QuotedStr('N');
      End;

      If gpbVeioNF.ItemIndex = 1 Then
      Begin
        strSQL  := strSQL  + '  AND IF(P.CTP_VEIONF = "S", "S", "N") = "S" ';
        strSQL4 := strSQL4 + '  AND IF(P.CTP_VEIONF = "S", "S", "N") = "S" ';
        If chkResumoEmpresa.Checked Then
         strSQL2 := strSQL2 + '  AND IF(P.CTP_VEIONF = "S", "S", "N") = "S" ';
      End
      Else
      If gpbVeioNF.ItemIndex = 2 Then
      Begin
        strSQL  := strSQL  + '  AND IF(P.CTP_VEIONF = "S", "S", "N") = "N" ';
        strSQL4 := strSQL4 + '  AND IF(P.CTP_VEIONF = "S", "S", "N") = "N" ';
        If chkResumoEmpresa.Checked Then
         strSQL2 := strSQL2 + '  AND IF(P.CTP_VEIONF = "S", "S", "N") = "N" ';
      End;

      If (rdgDeposito.ItemIndex = 1) Then
      Begin
        strSQL  := strSQL  + '  AND ' + STR_DEPOSI + ' = ' + QuotedStr('S');
        strSQL2 := strSQL2 + '  AND ' + STR_DEPOSI + ' = ' + QuotedStr('S');
      End

      Else If (rdgDeposito.ItemIndex = 2) Then
      Begin
        strSQL  := strSQL  + '  AND ' + STR_DEPOSI + ' = ' + QuotedStr('N');
        strSQL2 := strSQL2 + '  AND ' + STR_DEPOSI + ' = ' + QuotedStr('N');
      End;

      If rdgForFil.ItemIndex > 0 Then
      Begin
        If rdgForFil.ItemIndex = 1 Then
        Begin
          strSQL := strSQL + '  AND (LOCATE(P.CTP_CODFOR, :FORFIL) > 0) ';
          strSQL4 := strSQL4 + '  AND (LOCATE(P.CTP_CODFOR, :FORFIL) > 0) ';
          If chkResumoEmpresa.Checked Then
            strSQL2 := strSQL2 + '  AND (LOCATE(P.CTP_CODFOR, :FORFIL) > 0) ';
        End
        Else
        Begin
          strSQL := strSQL + '  AND (NOT LOCATE(P.CTP_CODFOR, :FORFIL) > 0) ';
          strSQL4 := strSQL4 + '  AND (NOT LOCATE(P.CTP_CODFOR, :FORFIL) > 0) ';
          If chkResumoEmpresa.Checked Then
            strSQL2 := strSQL2 + '  AND (NOT LOCATE(P.CTP_CODFOR, :FORFIL) > 0) ';
        End;
      End;

      {**************************************************}
      {* ACRESCENTOU CTPDET - O UNION TEM QUE SER AQUI  *}
      {* CASO CONTRARIO, NAO PEGA OS FILTROS DE EMPRESA,*}
      {* FORNECEDOR , ETC .....                         *}
      {* SOMENTE PARA RELATORIO ANALÍTICO (DATA OU FORN)*}
      {**28/02/2011-10:12*****************************DP*}
      If (cbxOpcao.ItemIndex = IDX_AN_VEN) Or
         (cbxOpcao.ItemIndex = IDX_AN_FOR) Or
         (cbxOpcao.ItemIndex = IDX_AN_EVE) Or
         (cbxOpcao.ItemIndex = IDX_AN_ATI) Or
         (cbxOpcao.ItemIndex = IDX_AN_POR) Then
      Begin
        If chkListaDesmembramento.Checked Then
          strSQL := strSQL + ' UNION ALL ' +
                    AnsiReplaceStr(strSQL, 'INNER', 'LEFT') +
                    ' AND D.CTP_CODCTA IS NULL ';
      End;

      Case cbxOpcao.ItemIndex Of
        IDX_SN_FOR: strSQL := strSQL + ' GROUP BY P.CTP_CODFOR, NOMFOR       ';
        IDX_SN_VEN: begin
             if (chkAjuDta.Checked) then
               strSQL := strSQL + ' GROUP BY P.CTP_DTAVEN, IFNULL(P.CTP_TIPDOC, 0) '
             else
               strSQL := strSQL + ' GROUP BY P.CTP_DTAVEN ';
           end;
      End;

      strSQL4 := strSQL4 + STR_FILTRO;

      strSQL := strSQL + ' ORDER BY ';
      strSQL2 := strSQL2 + ' ORDER BY ';

      Case cbxOpcao.ItemIndex Of
        IDX_AN_VEN: Begin

             If (rdgOrdemAnalitico.ItemIndex = 2) Then
               strSQL := strSQL + '  CTP_DTAVEN, CTP_NUMDUP, CTP_CODEMP, CTP_PARCEL'
             Else If (rdgOrdemAnalitico.ItemIndex = 1) Then
               strSQL := strSQL + '  CTP_DTAVEN, CTP_CODFOR, CTP_CODEMP, CTP_NUMDUP, CTP_PARCEL'
             Else
               strSQL := strSQL + '  CTP_DTAVEN, FOR_NOMFOR, CTP_CODEMP, CTP_NUMDUP, CTP_PARCEL';

             If chkResumoEmpresa.Checked Then
               strSQL2 := strSQL2 + '  CODEMP';

           End;
        IDX_AN_POR: Begin
                      If (rdgOrdemAnalitico.ItemIndex = 0) Then
                        strSQL := strSQL + ' COALESCE(POR_NOMPOR, ""), COALESCE(CTP_CODPOR, ""), FOR_NOMFOR '
                      Else If (rdgOrdemAnalitico.ItemIndex = 1) Then
                        strSQL := strSQL + ' COALESCE(POR_NOMPOR, ""), COALESCE(CTP_CODPOR, ""), FOR_CODFOR '
                      Else If (rdgOrdemAnalitico.ItemIndex = 2) Then
                        strSQL := strSQL + ' COALESCE(POR_NOMPOR, ""), COALESCE(CTP_CODPOR, ""), PARCEL ';

                      If chkResumoEmpresa.Checked Then
                      Begin
                        If (rdgOrdemAnalitico.ItemIndex = 0) Then
                          strSQL2 := strSQL2 + ' COALESCE(POR_NOMPOR, ""), COALESCE(CTP_CODPOR, ""), FOR_NOMFOR '
                        Else If (rdgOrdemAnalitico.ItemIndex = 1) Then
                          strSQL2 := strSQL2 + ' COALESCE(POR_NOMPOR, ""), COALESCE(CTP_CODPOR, ""), FOR_CODFOR '
                        Else If (rdgOrdemAnalitico.ItemIndex = 2) Then
                          strSQL2 := strSQL2 + ' COALESCE(POR_NOMPOR, ""), COALESCE(CTP_CODPOR, ""), PARCEL ';
                      End;
                    End;
        IDX_AN_FOR: Begin

             If (rdgOrdemAnalitico.ItemIndex = 1) Then
               strSQL := strSQL + '  FOR_NOMFOR, CTP_NUMDUP, CTP_CODEMP, CTP_PARCEL, CTP_DTAVEN'
             Else
               strSQL := strSQL + '  FOR_NOMFOR, CTP_DTAVEN, CTP_CODEMP, CTP_NUMDUP, CTP_PARCEL';

             If chkResumoEmpresa.Checked Then
             Begin
               strSQL2 := strSQL2 + '  CODEMP';
             End;

           End;
        IDX_SN_FOR: If rdgOrdem.ItemIndex = 0 Then
           Begin
             strSQL := strSQL + ' 2 ';
             If chkResumoEmpresa.Checked Then
               strSQL2 := strSQL2 + ' 1 ';
           End
           Else
           Begin
             strSQL := strSQL + ' 1 ';
             If chkResumoEmpresa.Checked Then
               strSQL2 := strSQL2 + ' 1 ';
           End;

        IDX_SN_VEN: Begin
             strSQL := strSQL + ' CTP_DTAVEN ';
             If chkResumoEmpresa.Checked Then
               strSQL2 := strSQL2 + ' 1 ';
           End;
        IDX_AN_EVE: Begin

             If (rdgOrdemAnalitico.ItemIndex = 2) Then
               strSQL := strSQL + '  CTP_CODEVE, CTP_DTAVEN, CTP_CODEMP, CTP_NUMDUP, CTP_PARCEL'
             Else If (rdgOrdemAnalitico.ItemIndex = 1) Then
             Begin
               strSQL := strSQL + '  CTP_CODEVE, CTP_DTAVEN, CTP_CODEMP, FOR_CODFOR, CTP_NUMDUP, CTP_PARCEL';
             End
             Else
             Begin
               strSQL := strSQL + '  CTP_CODEVE, CTP_DTAVEN, CTP_CODEMP, FOR_NOMFOR, CTP_NUMDUP, CTP_PARCEL';
             end;
             If chkResumoEmpresa.Checked Then
             Begin
               strSQL2 := strSQL2 + '  CODEMP';
             End;

           End;
        IDX_AN_ATI: Begin

             If (rdgOrdemAnalitico.ItemIndex = 2) Then
               strSQL := strSQL + '  ATI_CODATI, CTP_DTAVEN, CTP_CODEMP, CTP_NUMDUP, CTP_PARCEL'
             Else If (rdgOrdemAnalitico.ItemIndex = 1) Then
             Begin
               strSQL := strSQL + '  ATI_CODATI, CTP_DTAVEN, CTP_CODEMP, FOR_CODFOR, CTP_NUMDUP, CTP_PARCEL';
             End
             Else
             Begin
               strSQL := strSQL + '  ATI_CODATI, CTP_DTAVEN, CTP_CODEMP, FOR_NOMFOR, CTP_NUMDUP, CTP_PARCEL';
             end;
             If chkResumoEmpresa.Checked Then
             Begin
               strSQL2 := strSQL2 + '  CODEMP';
             End;

           End;
      End;

      With qryRelatorio Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('DTAINI').AsDate := mskDtaIni.Date;
        ParamByName('DTAFIN').AsDate := mskDtaFin.Date;

        If Not fEmptyStr(edtDesFornecedor.Text) Then
          pSetaParam(edtCodFornecedor.Text, arrFornecedor, strFornecedor, 'CODFOR', qryRelatorio);

        If Not fEmptyStr(edtDesAtv.Text) Then
          pSetaParam(edtCodAtv.Text, arrAtividade, strAtividade, 'CODATI', qryRelatorio);

        If Not fEmptyStr(edtCodEmpresa.Text) Then
          pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryRelatorio)
        Else
          ParamByName('CODEMP').AsString := strEmpAcessoUsuarioLogado;

        If Not fEmptyStr(edtDesEve.Text) Then
          pSetaParam(edtCodEve.Text, arrEvento, strEvento, 'CODEVE', qryRelatorio);

        If Not fEmptyStr(fTiraCaracEspeciais(mskCodCta.Text)) Then
          pSetaParam(mskCodCta.Text, arrCentroCusto, strCentroCusto, 'CODCTA', qryRelatorio);

        If Not fEmptyStr(edtDesPortador.Text) Then
          pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryRelatorio);

        If not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
          ParamByName('COMPET').AsString := mskCompet.Text;

        If rdgForFil.ItemIndex > 0 Then
          ParamByName('FORFIL').AsString := fRetForFilialTodos;

        Open;
      End;

      {********************************************}
      { CALCULA O RESUMO DO CHEQUE\BOLETO\DEPOSITO }
      {**************************************JB/AA*}
      Try
        qryRelRes := fGetZClient(Self);
        qryRelRes.pCriaSoma('VALOR', 'SUM_VALOR');

        With qryRelRes Do
        Begin
          If rdgCheque.ItemIndex = 2 Then
            fltValChq := 0
          Else
          Begin

            {***************************}
            { PEGA RESUMO DO CHEQUE     }
            {************************JB*}
            Close;
            fGetQuery.SQL.Clear;
            fGetQuery.SQL.Add(AnsiReplaceStr(strSQL4, 'FILTRO', STR_USACHQ));

            fGetQuery.ParamByName('DTAINI').AsDate := mskDtaIni.Date;
            fGetQuery.ParamByName('DTAFIN').AsDate := mskDtaFin.Date;

            If Not fEmptyStr(edtDesFornecedor.Text) Then
              pSetaParam(edtCodFornecedor.Text, arrFornecedor, strFornecedor, 'CODFOR', fGetQuery);

            If Not fEmptyStr(edtDesAtv.Text) Then
              pSetaParam(edtCodAtv.Text, arrAtividade, strAtividade, 'CODATI', fGetQuery);

            If Not fEmptyStr(edtCodEmpresa.Text) Then
              pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP',fGetQuery)
            Else
              fGetQuery.ParamByName('CODEMP').AsString := strEmpAcessoUsuarioLogado;

            If Not fEmptyStr(edtDesEve.Text) Then
              pSetaParam(edtCodEve.Text, arrEvento, strEvento, 'CODEVE', fGetQuery);

            If Not fEmptyStr(fTiraCaracEspeciais(mskCodCta.Text)) Then
              pSetaParam(mskCodCta.Text, arrCentroCusto, strCentroCusto, 'CODCTA', fGetQuery);

            If Not fEmptyStr(edtDesPortador.Text) Then
              pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', fGetQuery);

            If not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
              fGetQuery.ParamByName('COMPET').AsString := mskCompet.Text;

            If rdgForFil.ItemIndex > 0 Then
              fGetQuery.ParamByName('FORFIL').AsString := fRetForFilialTodos;

            fAbreClient(True, 'TfrmRelCtpAnaDebitos.btnImprimirClick');
            pAjustaData(fGetDataset);
            fGetDataSet.Filter   := 'CTP_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', (mskDtaIni.Date))) + ' AND ' +
                                    'CTP_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', mskDtaFin.Date));
            fGetDataSet.Filtered := True;
            fltValChq := fRetSoma('SUM_VALOR');

          End;

          If rdgBoleto.ItemIndex = 2 Then
            fltValBol := 0
          Else
          Begin

            {***************************}
            { PEGA RESUMO DO BOLETO     }
            {************************JB*}
            Close;
            fGetQuery.SQL.Clear;
            fGetQuery.SQL.Add(AnsiReplaceStr(strSQL4, 'FILTRO', STR_VEIOBO));
            fGetQuery.ParamByName('DTAINI').AsDate := mskDtaIni.Date;
            fGetQuery.ParamByName('DTAFIN').AsDate := mskDtaFin.Date;

            If Not fEmptyStr(edtDesFornecedor.Text) Then
              pSetaParam(edtCodFornecedor.Text, arrFornecedor, strFornecedor, 'CODFOR', fGetQuery);

            If Not fEmptyStr(edtDesAtv.Text) Then
              pSetaParam(edtCodAtv.Text, arrAtividade, strAtividade, 'CODATI', fGetQuery);

            If Not fEmptyStr(edtCodEmpresa.Text) Then
              pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', fGetQuery)
            Else
              fGetQuery.ParamByName('CODEMP').AsString := strEmpAcessoUsuarioLogado;

            If Not fEmptyStr(edtDesEve.Text) Then
              pSetaParam(edtCodEve.Text, arrEvento, strEvento, 'CODEVE', fGetQuery);

            If Not fEmptyStr(fTiraCaracEspeciais(mskCodCta.Text)) Then
              pSetaParam(mskCodCta.Text, arrCentroCusto, strCentroCusto, 'CODCTA', fGetQuery);

            If Not fEmptyStr(edtDesPortador.Text) Then
              pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', fGetQuery);

            If not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
              fGetQuery.ParamByName('COMPET').AsString := mskCompet.Text;

            If rdgForFil.ItemIndex > 0 Then
              fGetQuery.ParamByName('FORFIL').AsString := fRetForFilialTodos;

            fAbreClient(True, 'TfrmRelCtpAnaDebitos.btnImprimirClick');
            pAjustaData(fGetDataset);

            fGetDataset.Filter   := 'CTP_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', (mskDtaIni.Date))) + ' AND ' +
                                    'CTP_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', mskDtaFin.Date));
            fGetDataset.Filtered := True;
            fltValBol := fRetSoma('SUM_VALOR');

          End;

          If rdgDeposito.ItemIndex = 2 Then
            fltValDep := 0
          Else
          Begin

            {***************************}
            { PEGA RESUMO DO DEPOSITO   }
            {************************AA*}
            Close;
            fGetQuery.SQL.Clear;
            fGetQuery.SQL.Add(AnsiReplaceStr(strSQL4, 'FILTRO', STR_DEPOSI));
            fGetQuery.ParamByName('DTAINI').AsDate := mskDtaIni.Date;
            fGetQuery.ParamByName('DTAFIN').AsDate := mskDtaFin.Date;

            If Not fEmptyStr(edtDesFornecedor.Text) Then
              pSetaParam(edtCodFornecedor.Text, arrFornecedor, strFornecedor, 'CODFOR', fGetQuery);

            If Not fEmptyStr(edtDesAtv.Text) Then
              pSetaParam(edtCodAtv.Text, arrAtividade, strAtividade, 'CODATI', fGetQuery);

            If Not fEmptyStr(edtCodEmpresa.Text) Then
              pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', fGetQuery)
            Else
              fGetQuery.ParamByName('CODEMP').AsString := strEmpAcessoUsuarioLogado;

            If Not fEmptyStr(edtDesEve.Text) Then
              pSetaParam(edtCodEve.Text, arrEvento, strEvento, 'CODEVE', fGetQuery);

            If Not fEmptyStr(fTiraCaracEspeciais(mskCodCta.Text)) Then
              pSetaParam(mskCodCta.Text, arrCentroCusto, strCentroCusto, 'CODCTA', fGetQuery);

            If Not fEmptyStr(edtDesPortador.Text) Then
              pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', fGetQuery);

            If not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
              fGetQuery.ParamByName('COMPET').AsString := mskCompet.Text;

            If rdgForFil.ItemIndex > 0 Then
              fGetQuery.ParamByName('FORFIL').AsString := fRetForFilialTodos;

            fAbreClient(True, 'TfrmRelCtpAnaDebitos.btnImprimirClick');
            pAjustaData(fGetDataset);
            fGetDataset.Filter   := 'CTP_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', (mskDtaIni.Date))) + ' AND ' +
                                    'CTP_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', mskDtaFin.Date));
            fGetDataset.Filtered := True;
            fltValDep := fRetSoma('SUM_VALOR');

          End;

          {***************************}
          { PEGA RESUMO DO OUTROS     }
          {************************JB*}
          Close;
          fGetQuery.SQL.Clear;
          fGetQuery.SQL.Add(AnsiReplaceStr(strSQL4, STR_FILTRO, ' AND IFNULL(' + STR_USACHQ + ',"N") <> "S" ' +
                                                      ' AND IFNULL(' + STR_VEIOBO + ',"N") <> "S" ' +
                                                      ' AND IFNULL(' + STR_DEPOSI + ',"N") <> "S" ' +
                                                      ' GROUP BY CTP_DTAVEN, CTP_TIPDOC '));
          fGetQuery.ParamByName('DTAINI').AsDate := mskDtaIni.Date;
          fGetQuery.ParamByName('DTAFIN').AsDate := mskDtaFin.Date;

          If Not fEmptyStr(edtDesFornecedor.Text) Then
            pSetaParam(edtCodFornecedor.Text, arrFornecedor, strFornecedor, 'CODFOR', fGetQuery);

          If Not fEmptyStr(edtDesAtv.Text) Then
            pSetaParam(edtCodAtv.Text, arrAtividade, strAtividade, 'CODATI', fGetQuery);

          If Not fEmptyStr(edtCodEmpresa.Text) Then
            pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', fGetQuery)
          Else
            fGetQuery.ParamByName('CODEMP').AsString := strEmpAcessoUsuarioLogado;

          If Not fEmptyStr(edtDesEve.Text) Then
            pSetaParam(edtCodEve.Text, arrEvento, strEvento, 'CODEVE', fGetQuery);

          If Not fEmptyStr(fTiraCaracEspeciais(mskCodCta.Text)) Then
            pSetaParam(mskCodCta.Text, arrCentroCusto, strCentroCusto, 'CODCTA', fGetQuery);

          If Not fEmptyStr(edtDesPortador.Text) Then
            pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', fGetQuery);

          If not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
            fGetQuery.ParamByName('COMPET').AsString := mskCompet.Text;

          If rdgForFil.ItemIndex > 0 Then
            fGetQuery.ParamByName('FORFIL').AsString := fRetForFilialTodos;

          fAbreClient(True, 'TfrmRelCtpAnaDebitos.btnImprimirClick');
          pAjustaData(fGetDataset);
          fGetDataset.Filter   := 'CTP_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', (mskDtaIni.Date))) + ' AND ' +
                                  'CTP_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', mskDtaFin.Date));
          fGetDataset.Filtered := True;
          fltValOut := fRetSoma('SUM_VALOR');
          {*********************************************************}
          { EXIBE FORMA DE PAGAMENTO EM FUNÇÃO DA SELEÇÃO NA TELA   }
          {******************************************************MA*}

          If rdgBoleto.ItemIndex = 1 Then
          Begin
             fltValDep := 0;
             fltValChq := 0;
             fltValOut := 0;
          End
          Else If rdgDeposito.ItemIndex = 1 Then
          Begin
             fltValBol := 0;
             fltValChq := 0;
             fltValOut := 0;
          End
          Else If rdgCheque.ItemIndex = 1 Then
          Begin
             fltValBol := 0;
             fltValDep := 0;
             fltValOut := 0;
          End;

        End;

      Finally
        //FreeAndNil(qryRelRes);
      End;

      // agrupado por empresa
      If chkResumoEmpresa.Checked Then
      Begin
        With qryRelEmp Do
        Begin
          Close;
          fGetQuery.SQL.Clear;
          fGetQuery.SQL.Add(strSQL2);
          fGetQuery.ParamByName('DTAINI').AsDate := mskDtaIni.Date;
          fGetQuery.ParamByName('DTAFIN').AsDate := mskDtaFin.Date;

          If Not fEmptyStr(edtDesFornecedor.Text) Then
            pSetaParam(edtCodFornecedor.Text, arrFornecedor, strFornecedor, 'CODFOR', fGetQuery);

          If Not fEmptyStr(edtDesAtv.Text) Then
            pSetaParam(edtCodAtv.Text, arrAtividade, strAtividade, 'CODATI', fGetQuery);

          If Not fEmptyStr(edtCodEmpresa.Text) Then
            pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', fGetQuery)
          Else
            fGetQuery.ParamByName('CODEMP').AsString := strEmpAcessoUsuarioLogado;

          If Not fEmptyStr(edtDesEve.Text) Then
            pSetaParam(edtCodEve.Text, arrEvento, strEvento, 'CODEVE', fGetQuery);

          If Not fEmptyStr(fTiraCaracEspeciais(mskCodCta.Text)) Then
            pSetaParam(mskCodCta.Text, arrCentroCusto, strCentroCusto, 'CODCTA', fGetQuery);

          If Not fEmptyStr(edtDesPortador.Text) Then
            pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', fGetQuery);

          If not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
            fGetQuery.ParamByName('COMPET').AsString := mskCompet.Text;

          If rdgForFil.ItemIndex > 0 Then
            fGetQuery.ParamByName('FORFIL').AsString := fRetForFilialTodos;

          fAbreClient(True, 'TfrmRelCtpAnaDebitos.btnImprimirClick');
          pAjustaData(fGetDataset);

          cdsAuxilia := TUniClientDataSet.Create(Self);
          cdsAuxilia.Data := TUniClientDataSet(fGetDataset).Data;

          cdsAuxilia.Filter   := 'CTP_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', (mskDtaIni.Date))) + ' AND ' +
                                 'CTP_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', mskDtaFin.Date));
          cdsAuxilia.Filtered := True;

          TUniClientDataSet(fGetDataset).EmptyDataSet;
          cdsAuxilia.First;

          While not cdsAuxilia.Eof Do
          Begin
            If not fGetDataset.Locate('CODEMP', cdsAuxilia.FieldByName('CODEMP').AsString, []) Then
            Begin
              fGetDataset.Insert;
              fGetDataset.FieldByName('VALOR').AsFloat := 0;
            End
            Else
              fGetDataset.Edit;

            fGetDataset.FieldByName('CODEMP').AsString := cdsAuxilia.FieldByName('CODEMP').AsString;
            fGetDataset.FieldByName('VALOR').AsFloat := fGetDataset.FieldByName('VALOR').AsFloat + cdsAuxilia.FieldByName('VALOR').AsFloat;

            fGetDataset.Post;
            cdsAuxilia.Next;
          End;
          FreeAndNil(cdsAuxilia);


        End;

      End;

      pSetaClient(qryRelEmp.fGetDataset);

      cdsRelatorio := TUniClientDataSet.Create(Self);

      For intCont := 0 To qryRelatorio.FieldCount - 1 Do
      Begin

        With cdsRelatorio, FieldDefs Do
        Begin
          With AddFieldDef Do Begin
            Name := qryRelatorio.Fields[intCont].FieldName;
            DataType := qryRelatorio.Fields[intCont].DataType;

            If qryRelatorio.Fields[intCont].DataType = ftString Then
              Size := qryRelatorio.Fields[intCont].Size;

            Required := False;
          End;

        End;

      End;

      cdsRelatorio.CreateDataSet;
      cdsRelatorio.Open;

      With qryRelatorio Do
      Begin
        First;

        While Not Eof Do
        Begin
          cdsRelatorio.Append;
          For intCont := 0 To qryRelatorio.FieldCount - 1 Do
          Begin
            cdsRelatorio.Fields[intCont].Value := Fields[intCont].Value;
          End;

          cdsRelatorio.Post;

          Next;
        End;
      End;

      If ((chkAjuDta.Checked) And (cbxOpcao.ItemIndex = IDX_SN_VEN)) Then
      Begin
        cdsAuxilia := TUniClientDataSet.Create(Self);
        cdsAuxilia.Data := cdsRelatorio.Data;

        pAjustaData(cdsAuxilia);
        cdsRelatorio.EmptyDataSet();
        cdsAuxilia.First;

        While (Not cdsAuxilia.Eof) Do
        Begin
          cdsRelatorio.Filtered := False;
          cdsRelatorio.Filter   := 'CTP_DTAVEN = ' + QuotedStr(FormatDateTime('dd/mm/yyyy', cdsAuxilia.FieldByName('CTP_DTAVEN').AsDateTime));
          cdsRelatorio.Filtered := True;

          If (cdsRelatorio.IsEmpty) Then
          Begin
            cdsRelatorio.Append;

            For intCont := 0 To cdsAuxilia.FieldCount - 1 Do
            Begin
              cdsRelatorio.Fields[intCont].Value := cdsAuxilia.Fields[intCont].Value;
            End;
          End
          Else
          Begin
            cdsRelatorio.Edit;
            cdsRelatorio.FieldByName('CTP_VALDUP').AsFloat := cdsRelatorio.FieldByName('CTP_VALDUP').AsFloat + cdsAuxilia.FieldByName('CTP_VALDUP').AsFloat;
          End;

          cdsRelatorio.Post;

          cdsRelatorio.Filtered := False;
          cdsRelatorio.Filter := '';

          cdsAuxilia.Next;
        End;

        FreeAndNil(cdsAuxilia);
      End;

      dtsRelatorio.DataSet := cdsRelatorio;

      cdsRelatorio.Open;

      cdsRelatorio.Filtered := False;
      cdsRelatorio.Filter   := '';

      If (chkAjuDta.Checked)       And
         (cbxOpcao.ItemIndex <> IDX_SN_FOR) Then
      Begin
        pAjustaData(cdsRelatorio);

        cdsRelatorio.Filter   := 'CTP_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', (mskDtaIni.Date))) + ' AND ' +
                                 'CTP_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', mskDtaFin.Date));

        cdsRelatorio.Filtered := True;

        Case cbxOpcao.ItemIndex Of
          IDX_AN_VEN: Begin

               If (rdgOrdemAnalitico.ItemIndex = 2) Then
                 cdsRelatorio.IndexFieldNames := 'CTP_DTAVEN;CTP_NUMDUP;CTP_PARCEL'
               Else
                 cdsRelatorio.IndexFieldNames := 'CTP_DTAVEN;FOR_NOMFOR;CTP_CODEMP;CTP_NUMDUP;CTP_PARCEL';

             End;
          IDX_SN_FOR: If rdgOrdem.ItemIndex = 0 Then
               cdsRelatorio.IndexFieldNames := 'FOR_NOMFOR'
             Else
               cdsRelatorio.IndexFieldNames := 'FOR_CODFOR';
          IDX_AN_POR: Begin
                        If (rdgOrdemAnalitico.ItemIndex = 0) Then
                          cdsRelatorio.IndexFieldNames := 'POR_NOMPOR;CTP_CODPOR;FOR_NOMFOR'
                        Else If (rdgOrdemAnalitico.ItemIndex = 1) Then
                          cdsRelatorio.IndexFieldNames := 'POR_NOMPOR;CTP_CODPOR;CTP_CODFOR'
                        Else If (rdgOrdemAnalitico.ItemIndex = 2) Then
                          cdsRelatorio.IndexFieldNames := 'POR_NOMPOR;CTP_CODPOR;CTP_NUMDUP';
                      End;

          IDX_SN_VEN: cdsRelatorio.IndexFieldNames := 'CTP_DTAVEN';
          IDX_AN_FOR: Begin

               If (rdgOrdemAnalitico.ItemIndex = 2) Then
                 cdsRelatorio.IndexFieldNames := 'FOR_NOMFOR;CTP_DTAVEN;CTP_NUMDUP;CTP_PARCEL'
               Else
                 cdsRelatorio.IndexFieldNames := 'FOR_NOMFOR;CTP_DTAVEN;FOR_NOMFOR;CTP_NUMDUP;CTP_PARCEL';

             End;
          IDX_AN_EVE: Begin

               If (rdgOrdemAnalitico.ItemIndex = 2) Then
                 cdsRelatorio.IndexFieldNames := 'CTP_CODEVE;CTP_DTAVEN;CTP_NUMDUP;CTP_PARCEL'
               Else
                 cdsRelatorio.IndexFieldNames := 'CTP_CODEVE;CTP_DTAVEN;FOR_NOMFOR;CTP_NUMDUP;CTP_PARCEL';

             End;
          IDX_AN_ATI: Begin

               If (rdgOrdemAnalitico.ItemIndex = 2) Then
                 cdsRelatorio.IndexFieldNames := 'ATI_CODATI;CTP_DTAVEN;CTP_NUMDUP;CTP_PARCEL'
               Else
                 cdsRelatorio.IndexFieldNames := 'ATI_CODATI;CTP_DTAVEN;FOR_NOMFOR;CTP_NUMDUP;CTP_PARCEL';

             End;
        End;

      End;

      cdsRelatorio.Filtered := False;
      cdsRelatorio.Filter   := '';
      If (chkAjuDta.Checked)       And
        (cbxOpcao.ItemIndex <> IDX_SN_FOR) Then
        cdsRelatorio.Filter   := QuotedStr(FormatDateTime('dd/MM/yyyy', (mskDtaIni.Date))) + ' <= CTP_DTAVEN AND ' + QuotedStr(FormatDateTime('dd/MM/yyyy', mskDtaFin.Date)) + ' >= CTP_DTAVEN'
      Else
        cdsRelatorio.Filter   := QuotedStr(FormatDateTime('dd/MM/yyyy', mskDtaIni.Date)) + ' <= CTP_DTAVEN AND ' + QuotedStr(FormatDateTime('dd/MM/yyyy', mskDtaFin.Date)) + ' >= CTP_DTAVEN';

      cdsRelatorio.Filtered := True;

      If Not cdsRelatorio.IsEmpty Then
      Begin
        Try
          pCriarFormularios(TfrmQckCtpAnalDebitos,frmQckCtpAnalDebitos);

          frmQckCtpAnalDebitos.dtsRelatorio.DataSet := cdsRelatorio;
          If rdgImpHistCmp.ItemIndex = 0 Then
            frmQckCtpAnalDebitos.pHistoricoCompleto;

          frmQckCtpAnalDebitos.strTipImp := strTipImp;

          If fCfgSis('MODREL_TAP') = '1' Then
          Begin
            If (rdgValorASerExibido.ItemIndex = 0) then
            Begin
              If strTipImp = 'M' then
                frmQckCtpAnalDebitos.RLLabel8.Caption := 'VAL. LIQUIDO'
              Else
                frmQckCtpAnalDebitos.RLLabel8.Caption := 'VAL. LÍQUIDO';
            End
            Else
            Begin
              frmQckCtpAnalDebitos.RLLabel8.Caption := 'VAL. BRUTO';
            End;
          End
          Else
          Begin
            If (rdgValorASerExibido.ItemIndex = 0) then
            Begin
              If strTipImp = 'M' then
                frmQckCtpAnalDebitos.RLLabel27.Caption := 'VAL. LIQUIDO'
              Else
                frmQckCtpAnalDebitos.RLLabel27.Caption := 'VAL. LÍQUIDO';
            End
            Else
            Begin
              frmQckCtpAnalDebitos.RLLabel27.Caption := 'VAL. BRUTO';
            End;
          End;

          frmQckCtpAnalDebitos.cdsRelatorio := cdsRelatorio;
          frmQckCtpAnalDebitos.intValorExibido := rdgValorASerExibido.ItemIndex + 1;

          If chkResumoEmpresa.Checked Then
          Begin
            frmQckCtpAnalDebitos.rllAgrEmp.DataSource := dtsGen;
            frmQckCtpAnalDebitos.rllAgrValor.DataSource := dtsGen;
            frmQckCtpAnalDebitos.rllAgrTotal.DataSource := dtsGen;
            frmQckCtpAnalDebitos.rlbAgrupamento.DataSource := dtsGen;
          End
          Else
          Begin
            frmQckCtpAnalDebitos.rlbAgrupamento.Visible := False;
          End;

          {*******************************}
          { RESUMO BOLETO/CHEQUE/DEPOSITO }
          {*************************JB/AA*}
          frmQckCtpAnalDebitos.rllValBol.Caption := FloatToStrF(fltValBol, ffNumber, 15, 2);
          frmQckCtpAnalDebitos.rllValChq.Caption := FloatToStrF(fltValChq, ffNumber, 15, 2);
          frmQckCtpAnalDebitos.rllValDep.Caption := FloatToStrF(fltValDep, ffNumber, 15, 2);
          frmQckCtpAnalDebitos.rllValOut.Caption := FloatToStrF(fltValOut, ffNumber, 15, 2);

          If strTipImp = 'M' Then
            frmQckCtpAnalDebitos.qckPagina.DefaultFilter := rldFiltro
          Else
            frmQckCtpAnalDebitos.qckPagina.DefaultFilter := Nil;

          If strTipImp = 'M' then
            frmQckCtpAnalDebitos.strOrdem := 'REFERENTE AO PERIODO DE ' + FormatDateTime('dd/MM/yyyy', mskDtaIni.Date)  + ' A ' + FormatDateTime('dd/MM/yyyy', mskDtaFin.Date)
          Else
            frmQckCtpAnalDebitos.strOrdem := 'REFERENTE AO PERÍODO DE ' + FormatDateTime('dd/MM/yyyy', mskDtaIni.Date)  + ' A ' + FormatDateTime('dd/MM/yyyy', mskDtaFin.Date);

          If (rdgIncPrevis.ItemIndex = 1) Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpAnalDebitos.rllIncPrevis.Caption := 'INCLUIDO PREVISAO: NAO'
            Else
              frmQckCtpAnalDebitos.rllIncPrevis.Caption := 'INCLUÍDO PREVISÃO: NÃO';
          End
          Else
          If (rdgIncPrevis.ItemIndex = 0) Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpAnalDebitos.rllIncPrevis.Caption := 'APENAS PREVISAO'
            Else
              frmQckCtpAnalDebitos.rllIncPrevis.Caption := 'APENAS PREVISÃO'
          End
          Else
          If (rdgIncPrevis.ItemIndex = 2) Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpAnalDebitos.rllIncPrevis.Caption := 'INCLUIDO PREVISAO: SIM'
            Else
              frmQckCtpAnalDebitos.rllIncPrevis.Caption := 'INCLUÍDO PREVISÃO: SIM'
          End;

          If edtCodFornecedor.Text = '' Then
            frmQckCtpAnalDebitos.rllFornecedor.Caption := 'FORNECEDOR: TODOS'
          Else
            frmQckCtpAnalDebitos.rllFornecedor.Caption := fStrTitulo(edtCodFornecedor.Text, edtDesFornecedor, arrFornecedor, strFornecedor, 'FORNECEDOR');

          If edtCodAtv.Text = '' Then
            frmQckCtpAnalDebitos.rllAtividade.Caption := 'ATIVIDADE: TODAS'
          Else
            frmQckCtpAnalDebitos.rllAtividade.Caption := fStrTitulo(edtCodAtv.Text, edtDesAtv, arrAtividade, strAtividade, 'ATIVIDADE');

          If edtCodEmpresa.Text = '' Then
            frmQckCtpAnalDebitos.rllEmpresa.Caption := 'EMPRESA: TODAS'
          Else
            frmQckCtpAnalDebitos.rllEmpresa.Caption := fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmpresa, strEmpresa, 'EMPRESA');

          If edtCodEve.Text = '' Then
            frmQckCtpAnalDebitos.rllEventos.Caption := 'CENTRO DE CUSTOS: TODOS'
          Else
            frmQckCtpAnalDebitos.rllEventos.Caption := fStrTitulo(edtCodEve.Text, edtDesEve, arrEvento, strEvento, 'CENTRO DE CUSTOS');

          If (fEmptyStr(mskCodCta.Text)) Then
            frmQckCtpAnalDebitos.rllCodCta.Caption := 'PLANO DE CONTAS: TODOS'
          Else
            frmQckCtpAnalDebitos.rllCodCta.Caption := fStrTitulo(mskCodCta.Text, edtDesCta, arrCentroCusto, strCentroCusto, 'PLANO DE CONTAS');

          If edtCodPor.Text = '' Then
            frmQckCtpAnalDebitos.rllPortador.Caption := 'PORTADOR: TODOS'
          Else
            frmQckCtpAnalDebitos.rllPortador.Caption := fStrTitulo(edtCodPor.Text, edtDesPortador, arrPortador, strPortador, 'PORTADOR');

          If rdgBoleto.ItemIndex = 1 Then
            frmQckCtpAnalDebitos.rllBoleto.Caption := 'VEIO BOLETO?: SIM'

          Else If rdgBoleto.ItemIndex = 2 Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpAnalDebitos.rllBoleto.Caption := 'VEIO BOLETO?: NAO'
            Else
              frmQckCtpAnalDebitos.rllBoleto.Caption := 'VEIO BOLETO?: NÃO';
          End
          Else
            frmQckCtpAnalDebitos.rllBoleto.Caption := 'VEIO BOLETO?: TODOS';

          If rdgCheque.ItemIndex = 1 Then
            frmQckCtpAnalDebitos.rllCheque.Caption := 'VEIO CHEQUE?: SIM'

          Else If rdgCheque.ItemIndex = 2 Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpAnalDebitos.rllCheque.Caption := 'VEIO CHEQUE?: NAO'
            Else
              frmQckCtpAnalDebitos.rllCheque.Caption := 'VEIO CHEQUE?: NÃO';
          End
          Else
            frmQckCtpAnalDebitos.rllCheque.Caption := 'VEIO CHEQUE?: TODOS';

          If gpbVeioNF.ItemIndex = 1 Then
            frmQckCtpAnalDebitos.rllVeioNF.Caption := 'VEIO NF?: SIM'

          Else If gpbVeioNF.ItemIndex = 2 Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpAnalDebitos.rllVeioNF.Caption := 'VEIO NF?: NAO'
            Else
              frmQckCtpAnalDebitos.rllVeioNF.Caption := 'VEIO NF?: NÃO';
          End
          Else
            frmQckCtpAnalDebitos.rllVeioNF.Caption := 'VEIO NF?: TODOS';

          If rdgDeposito.ItemIndex = 1 Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpAnalDebitos.rllDeposito.Caption := 'DEPOSITO?: SIM'
            Else
              frmQckCtpAnalDebitos.rllDeposito.Caption := 'DEPÓSITO?: SIM';
          End

          Else If rdgDeposito.ItemIndex = 2 Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpAnalDebitos.rllDeposito.Caption := 'DEPOSITO?: NAO'
            Else
              frmQckCtpAnalDebitos.rllDeposito.Caption := 'DEPÓSITO?: NÃO';
          End
          Else
            If strTipImp = 'M' then
              frmQckCtpAnalDebitos.rllDeposito.Caption := 'DEPOSITO?: TODOS'
            Else
              frmQckCtpAnalDebitos.rllDeposito.Caption := 'DEPÓSITO?: TODOS';

          If chkAjuDta.Checked Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpAnalDebitos.rllAjuDta.Caption := 'AJUSTAR VENCIMENTOS CONSIDERANDO SABADO, DOMINGOS E FERIADOS?: SIM'
            Else
              frmQckCtpAnalDebitos.rllAjuDta.Caption := 'AJUSTAR VENCIMENTOS CONSIDERANDO SÁBADO, DOMINGOS E FERIADOS?: SIM';
          End
          Else
          Begin
            If strTipImp = 'M' then
              frmQckCtpAnalDebitos.rllAjuDta.Caption := 'AJUSTAR VENCIMENTOS CONSIDERANDO SABADO, DOMINGOS E FERIADOS?: NAO'
            Else
              frmQckCtpAnalDebitos.rllAjuDta.Caption := 'AJUSTAR VENCIMENTOS CONSIDERANDO SÁBADO, DOMINGOS E FERIADOS?: NÃO';
          End;

          If strTipImp = 'M' then
          Begin
            frmQckCtpAnalDebitos.rllTitForn.Caption := 'CODIGO - NOME FORNECEDOR';
            frmQckCtpAnalDebitos.RLLabel22.Caption  := 'CODIGO - NOME FORNECEDOR';
          End
          Else
          Begin
            frmQckCtpAnalDebitos.rllTitForn.Caption := 'CÓDIGO - NOME FORNECEDOR';
            frmQckCtpAnalDebitos.RLLabel22.Caption  := 'CÓDIGO - NOME FORNECEDOR';
          End;

          If strTipImp = 'M' then
          Begin
            frmQckCtpAnalDebitos.rllTitHistorico.Caption    := 'HISTORICO';
            frmQckCtpAnalDebitos.rllTitHistoricoRes.Caption := 'HISTORICO';
          End
          Else
          Begin
            frmQckCtpAnalDebitos.rllTitHistorico.Caption    := 'HISTÓRICO';
            frmQckCtpAnalDebitos.rllTitHistoricoRes.Caption := 'HISTÓRICO';
          End;

          Case cbxOpcao.ItemIndex Of
            IDX_AN_VEN: Begin
                 If strTipImp = 'M' then
                   frmQckCtpAnalDebitos.rllNomeRelatorio.Caption := 'RELATORIO DE TITULOS A PAGAR - ANALITICO POR VENCIMENTO'
                 Else
                   frmQckCtpAnalDebitos.rllNomeRelatorio.Caption := 'RELATÓRIO DE TÍTULOS A PAGAR - ANALÍTICO POR VENCIMENTO';

                 If fCfgSis('MODREL_TAP') = '1' Then
                 Begin
                   frmQckCtpAnalDebitos.rlbTitulo.Visible        := True;
                   frmQckCtpAnalDebitos.rlbGrupo.Visible         := True;
                   frmQckCtpAnalDebitos.rlbTituloRes.Visible     := False;
                   frmQckCtpAnalDebitos.rlbGrupoRes.Visible      := False;
                 End
                 Else
                 Begin
                   frmQckCtpAnalDebitos.rlbTitulo.Visible        := False;
                   frmQckCtpAnalDebitos.rlbGrupo.Visible         := False;
                   frmQckCtpAnalDebitos.rlbTituloRes.Visible     := True;
                   frmQckCtpAnalDebitos.rlbGrupoRes.Visible      := True;
                 End;
                 frmQckCtpAnalDebitos.rlbResumo2.Visible       := False;
               End;
            IDX_AN_FOR: Begin
                  If strTipImp = 'M' then
                   frmQckCtpAnalDebitos.rllNomeRelatorio.Caption := 'RELATORIO DE TITULOS A PAGAR - ANALITICO POR FORNECEDOR'
                 Else
                   frmQckCtpAnalDebitos.rllNomeRelatorio.Caption := 'RELATÓRIO DE TÍTULOS A PAGAR - ANALÍTICO POR FORNECEDOR';

                 If fCfgSis('MODREL_TAP') = '1' Then
                 Begin
                   frmQckCtpAnalDebitos.rlbTitulo.Visible        := True;
                   frmQckCtpAnalDebitos.rlbGrupo.Visible         := True;
                   frmQckCtpAnalDebitos.rlbTituloRes.Visible     := False;
                   frmQckCtpAnalDebitos.rlbGrupoRes.Visible      := False;
                   frmQckCtpAnalDebitos.rlbGrupo.DataFields      := 'FOR_NOMFOR';
                   frmQckCtpAnalDebitos.RLLabel10.Visible        := False;
                   frmQckCtpAnalDebitos.RLLabel13.Caption        := 'Total do Fornecedor';
                 End
                 Else
                 Begin
                   frmQckCtpAnalDebitos.rlbTitulo.Visible        := False;
                   frmQckCtpAnalDebitos.rlbGrupo.Visible         := False;
                   frmQckCtpAnalDebitos.rlbTituloRes.Visible     := True;
                   frmQckCtpAnalDebitos.rlbGrupoRes.Visible      := True;
                   frmQckCtpAnalDebitos.rlbGrupoRes.DataFields   := 'FOR_NOMFOR';
                   frmQckCtpAnalDebitos.rllResData.Visible       := False;
                   frmQckCtpAnalDebitos.rllResTotal.Caption      := 'Total do Fornecedor';
                 End;
                 frmQckCtpAnalDebitos.rlbResumo2.Visible       := False;

               End;
            IDX_AN_POR: Begin
                If strTipImp = 'M' Then
                  frmQckCtpAnalDebitos.rllNomeRelatorio.Caption := 'RELATORIO DE TITULOS A PAGAR - ANALITICO POR PORTADOR'
                Else
                  frmQckCtpAnalDebitos.rllNomeRelatorio.Caption := 'RELATÓRIO DE TÍTULOS A PAGAR - ANALÍTICO POR PORTADOR';

                If fCfgSis('MODREL_TAP') = '1' Then
                Begin
                  frmQckCtpAnalDebitos.rlbTitulo.Visible        := True;
                  frmQckCtpAnalDebitos.rlbGrupo.Visible         := True;
                  frmQckCtpAnalDebitos.rlbTituloRes.Visible     := False;
                  frmQckCtpAnalDebitos.rlbGrupoRes.Visible      := False;
                  frmQckCtpAnalDebitos.rlbTituloGrupo.Visible   := True;
                  frmQckCtpAnalDebitos.rlbEvento.Visible        := True;
                  frmQckCtpAnalDebitos.rlbEvento.DataField      := 'CTP_CODPOR';
                  frmQckCtpAnalDebitos.rlbGrupo.DataFields      := 'CTP_CODPOR';
                  frmQckCtpAnalDebitos.RLLabel10.Visible        := False;
                  frmQckCtpAnalDebitos.RLLabel13.Caption        := 'Total do Portador';
                End
                Else
                Begin
                  frmQckCtpAnalDebitos.rlbTitulo.Visible        := False;
                  frmQckCtpAnalDebitos.rlbGrupo.Visible         := False;
                  frmQckCtpAnalDebitos.rlbTituloRes.Visible     := True;
                  frmQckCtpAnalDebitos.rlbGrupoRes.Visible      := True;
                  frmQckCtpAnalDebitos.rlbTituloGrupoRes.Visible:= True;
                  frmQckCtpAnalDebitos.rlbEventoRes.Visible     := True;
                  frmQckCtpAnalDebitos.rlbEventoRes.DataField   := 'CTP_CODPOR';
                  frmQckCtpAnalDebitos.rlbGrupoRes.DataFields   := 'CTP_CODPOR';
                  frmQckCtpAnalDebitos.rllResData.Visible       := False;
                  frmQckCtpAnalDebitos.rllResTotal.Caption      := 'Total do Portador';
                End;

                frmQckCtpAnalDebitos.rlbResumo2.Visible       := False;
              End;
            IDX_AN_EVE: Begin
                 If strTipImp = 'M' then
                   frmQckCtpAnalDebitos.rllNomeRelatorio.Caption := 'RELATORIO DE TITULOS A PAGAR - ANALITICO POR CENTRO DE CUSTOS'
                 Else
                   frmQckCtpAnalDebitos.rllNomeRelatorio.Caption := 'RELATÓRIO DE TÍTULOS A PAGAR - ANALÍTICO POR CENTRO DE CUSTOS';

                 If fCfgSis('MODREL_TAP') = '1' Then
                 Begin
                   frmQckCtpAnalDebitos.rlbTitulo.Visible        := True;
                   frmQckCtpAnalDebitos.rlbGrupo.Visible         := True;
                   frmQckCtpAnalDebitos.rlbTituloRes.Visible     := False;
                   frmQckCtpAnalDebitos.rlbGrupoRes.Visible      := False;
                   frmQckCtpAnalDebitos.rlbTituloGrupo.Visible   := True;
                   frmQckCtpAnalDebitos.rlbEvento.Visible        := True;
                   frmQckCtpAnalDebitos.rlbEvento.DataField      := 'CTP_CODEVE';
                   frmQckCtpAnalDebitos.rlbGrupo.DataFields      := 'CTP_CODEVE';
                   frmQckCtpAnalDebitos.RLLabel10.Visible        := False;
                   frmQckCtpAnalDebitos.RLLabel13.Caption        := 'Total do Centro de Custos';
                 End
                 Else
                 Begin
                   frmQckCtpAnalDebitos.rlbTitulo.Visible        := False;
                   frmQckCtpAnalDebitos.rlbGrupo.Visible         := False;
                   frmQckCtpAnalDebitos.rlbTituloRes.Visible     := True;
                   frmQckCtpAnalDebitos.rlbGrupoRes.Visible      := True;
                   frmQckCtpAnalDebitos.rlbTituloGrupoRes.Visible:= True;
                   frmQckCtpAnalDebitos.rlbEventoRes.Visible     := True;
                   frmQckCtpAnalDebitos.rlbEventoRes.DataField   := 'CTP_CODEVE';
                   frmQckCtpAnalDebitos.rlbGrupoRes.DataFields   := 'CTP_CODEVE';
                   frmQckCtpAnalDebitos.rllResData.Visible       := False;
                   frmQckCtpAnalDebitos.rllResTotal.Caption      := 'Total do Centro de Custos';
                 End;
                 frmQckCtpAnalDebitos.rlbResumo2.Visible       := False;

               End;
            IDX_AN_ATI: Begin
                 If strTipImp = 'M' then
                   frmQckCtpAnalDebitos.rllNomeRelatorio.Caption := 'RELATORIO DE TITULOS A PAGAR - ANALITICO POR ATIVIDADE'
                 Else
                   frmQckCtpAnalDebitos.rllNomeRelatorio.Caption := 'RELATÓRIO DE TÍTULOS A PAGAR - ANALÍTICO POR ATIVIDADE';

                 If fCfgSis('MODREL_TAP') = '1' Then
                 Begin
                   frmQckCtpAnalDebitos.rlbTitulo.Visible        := True;
                   frmQckCtpAnalDebitos.rlbGrupo.Visible         := True;
                   frmQckCtpAnalDebitos.rlbTituloRes.Visible     := False;
                   frmQckCtpAnalDebitos.rlbGrupoRes.Visible      := False;
                   frmQckCtpAnalDebitos.rlbTituloGrupo.Visible   := True;
                   frmQckCtpAnalDebitos.rlbEvento.Visible        := True;
                   frmQckCtpAnalDebitos.rlbEvento.DataField      := 'ATI_CODATI';
                   frmQckCtpAnalDebitos.rlbGrupo.DataFields      := 'ATI_CODATI';
                   frmQckCtpAnalDebitos.RLLabel10.Visible        := False;
                   frmQckCtpAnalDebitos.RLLabel13.Caption        := 'Total da Atividade';
                 End
                 Else
                 Begin
                   frmQckCtpAnalDebitos.rlbTitulo.Visible        := False;
                   frmQckCtpAnalDebitos.rlbGrupo.Visible         := False;
                   frmQckCtpAnalDebitos.rlbTituloRes.Visible     := True;
                   frmQckCtpAnalDebitos.rlbGrupoRes.Visible      := True;
                   frmQckCtpAnalDebitos.rlbTituloGrupoRes.Visible:= True;
                   frmQckCtpAnalDebitos.rlbEventoRes.Visible     := True;
                   frmQckCtpAnalDebitos.rlbEventoRes.DataField   := 'ATI_CODATI';
                   frmQckCtpAnalDebitos.rlbGrupoRes.DataFields   := 'ATI_CODATI';
                   frmQckCtpAnalDebitos.rllResData.Visible       := False;
                   frmQckCtpAnalDebitos.rllResTotal.Caption      := 'Total da Atividade';
                 End;
                 frmQckCtpAnalDebitos.rlbResumo2.Visible       := False;

               End;
            IDX_SN_FOR: Begin
                 If strTipImp = 'M' then
                   frmQckCtpAnalDebitos.rllNomeRelatorio.Caption := 'RELATORIO DE TITULOS A PAGAR - SINTETICO POR FORNECEDOR'
                 Else
                   frmQckCtpAnalDebitos.rllNomeRelatorio.Caption := 'RELATÓRIO DE TÍTULOS A PAGAR - SINTÉTICO POR FORNECEDOR';

                 frmQckCtpAnalDebitos.rlbTitulo2.Visible       := True;
                 frmQckCtpAnalDebitos.rlbDetalhe.Visible       := True;
                 frmQckCtpAnalDebitos.rlbResumo1.Visible       := False;
               End;
            IDX_SN_VEN: Begin
                 If strTipImp = 'M' then
                   frmQckCtpAnalDebitos.rllNomeRelatorio.Caption := 'RELATORIO DE TITULOS A PAGAR - SINTETICO POR VENCIMENTO'
                 Else
                   frmQckCtpAnalDebitos.rllNomeRelatorio.Caption := 'RELATÓRIO DE TÍTULOS A PAGAR - SINTÉTICO POR VENCIMENTO';

                 frmQckCtpAnalDebitos.rlbTitulo2.Visible       := True;
                 frmQckCtpAnalDebitos.rlbDetalhe.Visible       := True;
                 frmQckCtpAnalDebitos.rlbResumo1.Visible       := False;

                 frmQckCtpAnalDebitos.rllNomFor.Caption        := 'VENCIMENTO';
                 frmQckCtpAnalDebitos.rdbNomFor.DataField      := 'CTP_DTAVEN';
               End;
          End;

          If (cbxOpcao.ItemIndex = IDX_AN_VEN) Or
             (cbxOpcao.ItemIndex = IDX_AN_FOR) Or
             (cbxOpcao.ItemIndex = IDX_AN_EVE) Or
             (cbxOpcao.ItemIndex = IDX_AN_POR) Or
             (cbxOpcao.ItemIndex = IDX_AN_ATI) Then
          Begin
            If chkNovaPaginaQuebra.Checked Then
            Begin
              If fCfgSis('MODREL_TAP') = '1' Then
                frmQckCtpAnalDebitos.rlbGrupo.PageBreaking := pbBeforePrint
              Else
                frmQckCtpAnalDebitos.rlbGrupoRes.PageBreaking := pbBeforePrint;
            End;
          End;

          If (rdgValorASerExibido.ItemIndex = 0) then
          Begin
            frmQckCtpAnalDebitos.rlbValPgt.Caption := IfThen(strTipImp = 'M', 'VALOR LIQUIDO', 'VALOR LÍQUIDO');
            frmQckCtpAnalDebitos.rllAgrVl.Caption := IfThen(strTipImp = 'M', 'VALOR LIQUIDO', 'VALOR LÍQUIDO');
            frmQckCtpAnalDebitos.rlLabel20.Caption := IfThen(strTipImp = 'M', 'VALOR LIQUIDO', 'VALOR LÍQUIDO');
          End
          Else
          Begin
            frmQckCtpAnalDebitos.rlbValPgt.Caption := 'VALOR BRUTO';
            frmQckCtpAnalDebitos.rllAgrVl.Caption := 'VALOR BRUTO';
            frmQckCtpAnalDebitos.rlLabel20.Caption := 'VALOR BRUTO';
          End;

          If edtDestino.Text = 'V' Then
            frmQckCtpAnalDebitos.qckPagina.PreviewModal
          Else If edtDestino.Text = 'I' Then
            frmQckCtpAnalDebitos.qckPagina.Print
          Else If edtDestino.Text = 'E' Then
            pGeraExcel;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
          End;
        End;
        pFreeAndNil(frmQckCtpAnalDebitos);
      End
      Else
      Begin
        pTabelaVazia;
      End;
      pSetFocus(mskDtaIni);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro('Ocorreu um erro ao gerar o relatório em Excel. Entre em contato com a Citel!' +
                    #13 + #13 + 'Erro gerado: ' + E.Message, '[frmRelCtpAnaDebitos.btnImprimirClick]');
    End;
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';

end;

procedure TfrmRelCtpAnaDebitos.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelCtpAnaDebitos.FormCreate(Sender: TObject);
begin
  inherited;
  qryRelEmp := fGetZClient(Self);
  shpMultSel.Visible := True;
end;

procedure TfrmRelCtpAnaDebitos.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelCtpAnaDebitos.edtCodEveExit(Sender: TObject);
begin
  inherited;
  If Not edtCodEve.ReadOnly Then
    pEdtCodSelectExit(edtCodEve, edtDesEve, arrEvento, fRetNomEvento, Nil, 'do Centro de Custos');
end;

procedure TfrmRelCtpAnaDebitos.edtCodEveKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EVENTOS    *}
  {****************************RV*}
  If fPesqEventos(Self, edtCodEve, edtDesEve, Nil, Key, arrEvento, False) Then
  Begin
    If fValidaCampos(edtCodEve, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpAnaDebitos.mskCodCtaExit(Sender: TObject);
begin
  inherited;
  If Not mskCodCta.ReadOnly Then
    pEdtCodSelectExit(mskCodCta, edtDesCta, arrCentroCusto, fRetNomeConta, Nil, 'do plano de contas');
end;

procedure TfrmRelCtpAnaDebitos.mskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, mskCodCta, edtDesCta, Nil, Key, arrCentroCusto, False) Then
  Begin
    fValidaCampos(mskCodCta,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpAnaDebitos.pGeraExcel;
  Var
    frmAguarde: TfrmGravando;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fGeraExcel;
    frmAguarde.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pFreeAndNil(frmAguarde);
End;

procedure TfrmRelCtpAnaDebitos.edtDestinoExit(Sender: TObject);
begin
  //inherited;

end;

function TfrmRelCtpAnaDebitos.fGeraExcel(pgbStatus: TcxProgressBar): Boolean;
  Var
    objExcel : TExcel;
    strDia   : String;
    strFor   : String;
    strEve   : String;
    strAti   : String;
    strPor   : String;
    strNomArq: String;

    fltTotCtpD: Double;
    fltTotCtpG: Double;
    procedure pInformacao(strInfo: String; pgbStatus: TcxProgressBar);
    begin
      If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
      Begin
        TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInfo;
        Application.ProcessMessages;
      End;
    end;

    procedure pProgresso(intProgresso: Integer; intMaximo: Integer; pgbStatus: TcxProgressBar);
    begin
      If Assigned(pgbStatus) Then
      Begin
        pgbStatus.Visible  := (intProgresso + intMaximo) > 0;
        pgbStatus.Position := intProgresso;
        pgbStatus.properties.Max := intMaximo;
        Application.ProcessMessages;
      End;
    end;

    function fArquivoAberto: Boolean;
    var
     stmArquiv: TStream;
    begin
      Result := False;
      Try
         Try
           If FileExists(strNomArq) Then
             stmArquiv := TFileStream.Create(strNomArq, fmOpenRead or fmShareExclusive);
         Except
           on EStreamError do
           Begin
             pMensagemOK('O arquivo ' + strNomArq + ' está sendo usado por outro processo. Operação cancelada!');
             Result := True; // EFOpenError
           End;
         End;
      Finally
        If Assigned(stmArquiv) Then
          FreeAndNil(stmArquiv);
      End;
    End;
begin
  pInformacao('Aguarde, Gerando Excel...', pgbStatus);

  Screen.Cursor := crSQLWait;
  fltTotCtpD := 0;
  fltTotCtpG := 0;
  Try
    {*******************************************}
    {* CRIA UM OBJETO DO TIPO "EXCEL" E TORNA  *}
    {* A APLICAÇÃO INVISÍVEL                   *}
    {****************************************JB*}
    objExcel := TExcel.fCriarExcel(Nil);

    {*******************************************}
    {* ADICIONA UMA PASTA DE TRABALHO          *}
    {****************************************JB*}
    If Not objExcel.CriarArquivo Then
    Begin
      FreeAndNil(objExcel);
      Exit;
    End;

    With objExcel Do
    Begin
      strNomArq := NomeArquivo;

      If fArquivoAberto Then
      Begin
        FreeAndNil(objExcel);
        Exit;
      End;

      LinhaAtual := 01;

      {********************************}
      {* EMPRESA PADRAO DO SISTEMA    *}
      {*****************************JB*}
      Escrever(ProximaLinha, 01, fRetNomeEmpresaSelec(VS_strCodEmp));

      {*******************************************}
      {* TITULO DO RELATORIO                     *}
      {****************************************JB*}
      Case cbxOpcao.ItemIndex Of

        IDX_AN_VEN: Escrever(ProximaLinha, 01, 'RELATÓRIO DE TÍTULOS A PAGAR - ANALÍTICO POR DATA DE VENCIMENTO');

        IDX_SN_FOR: Escrever(ProximaLinha, 01, 'RELATÓRIO DE TÍTULOS A PAGAR - SINTÉTICO POR FORNECEDOR');

        IDX_SN_VEN: Escrever(ProximaLinha, 01, 'RELATÓRIO DE TÍTULOS A PAGAR - SINTÉTICO POR VENCIMENTO');

        IDX_AN_FOR: Escrever(ProximaLinha, 01, 'RELATÓRIO DE TÍTULOS A PAGAR - ANALÍTICO POR FORNECEDOR');

        IDX_AN_EVE: Escrever(ProximaLinha, 01, 'RELATÓRIO DE TÍTULOS A PAGAR - ANALÍTICO POR EVENTO');

        IDX_AN_ATI: Escrever(ProximaLinha, 01, 'RELATÓRIO DE TÍTULOS A PAGAR - ANALÍTICO POR ATIVIDADE');

        IDX_AN_POR: Escrever(ProximaLinha, 01, 'RELATÓRIO DE TÍTULOS A PAGAR - ANALÍTICO POR PORTADOR');
      End;

      ProximaLinha;

      {*******************************************}
      {* OUTROS DADOS DO RELATÓRIO               *}
      {**03/04/2008 - 11:44 *******************ER*}
      If edtCodFornecedor.Text = '' Then
        Escrever(ProximaLinha, 01, 'FORNECEDOR: TODOS')
      Else
        Escrever(ProximaLinha, 01, fStrTitulo(edtCodFornecedor.Text, edtDesFornecedor, arrFornecedor, strFornecedor, 'FORNECEDOR'));

      If edtCodAtv.Text = '' Then
        Escrever(ProximaLinha, 01, 'ATIVIDADE: TODAS')
      Else
        Escrever(ProximaLinha, 01, fStrTitulo(edtCodAtv.Text, edtDesAtv, arrAtividade, strAtividade, 'ATIVIDADE'));

      If edtCodEve.Text = '' Then
        Escrever(ProximaLinha, 01, 'CENTRO DE CUSTOS: TODOS')
      Else
        Escrever(ProximaLinha, 01, fStrTitulo(edtCodEve.Text, edtDesEve, arrEvento, strEvento, 'CENTRO DE CUSTOS'));

      If edtCodEmpresa.Text = '' Then
        Escrever(ProximaLinha, 01, 'EMPRESA: TODAS')
      Else
        Escrever(ProximaLinha, 01, fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmpresa, strEmpresa, 'EMPRESA'));

      If fTiraCaracEspeciais(mskCodCta.Text) = '' Then
        Escrever(ProximaLinha, 01, 'PLANO DE CONTAS: TODOS')
      Else
        Escrever(ProximaLinha, 01, fStrTitulo(mskCodCta.Text, edtDesCta, arrCentroCusto, strCentroCusto, 'PLANO DE CONTAS'));

      If edtCodPor.Text = '' Then
        Escrever(ProximaLinha, 01, 'PORTADOR: TODOS')
      Else
        Escrever(ProximaLinha, 01, fStrTitulo(edtCodPor.Text, edtDesPortador, arrPortador, strPortador, 'PORTADOR'));

      If chkAjuDta.Checked Then
        Escrever(ProximaLinha, 01, 'AJUSTAR VENCIMENTOS CONSIDERANDO SÁBADO, DOMINGOS E FERIADOS?: SIM')
      Else
        Escrever(ProximaLinha, 01, 'AJUSTAR VENCIMENTOS CONSIDERANDO SÁBADO, DOMINGOS E FERIADOS?: NÃO');

      If (rdgIncPrevis.ItemIndex = 1)      Then Escrever(ProximaLinha, 01, 'INCLUÍDO PREVISÃO: NÃO')
      Else If (rdgIncPrevis.ItemIndex = 0) Then Escrever(ProximaLinha, 01, 'APENAS PREVISÃO')
      Else If (rdgIncPrevis.ItemIndex = 2) Then Escrever(ProximaLinha, 01, 'INCLUÍDO PREVISÃO: SIM');

      If rdgDeposito.ItemIndex = 1 Then      Escrever(ProximaLinha, 01, 'VEIO DEPÓSITO?: SIM')
      Else If rdgDeposito.ItemIndex = 2 Then Escrever(ProximaLinha, 01, 'VEIO DEPÓSITO?: NÃO')
      Else Escrever(ProximaLinha, 01, 'VEIO DEPÓSITO?: TODOS');

      If rdgBoleto.ItemIndex = 1 Then      Escrever(ProximaLinha, 01, 'VEIO BOLETO?: SIM')
      Else If rdgBoleto.ItemIndex = 2 Then Escrever(ProximaLinha, 01, 'VEIO BOLETO?: NÃO')
      Else Escrever(ProximaLinha, 01, 'VEIO BOLETO?: TODOS');

      If gpbVeioNF.ItemIndex = 1 Then      Escrever(ProximaLinha, 01, 'VEIO NF?: SIM')
      Else If gpbVeioNF.ItemIndex = 2 Then Escrever(ProximaLinha, 01, 'VEIO NF?: NÃO')
      Else Escrever(ProximaLinha, 01, 'VEIO NF?: TODOS');

      If rdgCheque.ItemIndex = 1 Then      Escrever(ProximaLinha, 01, 'VEIO CHEQUE?: SIM')
      Else If rdgCheque.ItemIndex = 2 Then Escrever(ProximaLinha, 01, 'VEIO CHEQUE?: NÃO')
      Else Escrever(ProximaLinha, 01, 'VEIO CHEQUE?: TODOS');

      Escrever(ProximaLinha, 01, 'REFERENTE AO PERÍODO DE ' + FormatDateTime('dd/MM/yyyy', mskDtaIni.Date)  + ' A ' + FormatDateTime('dd/MM/yyyy', mskDtaFin.Date));

      AutoAjuste;

      ProximaLinha;

      If (cbxOpcao.ItemIndex = IDX_AN_VEN) Or (cbxOpcao.ItemIndex = IDX_AN_FOR) Or (cbxOpcao.ItemIndex = IDX_AN_EVE) Or (cbxOpcao.ItemIndex = IDX_AN_ATI) Or (cbxOpcao.ItemIndex = IDX_AN_POR) Then
      Begin
        {********************************}
        {* COLOCA EM NEGRITO E ALINHA   *}
        {* AO CENTRO DA CELULA          *}
        {*****************************JB*}
        If fCfgSis('MODREL_TAP') = '1' Then
        Begin
          {***********************************}
          {* CONFIGURAÇÃO ( COMPLETO )       *}
          {********************************JB*}
          If rdgImpHistCmp.ItemIndex = 1 Then
          Begin
            Mesclar('A1','L1');
            Mesclar('A2','L2');
            Mesclar('A3','L3');
            Alinhamento('A1','L3', Centro);
            Negrito('A1','L3', True);

            Mesclar('A4','L4');
            Mesclar('A5','L5');
            Mesclar('A6','L6');
            Mesclar('A7','L7');
            Mesclar('A8','L8');
            Mesclar('A9','L9');
            Mesclar('A10','L10');
            Mesclar('A11','L11');
            Mesclar('A12','L12');
            Mesclar('A13','L13');
            Mesclar('A14','L14');
            Mesclar('A15','L15');
            Mesclar('A16','L16');
            Mesclar('A17','L17');

            Alinhamento('A4','L17', Centro);
            Negrito('A4','L18', True);

            {*************************************}
            {* COLORI O FUNDO DA CELULA P/ CINZA *}
            {**********************************JB*}
            CorFundo('A2','L2', Cinza);
            CorFundo('A3','L3', Cinza);
            CorFundo('A18','L18', Cinza);
          End
          Else
          Begin
            Mesclar('A1','K1');
            Mesclar('A2','K2');
            Mesclar('A3','K3');
            Alinhamento('A1','K3', Centro);
            Negrito('A1','K3', True);

            Mesclar('A4','K4');
            Mesclar('A5','K5');
            Mesclar('A6','K6');
            Mesclar('A7','K7');
            Mesclar('A8','K8');
            Mesclar('A9','K9');
            Mesclar('A10','K10');
            Mesclar('A11','K11');
            Mesclar('A12','K12');
            Mesclar('A13','K13');
            Mesclar('A14','K14');
            Mesclar('A15','K15');
            Mesclar('A16','K16');
            Mesclar('A17','K17');

            Alinhamento('A4','K18', Centro);
            Negrito('A4','K18', True);

            {*************************************}
            {* COLORI O FUNDO DA CELULA P/ CINZA *}
            {**********************************JB*}
            CorFundo('A2','K2', Cinza);
            CorFundo('A3','K3', Cinza);
            CorFundo('A18','K18', Cinza);
          End;

          {*******************************************}
          {* COLUNAS                                 *}
          {****************************************JB*}
          Escrever(LinhaAtual, 01, 'VENCIMENTO');
          Escrever(LinhaAtual, 02, 'DUPLICATA');
          Escrever(LinhaAtual, 03, 'LOJA');
          Escrever(LinhaAtual, 04, 'CONTA');
          Escrever(LinhaAtual, 05, 'BOLETO?');
          Escrever(LinhaAtual, 06, 'DEPÓSITO?');
          Escrever(LinhaAtual, 07, 'CÓDIGO - NOME FORNECEDOR');
          Escrever(LinhaAtual, 08, 'CHEQUE');
          Escrever(LinhaAtual, 09, 'PREVISÃO');

          If rdgImpHistCmp.ItemIndex = 1 Then
          Begin
            Escrever(LinhaAtual, 10, 'HISTÓRICO');
            Escrever(LinhaAtual, 11, 'DATA CADASTRO');

            If (rdgValorASerExibido.ItemIndex = 0) then
              Escrever(LinhaAtual, 12, 'VALOR LÍQUIDO')
            Else
              Escrever(LinhaAtual, 12, 'VALOR BRUTO');
          End
          Else
          Begin
            Escrever(LinhaAtual, 10, 'DATA CADASTRO');

            If (rdgValorASerExibido.ItemIndex = 0) then
              Escrever(LinhaAtual, 11, 'VALOR LÍQUIDO')
            Else
              Escrever(LinhaAtual, 11, 'VALOR BRUTO');
          End;

          {*******************************************}
          {* COLOCA NEGRITO NAS COLUNAS              *}
          {****************************************JB*}
          Negrito('A' + IntToStr(LinhaAtual), 'L' + IntToStr(LinhaAtual), True);

          {********************************}
          {* INSERE BORDAS NA CELULA      *}
          {*****************************JB*}
          If rdgImpHistCmp.ItemIndex = 1 Then
            Bordas('A5', 'L18')
          Else
            Bordas('A5', 'K18');
        End
        Else
        Begin
          {***********************************}
          {* CONFIGURAÇÃO ( RESUMIDO )       *}
          {********************************JB*}
          If rdgImpHistCmp.ItemIndex = 1 Then
          Begin
            Mesclar('A1', 'J1');
            Mesclar('A2', 'J2');
            Mesclar('A3', 'J3');
            Alinhamento('A1','J3', Centro);
            Negrito('A1','J3', True);

            Mesclar('A4', 'J4');
            Mesclar('A5', 'J5');
            Mesclar('A6', 'J6');
            Mesclar('A7', 'J7');
            Mesclar('A8', 'J8');
            Mesclar('A9', 'J9');
            Mesclar('A10', 'J10');
            Mesclar('A11', 'J11');
            Mesclar('A12', 'J12');
            Mesclar('A13', 'J13');
            Mesclar('A14', 'J14');
            Mesclar('A15', 'J15');
            Mesclar('A16', 'J16');
            Mesclar('A17', 'J17');

            Alinhamento('A4','J18', Centro);
            Negrito('A4','J18', True);

            {*************************************}
            {* COLORI O FUNDO DA CELULA P/ CINZA *}
            {**********************************JB*}
            CorFundo('A2','J2', Cinza);
            CorFundo('A3','J3', Cinza);
            CorFundo('A18','J18', Cinza);
          End
          Else
          Begin
            Mesclar('A1', 'I1');
            Mesclar('A2', 'I2');
            Mesclar('A3', 'I3');
            Alinhamento('A1','I3', Centro);
            Negrito('A1','I3', True);

            Mesclar('A4', 'I4');
            Mesclar('A5', 'I5');
            Mesclar('A6', 'I6');
            Mesclar('A7', 'I7');
            Mesclar('A8', 'I8');
            Mesclar('A9', 'I9');
            Mesclar('A10', 'I10');
            Mesclar('A11', 'I11');
            Mesclar('A12', 'I12');
            Mesclar('A13', 'I13');
            Mesclar('A14', 'I14');
            Mesclar('A15', 'I15');
            Mesclar('A16', 'I16');
            Mesclar('A17', 'J17');

            Alinhamento('A4','I18', Centro);
            Negrito('A4','I18', True);

            {*************************************}
            {* COLORI O FUNDO DA CELULA P/ CINZA *}
            {**********************************JB*}
            CorFundo('A2','I2', Cinza);
            CorFundo('A3','I3', Cinza);
            CorFundo('A18','I18', Cinza);
          End;

          {*******************************************}
          {* COLUNAS                                 *}
          {****************************************JB*}
          Escrever(LinhaAtual, 01, 'VENCIMENTO');
          Escrever(LinhaAtual, 02, 'DUPLICATA');
          Escrever(LinhaAtual, 03, 'CONTA');
          Escrever(LinhaAtual, 04, 'CÓDIGO - NOME FORNECEDOR');
          If rdgImpHistCmp.ItemIndex = 1 Then
          Begin
            Escrever(LinhaAtual, 05, 'HISTÓRICO');
            Escrever(LinhaAtual, 06, 'DATA CADASTRO');
            Escrever(LinhaAtual, 07, 'VALOR ORIGINAL');
            Escrever(LinhaAtual, 08, 'DESCONTO SUJ.');
            Escrever(LinhaAtual, 09, 'JUROS SUJ.');

            If (rdgValorASerExibido.ItemIndex = 0) then
              Escrever(LinhaAtual, 10, 'VALOR LÍQUIDO')
            Else
              Escrever(LinhaAtual, 10, 'VALOR BRUTO');
          End
          Else
          Begin
            Escrever(LinhaAtual, 05, 'DATA CADASTRO');
            Escrever(LinhaAtual, 06, 'VALOR ORIGINAL');
            Escrever(LinhaAtual, 07, 'DESCONTO SUJ.');
            Escrever(LinhaAtual, 08, 'JUROS SUJ.');

            If (rdgValorASerExibido.ItemIndex = 0) then
              Escrever(LinhaAtual, 09, 'VALOR LÍQUIDO')
            Else
              Escrever(LinhaAtual, 09, 'VALOR BRUTO');
          End;

          {*******************************************}
          {* COLOCA NEGRITO NAS COLUNAS              *}
          {****************************************JB*}
          Negrito('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual), True);

          {********************************}
          {* INSERE BORDAS NA CELULA      *}
          {*****************************JB*}
          If rdgImpHistCmp.ItemIndex = 1 Then
            Bordas('A5', 'J18')
          Else
            Bordas('A5', 'I18');

        End;

      End
      Else If (cbxOpcao.ItemIndex = IDX_SN_FOR) Then
      Begin
        {********************************}
        {* COLOCA EM NEGRITO E ALINHA   *}
        {* AO CENTRO DA CELULA          *}
        {*****************************JB*}
        Mesclar('A1','C1');
        Mesclar('A2','C2');
        Mesclar('A3','C3');
        Alinhamento('A1','C3', Centro);
        Negrito('A1','C3', True);

        Mesclar('A4','C4');
        Mesclar('A5','C5');
        Mesclar('A6','C6');
        Mesclar('A7','C7');
        Mesclar('A8','C8');
        Mesclar('A9','C9');
        Mesclar('A10','C10');
        Mesclar('A11','C11');
        Mesclar('A12','C12');
        Mesclar('A13','C13');
        Mesclar('A14','C14');
        Mesclar('A15','C15');
        Mesclar('A16','C16');
        Mesclar('A17','C17');

        Alinhamento('A5','C18', Centro);
        Negrito('A5','C18', True);

        {*************************************}
        {* COLORI O FUNDO DA CELULA P/ CINZA *}
        {**********************************JB*}
        CorFundo('A2','C2', Cinza);
        CorFundo('A3','C3', Cinza);
        CorFundo('A18','C18', Cinza);

        {*******************************************}
        {* COLUNAS                                 *}
        {****************************************JB*}
        Escrever(LinhaAtual, 01, 'CÓIGO          ');
        Escrever(LinhaAtual, 02, 'NOME FORNECEDOR');

        If (rdgValorASerExibido.ItemIndex = 0) then
          Escrever(LinhaAtual, 03, '                          VALOR LÍQUIDO')
        Else
          Escrever(LinhaAtual, 03, '                            VALOR BRUTO');

        {*******************************************}
        {* COLOCA NEGRITO NAS COLUNAS              *}
        {****************************************JB*}
        Negrito('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), True);

        {********************************}
        {* INSERE BORDAS NA CELULA      *}
        {*****************************JB*}
        Bordas('A5', 'C18');

      End
      Else
      Begin
        {********************************}
        {* COLOCA EM NEGRITO E ALINHA   *}
        {* AO CENTRO DA CELULA          *}
        {*****************************JB*}
        Mesclar('A1','C1');
        Mesclar('A2','C2');
        Mesclar('A3','C3');
        Alinhamento('A1','C3', Centro);
        Negrito('A1','C3', True);

        Mesclar('A4','C4');
        Mesclar('A5','C5');
        Mesclar('A6','C6');
        Mesclar('A7','C7');
        Mesclar('A8','C8');
        Mesclar('A9','C9');
        Mesclar('A10','C10');
        Mesclar('A11','C11');
        Mesclar('A12','C12');
        Mesclar('A13','C13');
        Mesclar('A14','C14');
        Mesclar('A15','C15');
        Mesclar('A16','C16');
        Mesclar('A17','C17');

        Alinhamento('A5','C18', Centro);
        Negrito('A5','C18', True);

        {*************************************}
        {* COLORI O FUNDO DA CELULA P/ CINZA *}
        {**********************************JB*}
        CorFundo('A2','C2', Cinza);
        CorFundo('A3','C3', Cinza);
        CorFundo('A18','C18', Cinza);

        {*******************************************}
        {* COLUNAS                                 *}
        {****************************************JB*}
        Escrever(LinhaAtual, 01, 'VENCIMENTO                                                                     ');
        Alinhamento('A18','A18', Esquerda);
        Mesclar('A12', 'B12');

        If (rdgValorASerExibido.ItemIndex = 0) then
          Escrever(LinhaAtual, 03, 'VALOR LÍQUIDO')
        Else
          Escrever(LinhaAtual, 03, 'VALOR BRUTO');

        {*******************************************}
        {* COLOCA NEGRITO NAS COLUNAS              *}
        {****************************************JB*}
        Negrito('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), True);

        {********************************}
        {* INSERE BORDAS NA CELULA      *}
        {*****************************JB*}
        Bordas('A5', 'C18');

      End;

      ProximaLinha;

      With dtsRelatorio.DataSet Do
      Begin
        First;

        strDia := FieldByName('CTP_DTAVEN').AsString;
        strFor := FieldByName('CTP_CODFOR').AsString;
        If cbxOpcao.ItemIndex = IDX_AN_EVE Then
        Begin
          strEve := FieldByName('CTP_CODEVE').AsString;
          Escrever(LinhaAtual, 01, 'EVENTO: ' + strEve + '-' + fRetNomEvento(strEve));
          Mesclar('A' + IntToStr(LinhaAtual), IfThen(rdgImpHistCmp.ItemIndex = 1, 'J', 'I') + IntToStr(LinhaAtual));
          ProximaLinha;
        End;
        If cbxOpcao.ItemIndex = IDX_AN_ATI Then
        Begin
          strAti := FieldByName('ATI_CODATI').AsString;
          Escrever(LinhaAtual, 01, 'ATIVIDADE: ' + strAti + '-' + fRetNomAtividade(strAti));
          Mesclar('A' + IntToStr(LinhaAtual), IfThen(rdgImpHistCmp.ItemIndex = 1, 'J', 'I') + IntToStr(LinhaAtual));
          ProximaLinha;
        End;
        If cbxOpcao.ItemIndex = IDX_AN_POR Then
        Begin
          strPor := FieldByName('CTP_CODPOR').AsString;
          Escrever(LinhaAtual, 01, 'PORTADOR: ' + IfThen(fEmptyStr(strPor), '', '- ') + strPor + fRetNomPortador(strPor));
          Mesclar('A' + IntToStr(LinhaAtual), ifthen(rdgImpHistCmp.ItemIndex = 1, 'J', 'I') + IntToStr(LinhaAtual));
          ProximaLinha;
        End;
        While (Not Eof) Do
        Begin
          If (cbxOpcao.ItemIndex = IDX_AN_VEN) Or (cbxOpcao.ItemIndex = IDX_AN_FOR) Or (cbxOpcao.ItemIndex = IDX_AN_EVE) Or (cbxOpcao.ItemIndex = IDX_AN_ATI) Or (cbxOpcao.ItemIndex = IDX_AN_POR) Then
          Begin
            If fCfgSis('MODREL_TAP') = '1' Then
            Begin
              {***********************************}
              {* CONFIGURAÇÃO ( COMPLETO )       *}
              {********************************JB*}
              Escrever(LinhaAtual, 01, '''' + FormatDateTime('dd/MM/yy', FieldByName('CTP_DTAVEN').AsDateTime)); //VENC
              Escrever(LinhaAtual, 02, '''' + FieldByName('CTP_NUMDUP').AsString + //DUPLICATA
                                       FieldByName('CTP_PARCEL').AsString);
              Escrever(LinhaAtual, 03, '''' + FieldByName('CTP_CODEMP').AsString); //LOJA
              Escrever(LinhaAtual, 04, '''' + FieldByName('CTP_CODCTA').AsString); //CTA
              Escrever(LinhaAtual, 05, IfThen(FieldByName('CTP_VEIOBO').AsString = 'S', 'SIM', 'NÃO')); //BOL?
              Escrever(LinhaAtual, 06, IfThen(FieldByName('CTP_DEPOSI').AsString = 'S', 'SIM', 'NÃO')); //DEPÓSITO?
              Escrever(LinhaAtual, 07, '''' + FieldByName('CTP_CODFOR').AsString + '-' + //CODIGO-FORNECEDOR
                                              FieldByName('FOR_NOMFOR').AsString);
              Escrever(LinhaAtual, 08, IfThen(FieldByName('CTP_USACHQ').AsString = 'S', 'SIM', 'NÃO')); //USA CHEQUE?
              Escrever(LinhaAtual, 09, IfThen(FieldByName('CTP_PREVIS').AsString = 'S', 'SIM', 'NÃO')); //COM PREVISAO?
              If rdgImpHistCmp.ItemIndex = 1 Then
              Begin
                Escrever(LinhaAtual, 10, FieldByName('CTP_HISCOM').AsString); //HISTORICO
                Escrever(LinhaAtual, 11, '''' + FormatDateTime('dd/MM/yy', FieldByName('CTP_DTACAD').AsDateTime)); //DATA CAD.

                If rdgValorASerExibido.ItemIndex = 0 Then
                Begin
                  Escrever(LinhaAtual, 12, FloatToStrF((FieldByName('CTP_VALDUP').AsFloat -     //VALOR
                                           FieldByName('CTP_DESSUJ').AsFloat +
                                           FieldByName('CTP_JURSUJ').AsFloat +
                                           FieldByName('CTP_VENDOR').AsFloat), ffFixed, 12, 2));

                  fltTotCtpD := fltTotCtpD + (FieldByName('CTP_VALDUP').AsFloat -
                                              FieldByName('CTP_DESSUJ').AsFloat +
                                              FieldByName('CTP_JURSUJ').AsFloat +
                                              FieldByName('CTP_VENDOR').AsFloat);
                 End
                Else If rdgValorASerExibido.ItemIndex = 1 Then
                Begin
                  Escrever(LinhaAtual, 12, FloatToStrF((FieldByName('CTP_VALDUP').AsFloat +     //VALOR
                                            FieldByName('CTP_VENDOR').AsFloat), ffFixed, 12, 2));

                  fltTotCtpD := fltTotCtpD + (FieldByName('CTP_VALDUP').AsFloat +
                                              FieldByName('CTP_VENDOR').AsFloat);
                End;

                Alinhamento(LinhaAtual, 12, Direita);
              End
              Else
              Begin
                Escrever(LinhaAtual, 10, '''' + FormatDateTime('dd/MM/yy', FieldByName('CTP_DTACAD').AsDateTime)); //DATA CAD.

                If rdgValorASerExibido.ItemIndex = 0 Then
                Begin
                  Escrever(LinhaAtual, 11, FloatToStrF((FieldByName('CTP_VALDUP').AsFloat -     //VALOR
                                           FieldByName('CTP_DESSUJ').AsFloat +
                                           FieldByName('CTP_JURSUJ').AsFloat +
                                           FieldByName('CTP_VENDOR').AsFloat), ffFixed, 12, 2));

                  fltTotCtpD := fltTotCtpD + (FieldByName('CTP_VALDUP').AsFloat -
                                              FieldByName('CTP_DESSUJ').AsFloat +
                                              FieldByName('CTP_JURSUJ').AsFloat +
                                              FieldByName('CTP_VENDOR').AsFloat);
                 End
                Else If rdgValorASerExibido.ItemIndex = 1 Then
                Begin
                  Escrever(LinhaAtual, 11, FloatToStrF((FieldByName('CTP_VALDUP').AsFloat +     //VALOR
                                            FieldByName('CTP_VENDOR').AsFloat), ffFixed, 12, 2));

                  fltTotCtpD := fltTotCtpD + (FieldByName('CTP_VALDUP').AsFloat +
                                              FieldByName('CTP_VENDOR').AsFloat);
                End;

                Alinhamento(LinhaAtual, 11, Direita);

                ProximaLinha;
                Mesclar('B' + IntToStr(LinhaAtual), 'F' + IntToStr(LinhaAtual));
                Escrever(LinhaAtual, 02, FieldByName('CTP_HISCOM').AsString);

                Alinhamento(LinhaAtual, 02, Esquerda);
              End;

            End
            Else
            Begin
              {***********************************}
              {* CONFIGURAÇÃO ( RESUMIDO )       *}
              {********************************JB*}
              Escrever(LinhaAtual, 01, '''' + FormatDateTime('dd/MM/yy', FieldByName('CTP_DTAVEN').AsDateTime)); //VENC
              Escrever(LinhaAtual, 02, '''' + FieldByName('CTP_NUMDUP').AsString + //DUPLICATA
                                       FieldByName('CTP_PARCEL').AsString);
              Escrever(LinhaAtual, 03, '''' + FieldByName('CTP_CODCTA').AsString); //CTA
              Escrever(LinhaAtual, 04, '''' + FieldByName('CTP_CODFOR').AsString + '-' + //CODIGO-FORNECEDOR
                                       FieldByName('FOR_NOMFOR').AsString);
              If rdgImpHistCmp.ItemIndex = 1 Then
              Begin
                Escrever(LinhaAtual, 05, FieldByName('CTP_HISCOM').AsString); //HISTORICO
                Escrever(LinhaAtual, 06, '''' + FormatDateTime('dd/MM/yy', FieldByName('CTP_DTACAD').AsDateTime)); //DATA CAD.
                Escrever(LinhaAtual, 07, FloatToStrF(FieldByName('CTP_VALORI').AsFloat, ffFixed, 12, 2)); //VALOR ORIGINAL
                Escrever(LinhaAtual, 08, FloatToStrF(FieldByName('CTP_DESSUJ').AsFloat, ffFixed, 12, 2)); //DESCONTO
                Escrever(LinhaAtual, 09, FloatToStrF(FieldByName('CTP_JURSUJ').AsFloat, ffFixed, 12, 2)); //JUROS

                If rdgValorASerExibido.ItemIndex = 0 Then
                Begin
                  Escrever(LinhaAtual, 10, FloatToStrF((FieldByName('CTP_VALDUP').AsFloat -     //VALOR LIQUIDO
                                           FieldByName('CTP_DESSUJ').AsFloat +
                                           FieldByName('CTP_JURSUJ').AsFloat +
                                           FieldByName('CTP_VENDOR').AsFloat), ffFixed, 12, 2));

                  fltTotCtpD := fltTotCtpD + (FieldByName('CTP_VALDUP').AsFloat - FieldByName('CTP_DESSUJ').AsFloat) +
                                              FieldByName('CTP_JURSUJ').AsFloat + FieldByName('CTP_VENDOR').AsFloat;
                 End
                Else If rdgValorASerExibido.ItemIndex = 1 Then
                Begin
                  Escrever(LinhaAtual, 10, FloatToStrF((FieldByName('CTP_VALDUP').AsFloat +     //VALOR
                                           FieldByName('CTP_VENDOR').AsFloat), ffFixed, 12, 2));

                  fltTotCtpD := fltTotCtpD + (FieldByName('CTP_VALDUP').AsFloat + FieldByName('CTP_VENDOR').AsFloat);

                End;

                Alinhamento(LinhaAtual, 07, Direita);
                Alinhamento(LinhaAtual, 08, Direita);
                Alinhamento(LinhaAtual, 09, Direita);
                Alinhamento(LinhaAtual, 10, Direita);
              End
              Else
              Begin
                Escrever(LinhaAtual, 05, '''' + FormatDateTime('dd/MM/yy', FieldByName('CTP_DTACAD').AsDateTime)); //DATA CAD.
                Escrever(LinhaAtual, 06, FloatToStrF(FieldByName('CTP_VALORI').AsFloat, ffFixed, 12, 2)); //VALOR ORIGINAL
                Escrever(LinhaAtual, 07, FloatToStrF(FieldByName('CTP_DESSUJ').AsFloat, ffFixed, 12, 2)); //DESCONTO
                Escrever(LinhaAtual, 08, FloatToStrF(FieldByName('CTP_JURSUJ').AsFloat, ffFixed, 12, 2)); //JUROS

                If rdgValorASerExibido.ItemIndex = 0 Then
                Begin
                  Escrever(LinhaAtual, 09, FloatToStrF((FieldByName('CTP_VALDUP').AsFloat -     //VALOR
                                           FieldByName('CTP_DESSUJ').AsFloat +
                                           FieldByName('CTP_JURSUJ').AsFloat +
                                           FieldByName('CTP_VENDOR').AsFloat), ffFixed, 12, 2));

                  fltTotCtpD := fltTotCtpD + (FieldByName('CTP_VALDUP').AsFloat - FieldByName('CTP_DESSUJ').AsFloat) +
                                              FieldByName('CTP_JURSUJ').AsFloat + FieldByName('CTP_VENDOR').AsFloat;
                 End
                Else If rdgValorASerExibido.ItemIndex = 1 Then
                Begin
                  Escrever(LinhaAtual, 09, FloatToStrF((FieldByName('CTP_VALDUP').AsFloat +     //VALOR
                                           FieldByName('CTP_VENDOR').AsFloat), ffFixed, 12, 2));

                  fltTotCtpD := fltTotCtpD + (FieldByName('CTP_VALDUP').AsFloat + FieldByName('CTP_VENDOR').AsFloat);

                End;

                Alinhamento(LinhaAtual, 06, Direita);
                Alinhamento(LinhaAtual, 07, Direita);
                Alinhamento(LinhaAtual, 08, Direita);
                Alinhamento(LinhaAtual, 09, Direita);

                ProximaLinha;
                Mesclar('B' + IntToStr(LinhaAtual), 'F' + IntToStr(LinhaAtual));
                Escrever(LinhaAtual, 02, FieldByName('CTP_HISCOM').AsString);

                Alinhamento(LinhaAtual, 02, Esquerda);
              End;

            End;

          End

          Else If (cbxOpcao.ItemIndex = IDX_SN_FOR) Then
          Begin
            Escrever(LinhaAtual, 01, '''' + FieldByName('CTP_CODFOR').AsString);
            Escrever(LinhaAtual, 02, FieldByName('FOR_NOMFOR').AsString);
            Escrever(LinhaAtual, 03, FloatToStrF(FieldByName('CTP_VALDUP').AsFloat, ffFixed, 12, 2));
            Alinhamento(LinhaAtual, 03, Direita);

            fltTotCtpG := fltTotCtpG + FieldByName('CTP_VALDUP').AsFloat;

          End

          Else
          Begin
            Escrever(LinhaAtual, 01, '''' + FormatDateTime('dd/MM/yy', FieldByName('CTP_DTAVEN').AsDateTime));
            Mesclar('A' + IntToStr(LinhaAtual), 'B' + IntToStr(LinhaAtual));
            Escrever(LinhaAtual, 03, FloatToStrF(FieldByName('CTP_VALDUP').AsFloat, ffFixed, 12, 2));
            Alinhamento(LinhaAtual, 03, Direita);

            fltTotCtpG := fltTotCtpG + FieldByName('CTP_VALDUP').AsFloat;

          End;


          ProximaLinha;

          Next;

          If (cbxOpcao.ItemIndex = IDX_AN_VEN) Then
          Begin
            IF ((strDia <> FieldByName('CTP_DTAVEN').AsString) Or (Eof)) Then
            Begin
              If fCfgSis('MODREL_TAP') = '1' Then
              Begin
                {***********************************}
                {* CONFIGURAÇÃO ( COMPLETO )       *}
                {********************************JB*}
                Escrever(LinhaAtual, 10, 'Total Parcial do Dia:');
                Escrever(LinhaAtual, 11, '''' + FormatDateTime('dd/MM/yy', strToDate(strDia)));
                Escrever(LinhaAtual, 12, FloatToStrF(fltTotCtpD, ffFixed, 12, 2));

                Mesclar('A'+ IntToStr(LinhaAtual) , 'J' + IntToStr(LinhaAtual));
                Negrito('A'+ IntToStr(LinhaAtual) , 'M' + IntToStr(LinhaAtual), True);
                Alinhamento('A' + IntToStr(LinhaAtual), 'M' + IntToStr(LinhaAtual), Direita);

                strDia := FieldByName('CTP_DTAVEN').AsString;
                strFor := FieldByName('CTP_CODFOR').AsString;

                fltTotCtpG := fltTotCtpG + fltTotCtpD;
                fltTotCtpD := 0;

                ProximaLinha;
              End
              Else
              Begin
                {***********************************}
                {* CONFIGURAÇÃO ( RESUMIDO )       *}
                {********************************JB*}
                Escrever(LinhaAtual, 07, 'Total Parcial do Dia:');

                If rdgImpHistCmp.ItemIndex = 1 Then
                Begin
                  Escrever(LinhaAtual, 09, '''' + FormatDateTime('dd/MM/yy', strToDate(strDia)));
                  Escrever(LinhaAtual, 10, FloatToStrF(fltTotCtpD, ffFixed, 12, 2));
                End
                Else
                Begin
                  Escrever(LinhaAtual, 08, '''' + FormatDateTime('dd/MM/yy', strToDate(strDia)));
                  Escrever(LinhaAtual, 09, FloatToStrF(fltTotCtpD, ffFixed, 12, 2));
                End;

                Mesclar('A'+ IntToStr(LinhaAtual) , 'G' + IntToStr(LinhaAtual));
                Negrito('A'+ IntToStr(LinhaAtual) , ifthen(rdgImpHistCmp.ItemIndex = 1, 'J', 'I') + IntToStr(LinhaAtual), True);
                Alinhamento('A' + IntToStr(LinhaAtual), ifthen(rdgImpHistCmp.ItemIndex = 1, 'J', 'I') + IntToStr(LinhaAtual), Direita);

                strDia := FieldByName('CTP_DTAVEN').AsString;
                strFor := FieldByName('CTP_CODFOR').AsString;

                fltTotCtpG := fltTotCtpG + fltTotCtpD;
                fltTotCtpD := 0;

                ProximaLinha;

              End;

            End;
          End
          Else If (cbxOpcao.ItemIndex = IDX_AN_FOR) Then
          Begin
            If ((strFor <> FieldByName('CTP_CODFOR').AsString) Or (Eof)) Then
            Begin
              If fCfgSis('MODREL_TAP') = '1' Then
              Begin
                {***********************************}
                {* CONFIGURAÇÃO ( COMPLETO )       *}
                {********************************JB*}
                If rdgImpHistCmp.ItemIndex = 1 Then
                Begin
                  Escrever(LinhaAtual, 11, 'Total do Fornecedor:');
                  Escrever(LinhaAtual, 12, FloatToStrF(fltTotCtpD, ffFixed, 12, 2));
                End
                Else
                Begin
                  Escrever(LinhaAtual, 10, 'Total do Fornecedor:');
                  Escrever(LinhaAtual, 11, FloatToStrF(fltTotCtpD, ffFixed, 12, 2));
                End;

                Mesclar('A'+ IntToStr(LinhaAtual) , 'J' + IntToStr(LinhaAtual));
                Negrito('A'+ IntToStr(LinhaAtual) , 'L' + IntToStr(LinhaAtual), True);
                Alinhamento('A' + IntToStr(LinhaAtual), 'L' + IntToStr(LinhaAtual), Direita);

                strDia := FieldByName('CTP_DTAVEN').AsString;
                strFor := FieldByName('CTP_CODFOR').AsString;

                fltTotCtpG := fltTotCtpG + fltTotCtpD;
                fltTotCtpD := 0;

                ProximaLinha;
              End
              Else
              Begin
                {***********************************}
                {* CONFIGURAÇÃO ( RESUMIDO )       *}
                {********************************JB*}
                Escrever(LinhaAtual, 09, 'Total do Fornecedor:');

                If rdgImpHistCmp.ItemIndex = 1 Then
                  Escrever(LinhaAtual, 10, FloatToStrF(fltTotCtpD, ffFixed, 12, 2))
                Else
                  Escrever(LinhaAtual, 09, FloatToStrF(fltTotCtpD, ffFixed, 12, 2));

                Mesclar('A'+ IntToStr(LinhaAtual) , ifthen(rdgImpHistCmp.ItemIndex = 0, 'J', 'I') + IntToStr(LinhaAtual));
                Negrito('A'+ IntToStr(LinhaAtual) , ifthen(rdgImpHistCmp.ItemIndex = 0, 'J', 'I') + IntToStr(LinhaAtual), True);
                Alinhamento('A' + IntToStr(LinhaAtual), ifthen(rdgImpHistCmp.ItemIndex = 0, 'J', 'I') + IntToStr(LinhaAtual), Direita);

                strDia := FieldByName('CTP_DTAVEN').AsString;
                strFor := FieldByName('CTP_CODFOR').AsString;

                fltTotCtpG := fltTotCtpG + fltTotCtpD;
                fltTotCtpD := 0;

                ProximaLinha;

              End;

            End;
          End
          Else If (cbxOpcao.ItemIndex = IDX_AN_POR) Then
          Begin
            If ((strPor <> FieldByName('CTP_CODPOR').AsString) Or (Eof)) Then
            Begin
              If fCfgSis('MODREL_TAP') = '1' Then
              Begin
                {***********************************}
                {* CONFIGURAÇÃO ( COMPLETO )       *}
                {********************************JB*}
                If rdgImpHistCmp.ItemIndex = 1 Then
                Begin
                  Escrever(LinhaAtual, 11, 'Total do Portador:');
                  Escrever(LinhaAtual, 12, FloatToStrF(fltTotCtpD, ffFixed, 12, 2));
                End
                Else
                Begin
                  Escrever(LinhaAtual, 10, 'Total do Portador:');
                  Escrever(LinhaAtual, 11, FloatToStrF(fltTotCtpD, ffFixed, 12, 2));
                End;

                Mesclar('A'+ IntToStr(LinhaAtual) , 'H' + IntToStr(LinhaAtual));
                Negrito('A'+ IntToStr(LinhaAtual) , 'L' + IntToStr(LinhaAtual), True);
                Alinhamento('A' + IntToStr(LinhaAtual), 'L' + IntToStr(LinhaAtual), Direita);

                strDia := FieldByName('CTP_DTAVEN').AsString;
                strPor := FieldByName('CTP_CODPOR').AsString;

                fltTotCtpG := fltTotCtpG + fltTotCtpD;
                fltTotCtpD := 0;

                ProximaLinha;

                If Not Eof Then
                Begin
                  Escrever(LinhaAtual, 01, 'PORTADOR: ' + strPor + fRetNomPortador(strPor));
                  Mesclar('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));
                  ProximaLinha;
                End;
              End
              Else
              Begin
                {***********************************}
                {* CONFIGURAÇÃO ( RESUMIDO )       *}
                {********************************JB*}
                Escrever(LinhaAtual, 07, 'Total do Portador:');

                If rdgImpHistCmp.ItemIndex = 1 Then
                  Escrever(LinhaAtual, 10, FloatToStrF(fltTotCtpD, ffFixed, 12, 2))
                Else
                  Escrever(LinhaAtual, 09, FloatToStrF(fltTotCtpD, ffFixed, 12, 2));

                Mesclar('A'+ IntToStr(LinhaAtual) , 'H' + IntToStr(LinhaAtual));
                Negrito('A'+ IntToStr(LinhaAtual) , ifthen(rdgImpHistCmp.ItemIndex = 1, 'J', 'I') + IntToStr(LinhaAtual), True);
                Alinhamento('A' + IntToStr(LinhaAtual), ifthen(rdgImpHistCmp.ItemIndex = 1, 'J', 'I') + IntToStr(LinhaAtual), Direita);

                strDia := FieldByName('CTP_DTAVEN').AsString;
                strPor := FieldByName('CTP_CODPOR').AsString;

                fltTotCtpG := fltTotCtpG + fltTotCtpD;
                fltTotCtpD := 0;

                ProximaLinha;

                If Not Eof Then
                Begin
                  Escrever(LinhaAtual, 01, 'PORTADOR: ' + strPor + fRetNomPortador(strPor));
                  Mesclar('A' + IntToStr(LinhaAtual), ifthen(rdgImpHistCmp.ItemIndex = 1, 'J', 'I') + IntToStr(LinhaAtual));
                  ProximaLinha;
                End;
              End;
            End;
          End
          Else If (cbxOpcao.ItemIndex = IDX_AN_EVE) Then
          Begin
            If ((strEVE <> FieldByName('CTP_CODEVE').AsString) Or (Eof)) Then
            Begin
              If fCfgSis('MODREL_TAP') = '1' Then
              Begin
                {***********************************}
                {* CONFIGURAÇÃO ( COMPLETO )       *}
                {********************************JB*}
                Escrever(LinhaAtual, 11, 'Total do Evento:');
                Escrever(LinhaAtual, 12, FloatToStrF(fltTotCtpD, ffFixed, 12, 2));

                Mesclar('A'+ IntToStr(LinhaAtual) , 'J' + IntToStr(LinhaAtual));
                Negrito('A'+ IntToStr(LinhaAtual) , 'L' + IntToStr(LinhaAtual), True);
                Alinhamento('A' + IntToStr(LinhaAtual), 'L' + IntToStr(LinhaAtual), Direita);

                strDia := FieldByName('CTP_DTAVEN').AsString;
                strFor := FieldByName('CTP_CODFOR').AsString;
                strEve := FieldByName('CTP_CODEVE').AsString;

                fltTotCtpG := fltTotCtpG + fltTotCtpD;
                fltTotCtpD := 0;

                ProximaLinha;

                If Not Eof Then
                Begin
                  Escrever(LinhaAtual, 01, 'CENTRO DE CUSTOS: ' + strEve + '-' + fRetNomEvento(strEve));
                  Mesclar('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));
                  ProximaLinha;
                End;
              End
              Else
              Begin
                {***********************************}
                {* CONFIGURAÇÃO ( RESUMIDO )       *}
                {********************************JB*}
                Escrever(LinhaAtual, 07, 'Total do Evento:');

                If rdgImpHistCmp.ItemIndex = 1 Then
                  Escrever(LinhaAtual, 10, FloatToStrF(fltTotCtpD, ffFixed, 12, 2))
                Else
                  Escrever(LinhaAtual, 09, FloatToStrF(fltTotCtpD, ffFixed, 12, 2));

                Mesclar('A'+ IntToStr(LinhaAtual) , 'H' + IntToStr(LinhaAtual));
                Negrito('A'+ IntToStr(LinhaAtual) , ifthen(rdgImpHistCmp.ItemIndex = 1, 'J', 'I') + IntToStr(LinhaAtual), True);
                Alinhamento('A' + IntToStr(LinhaAtual), ifthen(rdgImpHistCmp.ItemIndex = 1, 'J', 'I') + IntToStr(LinhaAtual), Direita);

                strDia := FieldByName('CTP_DTAVEN').AsString;
                strFor := FieldByName('CTP_CODFOR').AsString;
                strEve := FieldByName('CTP_CODEVE').AsString;

                fltTotCtpG := fltTotCtpG + fltTotCtpD;
                fltTotCtpD := 0;

                ProximaLinha;

                If Not Eof Then
                Begin
                  Escrever(LinhaAtual, 01, 'EVENTO: ' + strEve + '-' + fRetNomEvento(strEve));
                  Mesclar('A' + IntToStr(LinhaAtual), ifthen(rdgImpHistCmp.ItemIndex = 1, 'J', 'I') + IntToStr(LinhaAtual));
                  ProximaLinha;
                End;
              End;

            End;
          End
          Else
          If (cbxOpcao.ItemIndex = IDX_AN_ATI) Then
          Begin
            If ((strAti <> FieldByName('ATI_CODATI').AsString) Or (Eof)) Then
            Begin
              If fCfgSis('MODREL_TAP') = '1' Then
              Begin
                {***********************************}
                {* CONFIGURAÇÃO ( COMPLETO )       *}
                {********************************JB*}
                Escrever(LinhaAtual, 11, 'Total da Atividade:');
                Escrever(LinhaAtual, 12, FloatToStrF(fltTotCtpD, ffFixed, 12, 2));

                Mesclar('A'+ IntToStr(LinhaAtual) , 'J' + IntToStr(LinhaAtual));
                Negrito('A'+ IntToStr(LinhaAtual) , 'L' + IntToStr(LinhaAtual), True);
                Alinhamento('A' + IntToStr(LinhaAtual), 'L' + IntToStr(LinhaAtual), Direita);

                strDia := FieldByName('CTP_DTAVEN').AsString;
                strFor := FieldByName('CTP_CODFOR').AsString;
                strAti := FieldByName('ATI_CODATI').AsString;

                fltTotCtpG := fltTotCtpG + fltTotCtpD;
                fltTotCtpD := 0;

                ProximaLinha;

                If Not Eof Then
                Begin
                  Escrever(LinhaAtual, 01, 'ATIVIDADE: ' + strAti + '-' + fRetNomAtividade(strAti));
                  Mesclar('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));
                  ProximaLinha;
                End;
              End
              Else
              Begin
                {***********************************}
                {* CONFIGURAÇÃO ( RESUMIDO )       *}
                {********************************JB*}
                Escrever(LinhaAtual, 07, 'Total da Atividade:');

                If rdgImpHistCmp.ItemIndex = 1 Then
                  Escrever(LinhaAtual, 10, FloatToStrF(fltTotCtpD, ffFixed, 12, 2))
                Else
                  Escrever(LinhaAtual, 09, FloatToStrF(fltTotCtpD, ffFixed, 12, 2));

                Mesclar('A'+ IntToStr(LinhaAtual) , 'H' + IntToStr(LinhaAtual));
                Negrito('A'+ IntToStr(LinhaAtual) , ifthen(rdgImpHistCmp.ItemIndex = 1, 'J', 'I') + IntToStr(LinhaAtual), True);
                Alinhamento('A' + IntToStr(LinhaAtual), ifthen(rdgImpHistCmp.ItemIndex = 1, 'J', 'I') + IntToStr(LinhaAtual), Direita);

                strDia := FieldByName('CTP_DTAVEN').AsString;
                strFor := FieldByName('CTP_CODFOR').AsString;
                strAti := FieldByName('ATI_CODATI').AsString;

                fltTotCtpG := fltTotCtpG + fltTotCtpD;
                fltTotCtpD := 0;

                ProximaLinha;

                If Not Eof Then
                Begin
                  Escrever(LinhaAtual, 01, 'ATIVIDADE: ' + strAti + '-' + fRetNomAtividade(strAti));
                  Mesclar('A' + IntToStr(LinhaAtual), ifthen(rdgImpHistCmp.ItemIndex = 1, 'J', 'I') + IntToStr(LinhaAtual));
                  ProximaLinha;
                End;
              End;

            End;
          End;

          pProgresso(RecNo, RecordCount, pgbStatus);
          Application.ProcessMessages;
        End;

        If (cbxOpcao.ItemIndex = IDX_AN_VEN) Or (cbxOpcao.ItemIndex = IDX_AN_FOR) Or (cbxOpcao.ItemIndex = IDX_AN_EVE) Or (cbxOpcao.ItemIndex = IDX_AN_ATI) Or (cbxOpcao.ItemIndex = IDX_AN_POR) Then
        Begin
          If fCfgSis('MODREL_TAP') = '1' Then
          Begin
            If rdgImpHistCmp.ItemIndex = 1 Then
            Begin
              Escrever(LinhaAtual, 11, 'TOTAL GERAL:');
              Escrever(LinhaAtual, 12, FloatToStrF(fltTotCtpG, ffFixed, 12, 2));
              Mesclar('A'+ IntToStr(LinhaAtual) , 'K' + IntToStr(LinhaAtual));
              Bordas('A'+ IntToStr(LinhaAtual) , 'L' + IntToStr(LinhaAtual));
              Alinhamento('A'+ IntToStr(LinhaAtual) , 'L' + IntToStr(LinhaAtual), Direita);
              Negrito('A' + IntToStr(LinhaAtual), 'L' + IntToStr(LinhaAtual), True);
            End
            Else
            Begin
              Escrever(LinhaAtual, 10, 'TOTAL GERAL:');
              Escrever(LinhaAtual, 11, FloatToStrF(fltTotCtpG, ffFixed, 12, 2));
              Mesclar('A'+ IntToStr(LinhaAtual) , 'J' + IntToStr(LinhaAtual));
              Bordas('A'+ IntToStr(LinhaAtual) , 'K' + IntToStr(LinhaAtual));
              Alinhamento('A'+ IntToStr(LinhaAtual) , 'K' + IntToStr(LinhaAtual), Direita);
              Negrito('A' + IntToStr(LinhaAtual), 'K' + IntToStr(LinhaAtual), True);
            End;

            AutoAjuste;
            ProximaLinha;
            ProximaLinha;
            Escrever(LinhaAtual, 07, 'FORMAS DE PAGAMENTO (PREVISÃO)');

            If (rdgValorASerExibido.ItemIndex = 0) then
              Escrever(LinhaAtual, 08, 'VALOR LÍQUIDO')
            Else
              Escrever(LinhaAtual, 08, 'VALOR BRUTO');

            CorFundo('G' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), Cinza);
            Bordas('G' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual));
            Alinhamento('H' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), Direita);
            Negrito('H' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), True);

            ProximaLinha;
            Escrever(LinhaAtual, 07, 'BOLETO:');
            Escrever(LinhaAtual, 08, FloatToStrF(fltValBol, ffFixed, 12, 2));
            Alinhamento('H' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), Direita);
            Bordas('G' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual));

            ProximaLinha;
            Escrever(LinhaAtual, 07, 'CHEQUE:');
            Escrever(LinhaAtual, 08, FloatToStrF(fltValChq, ffFixed, 12, 2));
            Alinhamento('H' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), Direita);
            Bordas('G' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual));

            ProximaLinha;
            Escrever(LinhaAtual, 07, 'DEPÓSITO:');
            Escrever(LinhaAtual, 08, FloatToStrF(fltValDep, ffFixed, 12, 2));
            Alinhamento('H' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), Direita);
            Bordas('G' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual));

            ProximaLinha;
            Escrever(LinhaAtual, 07, 'OUTROS:');
            Escrever(LinhaAtual, 08, FloatToStrF(fltValOut, ffFixed, 12, 2));
            Alinhamento('H' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), Direita);
            Bordas('G' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual));

          End
          Else
          Begin
            If rdgImpHistCmp.ItemIndex = 0 Then
            Begin
              Escrever(LinhaAtual, 08, 'TOTAL GERAL:');
              Escrever(LinhaAtual, 09, FloatToStrF(fltTotCtpG, ffFixed, 12, 2));
              Mesclar('A'+ IntToStr(LinhaAtual) , 'H' + IntToStr(LinhaAtual));
              Bordas('A'+ IntToStr(LinhaAtual) , 'I' + IntToStr(LinhaAtual));
              Alinhamento('A'+ IntToStr(LinhaAtual) , 'I' + IntToStr(LinhaAtual), Direita);
              Negrito('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), True);
            End
            Else
            Begin
              Escrever(LinhaAtual, 08, 'TOTAL GERAL:');
              Escrever(LinhaAtual, 10, FloatToStrF(fltTotCtpG, ffFixed, 12, 2));
              Mesclar('A'+ IntToStr(LinhaAtual) , 'H' + IntToStr(LinhaAtual));
              Bordas('A'+ IntToStr(LinhaAtual) , 'J' + IntToStr(LinhaAtual));
              Alinhamento('A'+ IntToStr(LinhaAtual) , 'J' + IntToStr(LinhaAtual), Direita);
              Negrito('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual), True);
            End;
            AutoAjuste;
            ProximaLinha;
            ProximaLinha;
            Escrever(LinhaAtual, 04, 'FORMAS DE PAGAMENTO (PREVISÃO)');

            If (rdgValorASerExibido.ItemIndex = 0) then
              Escrever(LinhaAtual, 05, 'VALOR LÍQUIDO')
            Else
              Escrever(LinhaAtual, 05, 'VALOR BRUTO');

            CorFundo('D' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual), Cinza);
            Bordas('D' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));
            Alinhamento('E' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual), Direita);
            Negrito('D' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual), True);

            ProximaLinha;
            Escrever(LinhaAtual, 04, 'BOLETO:');
            Escrever(LinhaAtual, 05, FloatToStrF(fltValBol, ffFixed, 12, 2));
            Alinhamento('E' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual), Direita);
            Bordas('D' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));

            ProximaLinha;
            Escrever(LinhaAtual, 04, 'CHEQUE:');
            Escrever(LinhaAtual, 05, FloatToStrF(fltValChq, ffFixed, 12, 2));
            Alinhamento('E' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual), Direita);
            Bordas('D' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));

            ProximaLinha;
            Escrever(LinhaAtual, 04, 'DEPÓSITO:');
            Escrever(LinhaAtual, 05, FloatToStrF(fltValDep, ffFixed, 12, 2));
            Alinhamento('E' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual), Direita);
            Bordas('D' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));

            ProximaLinha;
            Escrever(LinhaAtual, 04, 'OUTROS:');
            Escrever(LinhaAtual, 05, FloatToStrF(fltValOut, ffFixed, 12, 2));
            Alinhamento('E' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual), Direita);
            Bordas('D' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));

          End;

        End
        Else If (cbxOpcao.ItemIndex = IDX_SN_FOR) Or (cbxOpcao.ItemIndex = IDX_SN_VEN) Then
        Begin
          Escrever(LinhaAtual, 02, 'TOTAL GERAL:');
          Escrever(LinhaAtual, 03, FloatToStrF(fltTotCtpG, ffFixed, 12, 2));
          Mesclar('A' + IntToStr(LinhaAtual), 'B' + IntToStr(LinhaAtual));
          Bordas('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
          Alinhamento('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), Direita);
          Negrito('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), True);

          AutoAjuste;
          ProximaLinha;
          ProximaLinha;
          Escrever(LinhaAtual, 02, 'FORMAS DE PAGAMENTO (PREVISÃO)');

          If (rdgValorASerExibido.ItemIndex = 0) then
            Escrever(LinhaAtual, 03, 'VALOR LÍQUIDO')
          Else
            Escrever(LinhaAtual, 03, 'VALOR BRUTO');

          CorFundo('B' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), Cinza);
          Bordas('B' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
          Alinhamento('C' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), Direita);
          Negrito('B' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), True);

          ProximaLinha;
          Escrever(LinhaAtual, 02, 'BOLETO:');
          Escrever(LinhaAtual, 03, FloatToStrF(fltValBol, ffFixed, 12, 2));
          Alinhamento('C' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), Direita);
          Bordas('B' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));

          ProximaLinha;
          Escrever(LinhaAtual, 02, 'CHEQUE:');
          Escrever(LinhaAtual, 03, FloatToStrF(fltValChq, ffFixed, 12, 2));
          Alinhamento('C' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), Direita);
          Bordas('B' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));

          ProximaLinha;
          Escrever(LinhaAtual, 02, 'DEPÓSITO:');
          Escrever(LinhaAtual, 03, FloatToStrF(fltValDep, ffFixed, 12, 2));
          Alinhamento('C' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), Direita);
          Bordas('B' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));

          ProximaLinha;
          Escrever(LinhaAtual, 02, 'OUTROS:');
          Escrever(LinhaAtual, 03, FloatToStrF(fltValOut, ffFixed, 12, 2));
          Alinhamento('C' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), Direita);
          Bordas('B' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
        End

        Else
        Begin
          Escrever(LinhaAtual, 02, 'TOTAL GERAL:');
          Escrever(LinhaAtual, 03, FloatToStrF(fltTotCtpG, ffFixed, 12, 2));
          Bordas('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
          Alinhamento('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), Direita);
          Negrito('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), True);
        End;

      End;

      If chkResumoEmpresa.Checked Then
      Begin
        {***********************************}
        {* IMPRIMIE RESUMO POR EMPRESA     *}
        {********************************JB*}
        AutoAjuste;
        ProximaLinha;
        ProximaLinha;
        If (cbxOpcao.ItemIndex = IDX_AN_VEN) Or (cbxOpcao.ItemIndex = IDX_AN_FOR) Or (cbxOpcao.ItemIndex = IDX_AN_EVE) Or (cbxOpcao.ItemIndex = IDX_AN_ATI) Or (cbxOpcao.ItemIndex = IDX_AN_POR) Then
        Begin
          If fCfgSis('MODREL_TAP') = '1' Then
          Begin
            AutoAjuste;
            Escrever(LinhaAtual, 07, 'EMPRESA');

            If (rdgValorASerExibido.ItemIndex = 0) then
              Escrever(LinhaAtual, 08, 'VALOR LÍQUIDO')
            Else
              Escrever(LinhaAtual, 08, 'VALOR BRUTO');

            CorFundo('G' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), Cinza);
            Bordas('G' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual));
            Alinhamento('H' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), Direita);
            Negrito('G' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), True);

            fltTotCtpG := 0;
            ProximaLinha;

            qryRelEmp.First;
            While (Not qryRelEmp.Eof) Do
            Begin
              Escrever(LinhaAtual, 07, '''' + qryRelEmp.FieldByName('CODEMP').AsString);
              Escrever(LinhaAtual, 08, FloatToStrF(qryRelEmp.FieldByName('VALOR').asFloat, ffFixed, 12, 2));
              Alinhamento(LinhaAtual, 08, Direita);

              fltTotCtpG := fltTotCtpG + qryRelEmp.FieldByName('VALOR').asFloat;
              qryRelEmp.Next;
              ProximaLinha;
            End;

            Escrever(LinhaAtual, 07, 'TOTAL GERAL:');
            Escrever(LinhaAtual, 08, FloatToStrF(fltTotCtpG, ffFixed, 12, 2));
            Mesclar('G' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual));
            Bordas('G' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual));
            Alinhamento('G' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), Direita);
            Negrito('G' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), True);
          End
          Else
          Begin
            Escrever(LinhaAtual, 04, 'EMPRESA');

            If (rdgValorASerExibido.ItemIndex = 0) then
              Escrever(LinhaAtual, 05, 'VALOR LÍQUIDO')
            Else
              Escrever(LinhaAtual, 05, 'VALOR BRUTO');

            CorFundo('D' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual), Cinza);
            Bordas('D' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));
            Alinhamento('E' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual), Direita);
            Negrito('D' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual), True);

            fltTotCtpG := 0;
            ProximaLinha;

            qryRelEmp.First;
            While (Not qryRelEmp.Eof) Do
            Begin
              Escrever(LinhaAtual, 04, '''' + qryRelEmp.FieldByName('CODEMP').AsString);
              Escrever(LinhaAtual, 05, FloatToStrF(qryRelEmp.FieldByName('VALOR').asFloat, ffFixed, 12, 2));
              Alinhamento(LinhaAtual, 05, Direita);

              fltTotCtpG := fltTotCtpG + qryRelEmp.FieldByName('VALOR').asFloat;
              qryRelEmp.Next;
              ProximaLinha;
            End;

            Escrever(LinhaAtual, 04, 'TOTAL GERAL:');
            Escrever(LinhaAtual, 05, FloatToStrF(fltTotCtpG, ffFixed, 12, 2));
            Bordas('D' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));
            Alinhamento('D' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual), Direita);
            Negrito('D' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual), True);

          End;

        End
        Else If (cbxOpcao.ItemIndex = IDX_SN_FOR) Then
        Begin
          Escrever(LinhaAtual, 02, 'EMPRESA');

          If (rdgValorASerExibido.ItemIndex = 0) then
            Escrever(LinhaAtual, 03, 'VALOR LÍQUIDO')
          Else
            Escrever(LinhaAtual, 03, 'VALOR BRUTO');

          CorFundo('B' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), Cinza);
          Bordas('B' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
          Alinhamento('C' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), Direita);
          Negrito('B' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), True);

          fltTotCtpG := 0;
          ProximaLinha;

          qryRelEmp.First;
          While (Not qryRelEmp.Eof) Do
          Begin
            Escrever(LinhaAtual, 02, '''' + qryRelEmp.FieldByName('CODEMP').AsString);
            Escrever(LinhaAtual, 03, FloatToStrF(qryRelEmp.FieldByName('VALOR').asFloat, ffFixed, 12, 2));
            Alinhamento(LinhaAtual, 03, Direita);

            fltTotCtpG := fltTotCtpG + qryRelEmp.FieldByName('VALOR').asFloat;
            qryRelEmp.Next;
            ProximaLinha;
          End;

          Escrever(LinhaAtual, 02, 'TOTAL GERAL:');
          Escrever(LinhaAtual, 03, FloatToStrF(fltTotCtpG, ffFixed, 12, 2));
          Mesclar('B' + IntToStr(LinhaAtual), 'B' + IntToStr(LinhaAtual));
          Bordas('B' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
          Alinhamento('B' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), Direita);
          Negrito('B' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), True);

        End

        Else If (cbxOpcao.ItemIndex = IDX_SN_VEN) Then
        Begin
          Escrever(LinhaAtual, 01, 'EMPRESA');
          Mesclar('A' + IntToStr(LinhaAtual), 'B' + IntToStr(LinhaAtual));

          If (rdgValorASerExibido.ItemIndex = 0) then
            Escrever(LinhaAtual, 03, 'VALOR LÍQUIDO')
          Else
            Escrever(LinhaAtual, 03, 'VALOR BRUTO');

          CorFundo('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), Cinza);
          Bordas('C' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
          Alinhamento('C' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), Direita);
          Negrito('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), True);

          fltTotCtpG := 0;
          ProximaLinha;

          qryRelEmp.First;
          While (Not qryRelEmp.Eof) Do
          Begin
            Escrever(LinhaAtual, 01, '''' + qryRelEmp.FieldByName('CODEMP').AsString);
            Escrever(LinhaAtual, 03, FloatToStrF(qryRelEmp.FieldByName('VALOR').asFloat, ffFixed, 12, 2));
            Alinhamento(LinhaAtual, 03, Direita);

            fltTotCtpG := fltTotCtpG + qryRelEmp.FieldByName('VALOR').asFloat;
            qryRelEmp.Next;
            ProximaLinha;
          End;

          Escrever(LinhaAtual, 02, 'TOTAL GERAL:');
          Escrever(LinhaAtual, 03, FloatToStrF(fltTotCtpG, ffFixed, 12, 2));
          Bordas('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
          Alinhamento('C' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), Direita);
          Negrito('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), True);
        End;


      End;

      //CongelarPaines('A19');

      AutoAjuste;

      If fArquivoAberto Then
      Begin
        FreeAndNil(objExcel);
        Exit;
      End;

      SalvarArquivo;
      FecharArquivo;
    End;

    Screen.Cursor := crDefault;
    fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);
    FreeAndNil(objExcel);
  Finally
    begin
      Screen.Cursor := crDefault;
      FreeAndNil(objExcel);
    End;
  End;
End;

procedure TfrmRelCtpAnaDebitos.pAjustaData(DataSet : TDataSet);
Var
  strSQL   : String;
  dtaDtaVen: TDateTime;
  dtaDtaAnt: TDateTime;
  qryCadFer: TUniQuery;
Begin

  If (not chkAjuDta.Checked) Or (cbxOpcao.ItemIndex = IDX_SN_FOR) Then
    Exit;

  Try

    qryCadFer := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   FER_DTAFER ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADFER ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   FER_DTAFER = :DTAFER ';

    DataSet.Filtered := False;
    DataSet.First;

    While Not DataSet.Eof Do
    Begin

      dtaDtaVen := DataSet.Fieldbyname('CTP_DTAVEN').AsDateTime;
      dtaDtaAnt := DataSet.Fieldbyname('CTP_DTAVEN').AsDateTime;

      {*********************************************************}
      {* VERIFICA SE O VENCIMENTO EXISTE NA TABELA DE FERIADOS *}
      {******************************************************LU*}
      With qryCadFer Do
      Begin
        SQL.Clear;
        SQL.add(strSQL);
        ParamByName('DTAFER').AsDateTime := dtaDtaVen;
        Open;
      End;

      While (DayOfWeek(dtaDtaVen)= 1) Or (DayOfWeek(dtaDtaVen)= 7) Or //Se é sábado ou domingo ou
            (qryCadFer.RecordCount > 0) Do //Se é feriado
      Begin

        {***********************************************}
        {* TRIBUTOS NÃO PODEM SER PAGOS APÓS O VENCTO, *}
        {* MESMO QUE CAIA EM SAB, DOM OU FERIADO       *}
        {********************************************RN*}
        If DataSet.FieldByName('CTP_TIPDOC').AsString = '2' Then
          dtaDtaVen := dtaDtaVen - 1
        Else
          dtaDtaVen := dtaDtaVen + 1; 

        {*********************************************************}
        {* VERIFICA SE O VENCIMENTO EXISTE NA TABELA DE FERIADOS *}
        {******************************************************LU*}
        With qryCadFer Do
        Begin
          SQL.Clear;
          SQL.add(strSQL);
          ParamByName('DTAFER').AsDateTime := dtaDtaVen;
          Open;
        End;

      End;

      {************************************************}
      {* CASO TENHA SIDO NECESSARIA ALTERACAO NA DATA *}
      {*********************************************LU*}
      If dtaDtaVen <> dtaDtaAnt Then
      Begin
        DataSet.Edit;
        DataSet.FieldByName('CTP_DTAVEN').AsDateTime := dtaDtaVen;
        DataSet.Post;
      End;

      DataSet.Next;
    End;

    FreeAndNil(qryCadFer);

  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '[pAjustaData]');
    End;
  End;


End;
procedure TfrmRelCtpAnaDebitos.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelCtpAnaDebitos.cbxOpcaoChange(Sender: TObject);
begin
  inherited;
  rdgOrdemAnalitico.Enabled := cbxOpcao.ItemIndex in [IDX_AN_VEN, IDX_AN_FOR, IDX_AN_EVE, IDX_AN_ATI, IDX_AN_POR];
  rdgOrdem.Enabled          := cbxOpcao.ItemIndex = IDX_SN_FOR;
  rdgImpHistCmp.Enabled     := cbxOpcao.ItemIndex in [IDX_AN_VEN, IDX_AN_FOR, IDX_AN_EVE, IDX_AN_ATI, IDX_AN_POR];
  chkNovaPaginaQuebra.Enabled    := cbxOpcao.ItemIndex in [IDX_AN_VEN, IDX_AN_FOR, IDX_AN_EVE, IDX_AN_ATI, IDX_AN_POR];
  chkListaDesmembramento.Enabled := cbxOpcao.ItemIndex in [IDX_AN_VEN, IDX_AN_FOR, IDX_AN_EVE, IDX_AN_ATI, IDX_AN_POR];

  if Not (chkNovaPaginaQuebra.Enabled) then
    chkListaDesmembramento.Checked := False;

  If (cbxOpcao.ItemIndex = IDX_AN_FOR) Then
  Begin
    rdgOrdemAnalitico.Items.Clear;
    rdgOrdemAnalitico.Items.Add('Data Vencto.');
    rdgOrdemAnalitico.Items.Add('Duplicata');
    rdgOrdemAnalitico.ItemIndex := 0;
  End
  Else
  Begin
    rdgOrdemAnalitico.Items.Clear;
    rdgOrdemAnalitico.Items.Add('Nome Fornec.');
    rdgOrdemAnalitico.Items.Add('Cód. Fornec.');
    rdgOrdemAnalitico.Items.Add('Duplicata');
    rdgOrdemAnalitico.ItemIndex := 0;
  End;

end;

procedure TfrmRelCtpAnaDebitos.chkExiCreditosClick(Sender: TObject);
begin
  inherited;
  If chkExiCreditos.Checked Then
  Begin
    chkNExiCreditos.Checked := False;
    chkNExiCreditos.Enabled := False;
  End
  Else
    chkNExiCreditos.Enabled := True;
end;

procedure TfrmRelCtpAnaDebitos.chkNExiCreditosClick(Sender: TObject);
begin
  inherited;
  If chkNExiCreditos.Checked Then
  Begin
    chkExiCreditos.Checked := False;
    chkExiCreditos.Enabled := False;
  End
  Else
    chkExiCreditos.Enabled := True;
end;

procedure TfrmRelCtpAnaDebitos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If ActiveControl Is TComboBox Then
                 self.SelectNext(ActiveControl, True, True);
  End;

end;

end.

