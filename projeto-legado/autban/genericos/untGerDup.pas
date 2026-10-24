unit untGerDup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Mask, MaskEditFocus, Buttons,
  ExtCtrls, StrUtils, DB, Menus, AppEvnts, Uni, BitBtnLockedIncrem,
  QColorLabel, untTypesSistema, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar,DateUtils,untPesqAux, untFuncoesConsulta, untFuncoes;

type
  TfrmGerDup = class(TfrmPai)
    pnlFundo: TPanel;
    lblJuros: TLabel;
    lblPerJur: TLabel;
    lblPortador: TLabel;
    lblEmpresa: TLabel;
    lblDtaFin: TLabel;
    lblDtaIni: TLabel;
    pnlTopo: TPanel;
    mskDtaIni1: TMaskEditFocus;
    edtEmpresa: TEditFocus;
    edtJuros: TEditFocus;
    edtPortador: TEditFocus;
    mskDtaFin1: TMaskEditFocus;
    edtDesPortador: TEdit;
    edtDesEmpresa: TEdit;
    gpbFaixaCep: TGroupBox;
    Label11: TLabel;
    edtCepIni: TEditFocus;
    Label12: TLabel;
    edtCepFin: TEditFocus;
    rdgData: TRadioGroup;
    btnGerar: TBitBtnLocked;
    rdgBoletos: TRadioGroup;
    rdgLiberados: TRadioGroup;
    chkComCodBar: TCheckBox;
    chkDupDeposi: TCheckBox;
    rdgOcorrencias: TRadioGroup;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    rdgNotas: TRadioGroup;
    rdgChavesPix: TRadioGroup;
    lblCliente: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure edtPortadorKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpresaExit(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCepFinExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCepIniChange(Sender: TObject);
    procedure rdgOcorrenciasClick(Sender: TObject);
  private
    { Private declarations }
    qryDuplic: TUniQuery;
    qryCadPor : TUniQuery;
    blnRemLoc : Boolean;
    arrEmpresa: TConsultasArray;
    FblnEnvPro: Boolean;
    FDefaultJuros:String;

    qryConCli: TUniQuery;
    arrClientes : TConsultasArray;

    FBancoArquivoPix,
    FContasAPagarAPI: Boolean;

    strClientes: String;
    
    function fRetRemessaLocal: Boolean;
    function fValorJuros(strValor:String): String;

    procedure pGeraDupContasReceber;
    procedure pGeraDupContasPagar;
    procedure pCarregaCliente;

    function CarregaPortador: Boolean;
    function RetornaConfiguracaoCTA(ABanco: String): String;
    function ConsistirCarteiraConfiguradaCTA(ANomeBanco,ATipoBanco : String): boolean;
    procedure pAdicionaValorCorrigido;

  public
    { Public declarations }
    {**************************************}
    {* PASSAR O NOME DO BANCO DA SEGUITE  *}
    {* FORMA 033 - BANESPA                *}
    {***********************************AF*}
    strNomBanco: String;
    strNumPos: String;
    strTipGer  : String;
    strTipoBanco: String;
    blnMosTED   : Boolean;
    blnPGG : Boolean;

    property blnEnvPro: Boolean read FblnEnvPro write FblnEnvPro;
    property ContasAPagarAPI: Boolean read FContasAPagarAPI write FContasAPagarAPI;
  protected

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;

  end;

var
  frmGerDup: TfrmGerDup;

implementation

uses untGerDupSel,  untFuncoesSimples,
     untConsultas, untGravando;

{$R *.dfm}

function TfrmGerDup.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    blnEmpMul: Boolean;
    LEmpSemAcesso: String;
Begin
  LEmpSemAcesso := '';

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = edtEmpresa Then
    Begin

      If blnRemLoc Then
      Begin
        If fEmptyStr(edtEmpresa.Text) And (Length(arrEmpresa) = 0) Then
        Begin
          fMensagem('','Selecione uma empresa!',['&O K']);
          Result := False;
        End;

      End;

      If Result Then
      Begin
        blnEmpMul := (edtEmpresa.Text = '000') And (Length(arrEmpresa) > 0);
        If fEmptyStr(edtEmpresa.Text) Then
        Begin
          edtDesEmpresa.Text := 'TODAS';
          SetLength(arrEmpresa, 0);
        End
        Else If blnEmpMul Then
          edtDesEmpresa.Text := '+1'
        Else
        Begin
          edtEmpresa.Text := fStrZero(edtEmpresa.Text,3);
          edtDesEmpresa.Text := fRetNomeEmpresa(fStrZero(edtEmpresa.Text,3));
        End;

        If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtEmpresa.Text)) Then
        Begin
          fMensagem('','Código da empresa não encontrado.',['&O K']);
          Result := False;
        End
        Else If (Not fEmptyStr(edtEmpresa.Text)) And (Not blnEmpMul)
        And (strTipGer <> 'P') And (Pos(edtEmpresa.Text, fRetEmpAcessoCTR(strLoginUsuarioLogado)) <= 0) Then
        Begin
          fMensagem('','O usuário não possui permissão para utilizar a empresa selecionada!.',['&O K']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = mskDtaIni) or (Sender = mskDtaFin) Then
    Begin

      If(StrToDate(mskDtaIni.Text) < IncYear(VS_Date, -1)) And Not(ActiveControl.Name = btnGerar.Name) And mskDtaIni.Focused Then
      Begin
        Result := fMensagem('', 'Data inferior a ' + DateToStr(IncYear(VS_Date, -1)) + ' (1 ano). Deseja continuar?',
        ['&Sim', '&Não']) = 1;
      End;

      If(StrToDate(mskDtaFin.Text) < IncYear(VS_Date, -1)) And Not(ActiveControl.Name = btnGerar.Name) And mskDtaFin.Focused Then
      Begin
        Result := fMensagem('', 'Data inferior a ' + DateToStr(IncYear(VS_Date, -1)) + ' (1 ano). Deseja continuar?',
        ['&Sim', '&Não']) = 1;
      End;

      If (Sender = mskDtaIni) then
      begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
            fMensagem('','O período não deve ficar em branco!',['&O K'])
          Else
            fMensagem('','A data inicial deve ser preenchida!',['&O K']);
          Result := False;
        End
        Else
        If not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
           if strtodate(mskdtafin.text) < strtodate(mskdtaini.text) then
           begin
              fMensagem('','A data Final não pode ser menor que a data Inicial!',['&O K']);
              Result := False;
           end;
        End;
      End
      Else
      If (Sender = mskDtaFin) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('','A data final deve ser preenchida!',['&O K']);
          Result := False;
        End;
      End;

      {Else
      Begin
        If rdgData.ItemIndex = 1 Then
        Begin
          If (strTipGer = 'P') And (StrToDate(mskDtaIni.Text) < VS_Date) Then
          Begin
            fMensagem('','Não é possível selecionar um período com duplicatas vencidas para envio!',['&O K']);
            Result := False;
          End;
        End;
      End;}
    End

    Else
    If Sender = edtJuros Then
    Begin

      If (fEmptyStr(edtJuros.Text)) Or (fStrToFloat(edtJuros.Text) < 0) Then
      Begin
        fMensagem('','Valor dos juros deve ser maior ou igual a Zero!',['&O K']);
        Result := False;
      End;

    End

    Else If Sender = mskDtaFin Then
    Begin

      If fEmptyStr(mskDtaFin.Text) Then
      Begin
        fMensagem('','A data final deve ser preenchida',['&O K']);
        Result := False;
      End
      Else If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
      Begin
        fMensagem('','A data inicial não pode ser maior que a data final!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtCepIni) Or (Sender = edtCepFin) Then
    Begin
      If (Not fEmptyStr(edtCepIni.Text)) And (Not fEmptyStr(edtCepFin.Text)) Then
      Begin
        If StrToInt(edtCepFin.Text) < StrToInt(edtCepIni.Text) Then
        Begin
          fMensagem('','Preenchimento incorreto nas faixas de cep!',['&OK']);
          Sender := edtCepFin;
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtPortador) Then
    Begin
      If fEmptyStr(edtPortador.Text) Then
        edtDesPortador.Text := 'TODOS'
      Else
      Begin

        If (Not CarregaPortador) Then
            Result := False
        Else
        If fEmptyStr(edtDesPortador.Text) And (Not fEmptyStr(edtPortador.Text)) Then
        Begin
          fMensagem('','Código do portador não encontrado.',['&O K']);
          Result := False;
        End
        Else
        Begin

          If Length(arrEmpresa) > 0 Then
          Begin
            If Not fEmpresasTemAcessoPortador(edtPortador.Text,arrEmpresa,LEmpSemAcesso) Then
            Begin
              fMensagem('ATENÇÃO!', 'Empresa(s) sem acesso ao cadastro do Portador informado: '+ LEmpSemAcesso +'. Operação abortada!', ['&OK']);
              Result := False;
            End;
          End;

          {*REQ*145940**********RP*}
          If (Length(arrEmpresa) <= 0) And Not fEmptyStr(edtEmpresa.Text) And Not fEmpresaTemAcessoPortador(edtPortador.Text, edtEmpresa.Text) Then

          If Not fEmpresaTemAcessoPortador(edtPortador.Text, edtEmpresa.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End
          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtPortador.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&O K']);
              Result := False;
            End;
          End;
        End;
      End;
    End
    Else
    If (Sender = edtCodCliente) Then
    Begin

      pCarregaCliente;
      If fEmptyStr(edtDesCliente.Text) And (Not fEmptyStr(edtCodCliente.Text)) Then
      Begin
        fMensagem('ATENÇÃO','Cliente não cadastrado!',['&O K']);
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

End;

procedure TfrmGerDup.pAdicionaValorCorrigido;
var
  LSQL: String;
begin
  if LeftStr(strNomBanco, 3) <> '756' then Exit;
  if not fCfgSis('VALIMP', varBoolean) then Exit;

  LSQL := 'ALTER TABLE TMP_ATBREC ADD CTR_VALCOR DECIMAL(15,2) DEFAULT 0';
  qryDuplic.Close;
  qryDuplic.SQL.Text := LSQL;
  qryDuplic.ExecSQL;

  LSQL := 'UPDATE TMP_ATBREC SET CTR_VALCOR = CTR_VALDUP + ' +
          'IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0)';

  // Replica a regra do boleto Sicoob para cnab 240, o 400 não aplica o desconto de CTR_DESSUJ mesmo quando DESBOL está ativo
  if (RightStr(strNomBanco, 4) = '240p') and fCfgSis('DESBOL', varBoolean) then
    LSQL := LSQL + ' - IFNULL(CTR_DESSUJ, 0)';

  qryDuplic.SQL.Text := LSQL;
  qryDuplic.ExecSQL;
  qryDuplic.Close;
end;

procedure TfrmGerDup.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCliente.Text);

  edtDesCliente.Text := 'TODOS ';
  If Not fEmptyStr(edtCodCliente.Text) And (edtCodCliente.Text <> '00000000') Then
  Begin
     edtDesCliente.Text := qryConCli.FieldbyName('CLI_NOMCLI').AsString;
     SetLength(arrClientes, 0);
     strClientes := '';
  End
  Else
  Begin
    If (edtCodCliente.Text = '00000000') Then
        edtDesCliente.Text := '+1'
    Else
        edtDesCliente.Text := 'TODOS';
  End;
end;

procedure TfrmGerDup.FormShow(Sender: TObject);
var
   itamCli : Integer;

  function fPermiteOcorrenciadeAlteracao: Boolean;
  begin
    Result := (((Pos(LeftStr(strNomBanco, 3),'237_') > 0) And
                (Pos(RightStr(strNomBanco, 6),'Vendor') = 0)) Or // Bradesco
                (Pos(LeftStr(strNomBanco, 3),'341_033_001_089_') > 0) Or
                ( (Pos(LeftStr(strNomBanco,3),'748_') > 0) and (Pos(RightStr(strNomBanco, 4),'240p') = 0) ) ) And   // Itau/Santander/BB/Credisan
                (UpperCase(strTipGer) <> 'P')                    // Contas a Receber
  end;

  function fPermiteInclusaoBolecode: Boolean;
  begin
    Result := (Pos(LeftStr(strNomBanco, 3),'341_') > 0) And (strTipGer <> 'P');
  end;

begin
  inherited;

  If (strTipGer ='P') And Not ConsistirCarteiraConfiguradaCTA(StrNomBanco,StrTipoBanco) Then
    PostMessage(self.handle, WM_CLOSE,0,0);

  mskDtaIni.Text  := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text  := FormatDateTime('dd/mm/yyyy',VS_Date);

  blnRemLoc := fRetRemessaLocal;

  If blnRemLoc Then
  Begin
    edtEmpresa.Text    := VS_strCodEmp;
    edtDesEmpresa.Text := fRetNomeEmpresa(VS_strCodEmp);
  End;

  edtJuros.Enabled := fCfgSis('ALTTAX') <> 'N';

  // Parte do cliente;
  lblCliente.Visible    := False;
  edtCodCliente.Visible := False;
  edtDesCliente.Visible := False;
  itamCli               := edtCodCliente.height + 2;

  If (LeftStr(strNomBanco, 3) = '001') Or (LeftStr(strNomBanco, 3) = '341') Then   //BB/ITAU
  Begin
     If strTipGer <> 'P' Then
     Begin
        lblCliente.Visible    := True;
        edtCodCliente.Visible := True;
        edtDesCliente.Visible := True;
        itamCli               := 0
     End;
  End;

  If strTipGer = 'P' Then
  Begin
    chkComCodBar.Visible := True;
    chkDupDeposi.Visible := True;
    rdgBoletos.Visible   := False;
    rdgLiberados.Visible := fCfgSis('CTPLBB', varBoolean);
    edtJuros.Visible     := False;
    lblJuros.Visible     := False;
    lblPerJur.Visible    := False;
    edtJuros.Text        := FDefaultJuros;
    rdgNotas.Visible     := False;
    rdgChavesPix.Visible := True;
    rdgChavesPix.Top     := rdgNotas.Top;
    Self.Height          := Self.Height - rdgNotas.Height;

    FBancoArquivoPix := LeftStr(strNomBanco, 3).Equals('756');

    If FContasAPagarAPI Or FBancoArquivoPix Then
      rdgChavesPix.ItemIndex := 0;

    If Not rdgLiberados.Visible Then
    Begin
      lblJuros.Top       := 76;
      lblPerJur.Top      := 76;
      edtJuros.Top       := 73;
      lblPortador.Top    := 97;
      edtPortador.Top    := 94;
      edtDesPortador.Top := 94;
      lblEmpresa.Top     := 118;
      edtEmpresa.Top     := 115;
      edtDesEmpresa.Top  := 115;
      gpbFaixaCep.Top    := 138;
      chkComCodBar.Top   := 75;
      chkDupDeposi.Top   := 75;
      rdgChavesPix.Top   := rdgChavesPix.Top - rdgLiberados.Height - itamCli;
      Self.Height          := Self.Height - rdgLiberados.Height - itamCli;
    End
    Else
    Begin
      lblEmpresa.Top     := lblEmpresa.Top - itamCli;
      edtEmpresa.Top     := edtEmpresa.Top - itamCli;
      edtDesEmpresa.Top  := edtDesEmpresa.Top - itamCli;
      gpbFaixaCep.Top    := gpbFaixaCep.Top - itamCli;
      rdgChavesPix.Top   := rdgChavesPix.Top - itamCli;
      Self.Height        := Self.Height - itamCli;
    End;

  End
  Else
  Begin
    If LeftStr(strNomBanco, 3) = '003' Then
      rdgBoletos.Visible := False
    Else
      rdgBoletos.Visible := True;

    rdgBoletos.Top     := 76;
    lblJuros.Top       := 123;
    lblPerJur.Top      := 123;
    edtJuros.Top       := 120;
    lblPortador.Top    := 144;
    edtPortador.Top    := 141;
    edtDesPortador.Top := 141;
    lblCliente.Top     := 165;
    edtCodCliente.Top  := 162;
    edtDesCliente.Top  := 162;

    lblEmpresa.Top     := (183 - itamCli);
    edtEmpresa.Top     := (183 - itamCli);
    edtDesEmpresa.Top  := (183 - itamCli);
    gpbFaixaCep.Top    := (206 - itamCli);
    rdgNotas.Top       := (257 - itamCli);

    if (Pos(LeftStr(strNomBanco, 3),'996_998_707_') <= 0) then
    begin
      rdgNotas.Visible := False;
      If lblCliente.Visible Then
         Self.Height := 282 + edtCodCliente.height + 5   //282
      Else
         Self.Height := 282;
    end;

    chkComCodBar.Top   := 120;
    chkDupDeposi.Top   := 120;
  End;

  // Habilita as ocorrências para os bancos indicados
  If (Pos(LeftStr(strNomBanco, 3),'756_') > 0) And (Pos(RightStr(strNomBanco, 4),'240p') > 0) Then
  Begin
    rdgData.Width          := 280;
    rdgData.Columns        := 2;
    rdgOcorrencias.Visible := True;
    rdgOcorrencias.Enabled := True;
  End;

  If fPermiteOcorrenciadeAlteracao Then
  begin
    rdgData.Width          := 280;
    rdgData.Columns        := 2;

    rdgOcorrencias.Width   := 141;
    rdgOcorrencias.Columns := 2;
    rdgOcorrencias.Left    := 442;
    rdgOcorrencias.Items.Add('Alteração');
    rdgOcorrencias.Visible := True;
    rdgOcorrencias.Enabled := True;
  end;

  If fPermiteInclusaoBolecode Then
  begin
    mskDtaIni.Width           := 85;
    mskDtaFin.Width           := 85;

    rdgData.Left           := 153;
    rdgData.Width          := 220;
    rdgData.Columns        := 2;
    rdgData.Font.Size      := 7;

    rdgOcorrencias.Left    := 373;
    rdgOcorrencias.Width   := 208;
    rdgOcorrencias.Columns := 2;
    rdgOcorrencias.Items.Add('Inclusão Bolecode');
    rdgOcorrencias.Font.Size := 7;
    rdgOcorrencias.Visible := True;
    rdgOcorrencias.Enabled := True;
  end;

  pSetFocus(mskDtaIni);

end;

procedure TfrmGerDup.edtPortadorKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples,
                     Self,
                     edtPortador,
                     TEditFocus(edtDesPortador),
                     nil,
                     Key,
                     arrSel,
                     True,
                     'Consulta de Portadores',
                     '',
                     False,
                     False,
                     edtEmpresa.Text,
                     False,
                     (strTipGer <> 'P')) then // TRUE
    Begin
      If fValidaCampos(edtPortador) Then
        SelectNext((Sender As TWinControl), True, True);
    End;
  End;
end;

procedure TfrmGerDup.edtEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtEmpresa, Nil, Nil, Key, arrEmpresa, False, False,  IIF(strTipGer <> 'P', fRetEmpAcessoCTR(strLoginUsuarioLogado), '')) Then
  Begin
    If fValidaCampos(edtEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmGerDup.CarregaPortador: Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := True;

  edtDesPortador.Text := 'TODOS';

  If fEmptyStr(edtPortador.Text) Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT POR_CODPOR, POR_NOMPOR, POR_PERAUT FROM CADPOR ' +
                          'WHERE POR_CODPOR="' + edtPortador.Text + '"';
    LConsulta.Open;

    edtDesPortador.Text := LConsulta.FieldByName('POR_NOMPOR').AsString;

    If Not LConsulta.FieldByName('POR_NOMPOR').AsString.IsEmpty Then
    Begin
      If (LConsulta.FieldByName('POR_PERAUT').AsString = 'N') And (strTipGer <> 'P') Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'Esse portador não pode ser selecionado na geração de duplicatas no Autban!', ['&Ok']);
      End;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TfrmGerDup.ConsistirCarteiraConfiguradaCTA(ANomeBanco,ATipoBanco: String): boolean;
  var
    LBanco,
    LConfiguracao,
    LSql,
    LChave : String;

    LContador,
    LQuantidadeCarteiras : Integer;

    LConsulta: TUniQuery;
begin
  Result := true;
  LQuantidadeCarteiras := 5;
  LBanco := ANomeBanco;

  If Not fEmptyStr(ATipoBanco) Then
    LBanco := LBanco + ' - ' +  ATipoBanco;

  LConfiguracao := RetornaConfiguracaoCTA(LBanco);

  If Not fEmptyStr(LConfiguracao) Then
  Begin
    For LContador := 1 To LQuantidadeCarteiras Do
    Begin
      LChave := LChave + QuotedStr(LConfiguracao + '-'+ IntToStr(LContador) + '-' + VS_strCodEmp) +',';
    End;

    LChave := Copy(LChave,1,Length(LChave) - 1);

    LSql := 'SELECT SIS_CODCFG FROM CFGBAN WHERE SIS_CODCFG = ''NUMCTAC''' +
            ' AND SIS_VALCFG <> ''''' +
            ' AND SIS_CHAVE_ IN (' + LChave + ')';
    Try
      LConsulta := fCriaQuery;
      LConsulta.SQL.Add(LSql);
      LConsulta.Open;

      If LConsulta.RecordCount < 1 Then
      Begin
        Result := false;
        fMensagem('ATENÇÃO','Não é possível utilizar a rotina '+ #13 + 'Banco não possui carteira configurada!',['&O K']);
      End;

    Finally
      FreeAndNil(LConsulta);
    End;
  End;
end;

procedure TfrmGerDup.edtCepFinExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCepFin.Text)) And (Not fEmptyStr(edtCepIni.Text)) Then
  Begin
    fMensagem('','Preenchimento incorreto nas faixas de cep!',['&OK']);
    pSetFocus(edtCepFin);
  End;
end;

procedure TfrmGerDup.edtCepIniChange(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtCepIni.Text) Then
  Begin
    edtCepFin.Enabled := True;
  End
  Else
  Begin
    edtCepFin.Clear;
    edtCepFin.Enabled := False;
  End;
end;

procedure TfrmGerDup.edtCodClienteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, nil, Key, arrClientes, False)  then
  Begin
    If (fValidaCampos(edtCodCliente, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGerDup.edtEmpresaExit(Sender: TObject);
begin
  fValidaCampos(edtEmpresa);

  inherited;
end;

procedure TfrmGerDup.btnGerarClick(Sender: TObject);
begin
  inherited;

  if not fValidaCampos(mskDtaIni) then
    Exit;
  if not fValidaCampos(mskDtaFin) then
    Exit;

  If Not fVerificaCampos Then
    Exit;

  pnlInfo.Caption := 'Gerando Duplicatas...';
  Application.ProcessMessages;

  fDropTable('TMP_ATBREC');
  fDropTable('TMP_ATBPAG');

  If strTipGer = 'P' Then
    TfrmGravando.fExecutarModal(pGeraDupContasPagar, 'Aguarde... Gerando Duplicatas...','')
  Else
    TfrmGravando.fExecutarModal(pGeraDupContasReceber, 'Aguarde... Gerando Duplicatas...','');

  pnlInfo.Caption := '';
end;

function TfrmGerDup.fRetRemessaLocal: Boolean;
begin

  Result := False;

  If strNomBanco = '033 - Banespa' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG033', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG033', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG033', 'JUROSDI', '')));
  End

  Else If strNomBanco = '237 - Bradesco' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG237', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG237', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG237', 'JUROSDI', '')));
  End

  Else If strNomBanco = '983 - Banco Multibank' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG983', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG983', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG983', 'JUROSDI', '')));
  End

  Else If strNomBanco = '237 - Bradesco' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG237', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG237', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG237', 'JUROSDI', '')));
  End

  Else If strNomBanco = '237 - Bradesco_240p_Vendor' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG237_VENDOR', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG237_VENDOR', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG237_VENDOR', 'JUROSDI', '')));
  End

  Else If strNomBanco = '422 - Safra' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG422', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG422', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG422', 'JUROSDI', '')));
  End

  Else If strNomBanco = '021 - Banestes' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG021', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG021', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG021', 'JUROSDI', '')));
  End
  
  Else If strNomBanco = '001 - Brasil' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG001', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG001', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG001', 'JUROSDI', '')));
  End

  Else If strNomBanco = '001 - Brasil7d' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG001D7', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG001D7', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG001D7', 'JUROSDI', '')));
  End

  Else If strNomBanco = '104 - Caixa Federal' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG104', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG104', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG104', 'JUROSDI', '')));
  End

  Else If strNomBanco = '085 - Cecred' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG085', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG085', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG085', 'JUROSDI', '')));
  End

  Else If strNomBanco = '104 - Caixa Federal.400p' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG104p400', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG104p400', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG104p400', 'JUROSDI', '')));
  End

  Else If strNomBanco = '399 - HSBC' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG399', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG399', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG399', 'JUROSDI', '')));
  End

  Else If (strNomBanco = '341 - Itaú') And (strTipGer <> 'P') Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG341', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG341', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG341', 'JUROSDI', '')));
  End

  Else If (strNomBanco = '341 - Itaú') And (strTipGer = 'P') Then
  Begin
    Result := fGetBancoConfig(0,'CONFIGCTA341', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIGCTA341', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIGCTA341', 'JUROSDI', '')));
  End

  Else If (strNomBanco = '021 - Banestes') And (strTipGer = 'P') Then
  Begin
    Result := fGetBancoConfig(0,'CONFIGCTA021', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIGCTA021', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIGCTA021', 'JUROSDI', '')));
  End

  Else If strNomBanco = '356 - Real' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG356', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG356', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG356', 'JUROSDI', '')));
  End

  Else If strNomBanco = '389 - Banco Mercantil' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG389', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG389', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG389', 'JUROSDI', '')));
  End

  Else If strNomBanco = '151 - N.C.N.B.' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG151', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG151', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG151', 'JUROSDI', '')));
  End

  Else If strNomBanco = '409 - Unibanco' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG409', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG409', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG409', 'JUROSDI', '')));
  End

  Else If strNomBanco = '741 - Banco Rib Preto' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG741', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG741', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG741', 'JUROSDI', '')));
  End

  Else If strNomBanco = '748 - Sicredi' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG748', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG748', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG748', 'JUROSDI', '')));
  End

  Else If strNomBanco = '353 - Santander' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG353', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG353', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG353', 'JUROSDI', '')));
  End

  Else If strNomBanco = '033 - Santander' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG033B', 'RELOCAL', '') = 'S';
    If strTipGer = 'P' Then
      edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIGCTA033', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG033', 'JUROSDI', '')))
    Else
      edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG033B', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG033B', 'JUROSDI', '')));
  End

  Else If strNomBanco = '041 - Banrisul' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG041', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG041', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG041', 'JUROSDI', '')));
  End

  Else If (strNomBanco = '041 - Banrisul') And (strTipGer = 'P') Then
  Begin
    Result := fGetBancoConfig(0,'CONFIGCTA041', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIGCTA041', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIGCTA041', 'JUROSDI', '')));
  End

  Else If strNomBanco = '041 - Banrisul [240p]' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG041_240p', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG041_240p', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG041_240p', 'JUROSDI', '')));
  End

  Else If strNomBanco = '004 - B. do Nordeste' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG004', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG004', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG004', 'JUROSDI', '')));
  End

  Else If strNomBanco = '756 - Bancoob' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG756', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG756', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG756', 'JUROSDI', '')));
  End

  Else If strNomBanco = '756 - Bancoob_240p' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG756_240p', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG756_240p', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG756_240p', 'JUROSDI', '')));
  End

  Else If strNomBanco = '637 - Sofisa' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG637', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG637', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG637', 'JUROSDI', '')));
  End

  Else If strNomBanco = '637 - Sofisa [444p]' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG637_444p', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG637_444p', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG637_444p', 'JUROSDI', '')));
  End

  Else If strNomBanco = '993 - Redasset' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG993', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG993', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG993', 'JUROSDI', '')));
  End

  Else If strNomBanco = '992 - Credit Brasil' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG992', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG992', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG992', 'JUROSDI', '')));
  End

  Else If strNomBanco = '991 - Banco Serrana' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG991', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG991', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG991', 'JUROSDI', '')));
  End

  Else If strNomBanco = '989 - Banco Data Venia' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG989', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG989', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG989', 'JUROSDI', '')));
  End

  Else If strNomBanco = '997 - Garson Crédito' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG997', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG997', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG997', 'JUROSDI', '')));
  End

  Else If strNomBanco = '998 - Sifra' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG998', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG998', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG998', 'JUROSDI', '')));
  End

  Else If strNomBanco = '003 - Banco da Amazonia' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG003', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG003', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG003', 'JUROSDI', '')));
  End

  Else If strNomBanco = '090 - Unicred' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG090', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG090', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG090', 'JUROSDI', '')));
  End

  Else If strNomBanco = '090 - Unicred (400p)' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG090_400p', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG090_400p', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG090_400p', 'JUROSDI', '')));
  End

  Else If strNomBanco = '136 - Unicred [400p]' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG136_400p', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG136_400p', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG136_400p', 'JUROSDI', '')));
  End

  Else If strNomBanco = '070 - BRB 400p' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG070p400', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG070p400', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG070p400', 'JUROSDI', '')));
  End

  Else If strNomBanco = '756 - Bancoob' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG756CTA', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG756CTA', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG756CTA', 'JUROSDI', '')));
  End

  Else If strNomBanco = '099 - Uniprime' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG099', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG099', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG099', 'JUROSDI', '')));
  End

  Else If strNomBanco = '084 - Sisprime' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG084', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG084', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG084', 'JUROSDI', '')));
  End

  Else If strNomBanco = '977 - Lake Bank' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG977', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG977', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG977', 'JUROSDI', '')));
  End

  Else If strNomBanco = '976 - Lotus' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG976', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG976', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG976', 'JUROSDI', '')));
  End

  Else If strNomBanco = '975 - JP Capital' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG975', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG975', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG975', 'JUROSDI', '')));
  End

  Else If strNomBanco = '974 - Olam' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG974', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG974', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG974', 'JUROSDI', '')));
  End

  Else If strNomBanco = '973 - Bela Vista' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG973', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG973', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG973', 'JUROSDI', '')));
  End

  Else If strNomBanco = '089 - Credisan' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG089', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG089', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG089', 'JUROSDI', '')));
  End

  Else If strNomBanco = '707 - Daycoval[400p]' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG707', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG707', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG707', 'JUROSDI', '')));
  End

  Else If strNomBanco = '246 - ABC Brasil' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG246', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG246', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG246', 'JUROSDI', '')));
  End

  Else If (strNomBanco = '246 - ABC Brasil') And (strTipGer = 'P') Then
  Begin
    Result := fGetBancoConfig(0,'CONFIGCTA246', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIGCTA246', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIGCTA246', 'JUROSDI', '')));
  End

  Else If strNomBanco = '988 - SB Credito[400p]' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG988', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG988', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG988', 'JUROSDI', '')));
  End

  Else If strNomBanco = '987 - SB Credito Bradesco[400p]' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG987', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG987', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG987', 'JUROSDI', '')));
  End

  Else If strNomBanco = '982 - Sparti' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG982', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG982', 'JUROSDI', '') = '','0,00',fGetBancoConfig(0,'CONFIG982', 'JUROSDI', '')));
  End

  Else If strNomBanco = '984 - Banco Lecca[400p]' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG984', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG984', 'JUROSDI', '') = '','0,00',fGetBancoConfig(0,'CONFIG984', 'JUROSDI', '')));
  End

  Else If strNomBanco = '906 - Banco FIDC' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG906', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG906', 'JUROSDI', '') = '','0,00',fGetBancoConfig(0,'CONFIG906', 'JUROSDI', '')));
  End

  Else If strNomBanco = '637 - Sofisa LP [444p]' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG637LP444p', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG637LP444p', 'JUROSDI', '') = '','0,00',fGetBancoConfig(0,'CONFIG637LP444p', 'JUROSDI', '')));
  End

  Else If strNomBanco = '274 - BMP Money Plus LP [400p]' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG274LP400p', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG274LP400p', 'JUROSDI', '') = '','0,00',fGetBancoConfig(0,'CONFIG274LP400p', 'JUROSDI', '')));
  End

  Else If strNomBanco = '964 - Financeira Formula (Itau) [400p]' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG964', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG964', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG964', 'JUROSDI', '')));
  End

  Else If strNomBanco = '962 - Banco CredVale (Bradesco) [400p]' Then
  Begin
    Result := fGetBancoConfig(0,'CONFIG962', 'RELOCAL', '') = 'S';
    edtJuros.Text := fValorJuros(IIF(fGetBancoConfig(0,'CONFIG962', 'JUROSDI', '') = '',FDefaultJuros,fGetBancoConfig(0,'CONFIG962', 'JUROSDI', '')));
  End;

end;

function TfrmGerDup.fValorJuros(strValor:String): String;
begin

  Result := '0,' + fStrZero('0',fCfgSis('CSDMOR', VarInteger));

  If (fStrToFloat(strValor) > 0) Then
    Result := FormatFloat('###,##0.' + fStrZero('0',fCfgSis('CSDMOR', VarInteger)),(fStrToFloat(strValor) / 30));

end;

procedure TfrmGerDup.pGeraDupContasReceber;
  Var
    strSQL  : String;
    strAux  : String;
    strAgreg: String;
    strDtaFiltro : String;
    strEmpAce: String;
    recItem : TConsultas;
    TotalDuplicatas: Double;
begin
  TotalDuplicatas := 0;
  strSQL   := '';
  strAux   := '';
  strAgreg := '';

  Case rdgData.ItemIndex Of
    0: strDtaFiltro := 'CTR_DTACAD';
    1: strDtaFiltro := 'CTR_DTAVEN';
    2: strDtaFiltro := 'CTR_DTABAI';
  End;

  strAgreg := strAgreg + '( SELECT     ';
  strAgreg := strAgreg + '    COUNT(*) ';
  strAgreg := strAgreg + '  FROM       ';
  strAgreg := strAgreg + '    TABINT R ';
  strAgreg := strAgreg + '  WHERE      ';
  strAgreg := strAgreg + '    R.CTR_CODCLI = CLI_CODCLI ';
  strAgreg := strAgreg + '    AND R.CTR_VALDUP < 0      ';

  If Not fEmptyStr(fCfgSis('POOCRE')) Then
    strAgreg := strAgreg + 'AND IFNULL(R.CTR_CODPOR,"") <> ' + String(fCfgSis('POOCRE')).QuotedString;

  strAgreg := strAgreg + '    AND R.CTR_DTAREC IS NULL )';

  strAgreg := ' ( ' + strAgreg + '  ) AS CTR_CREDIT ';

  strAux := strAux + 'CREATE TEMPORARY TABLE TMP_ATBREC ';

  strSQL := strSQL + '(SELECT ';
  strSQL := strSQL + '  CONCAT(CTR_NUMDUP,CTR_PARCEL) AS CTR_NUMDUP, ';
  strSQL := strSQL + '  CTR_NUMDUP AS NUMDUP, ';
  strSQL := strSQL + '  CADREC.AUTOINCREM AS AUTOINCREM, ';
  strSQL := strSQL + '  CTR_PARCEL, ';
  strSQL := strSQL + '  CTR_SEQBAI, ';
  strSQL := strSQL + '  CTR_CODVEN, ';
  strSQL := strSQL + '  CTR_ESPDOC, ';
  strSQL := strSQL + '  CTR_CODDIG, ';
  strSQL := strSQL + '  CTR_PORBAI, ';
  strSQL := strSQL + '  CTR_CTABAI, ';
  strSQL := strSQL + '  CTR_OPEBAI, ';
  strSQL := strSQL + '  CTR_DOCBAI, ';
  strSQL := strSQL + '  CTR_DTABAI, ';
  strSQL := strSQL + '  CTR_ADTCLI, ';
  strSQL := strSQL + '  CTR_CODEVE, ';
  strSQL := strSQL + '  SUM(CTR_VALREC) AS CTR_VALREC, ';
  strSQL := strSQL + '  CTR_DTAREC, ';
  strSQL := strSQL + '  CTR_RESCAI, ';
  strSQL := strSQL + '  SUM(CTR_VALDES) AS CTR_VALDES, ';
  strSQL := strSQL + '  SUM(CTR_VALJUR) AS CTR_VALJUR, ';
  strSQL := strSQL + '  CTR_SEQMOD, ';
  strSQL := strSQL + '  CTR_TIPFOR, ';
  strSQL := strSQL + '  CTR_CODCND, ';
  strSQL := strSQL + '  CTR_CONAPR, ';
  strSQL := strSQL + '  CTR_CODCTA, ';
  strSQL := strSQL + '  CTR_SEQCON, ';
  strSQL := strSQL + '  CURRENT_TIMESTAMP AS HRAFIL, ';

  strSQL := strSQL + '  SUM(CTR_CHQPRE) AS CTR_CHQPRE , ';
  strSQL := strSQL + '  SUM(CTR_CHQAVI) AS CTR_CHQAVI, ';
  strSQL := strSQL + '  SUM(CTR_DINHEI) AS CTR_DINHEI, ';
  strSQL := strSQL + '  SUM(CTR_CARTAO) AS CTR_CARTAO, ';
  strSQL := strSQL + '  SUM(CTR_ORDPAG) AS CTR_ORDPAG, ';
  strSQL := strSQL + '  SUM(CTR_VALFIN) AS CTR_VALFIN, ';

  strSQL := strSQL + '  CTR_DTAVEN, ';
  strSQL := strSQL + '  CTR_DTACAD, ';

  If (rdgOcorrencias.ItemIndex=0) or (rdgOcorrencias.ItemIndex=2) or (rdgOcorrencias.ItemIndex=3) Then
    strSQL := strSQL + '  SUM(CTR_VALDUP) AS CTR_VALDUP, '
  Else
    strSQL := strSQL + '  CTR_GRVORI AS CTR_VALDUP, ';

  strSQL := strSQL + '  SUM(CTR_VALORI) AS CTR_VALORI, ';
  strSQL := strSQL + '  SUM(CTR_DESCOB) AS CTR_DESCOB, ';
  strSQL := strSQL + '  SUM(CTR_DESCON) AS CTR_DESCON, ';
  strSQL := strSQL + '  CTR_CODEMP, ';
  strSQL := strSQL + '  CTR_CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI, ';
  strSQL := strSQL + '  CLI_FANSOB, ';

  strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CONCAT(CLI_ENDERE," ", IFNULL(CLI_ENDNUM,"")), CLI_ENDCOB) AS CLI_ENDCOB, ';
  strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CLI_BAIRRO, CLI_BAICOB) AS CLI_BAICOB, ';
  strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, D1.CID_NOMCID, D2.CID_NOMCID) AS CLI_NOMCID, ';
  strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, D1.CID_ESTADO, D2.CID_ESTADO) AS CLI_ESTADO, ';
  strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CLI_C_E_P_, CLI_CEPCOB) AS CLI_CEPCOB, ';

  strSQL := strSQL + '  CTR_CODPOR, ';
  strSQL := strSQL + '  POR_NOMPOR, ';
  strSQL := strSQL + '  CTR_NOSNUM, ';
  strSQL := strSQL + '  CTR_HIST01, ';
  strSQL := strSQL + '  CTR_HIST02, ';
  strSQL := strSQL + '  CTR_HISBAI, ';
  strSQL := strSQL + '  CTR_OBSAG1, ';
  strSQL := strSQL + '  CTR_OBSAG2, ';
  strSQL := strSQL + '  CTR_OBSAG3, ';
  strSQL := strSQL + '  CTR_CODVEL, ';
  strSQL := strSQL + '  SUM(CTR_DESSUJ) AS CTR_DESSUJ, ';
  strSQL := strSQL + '  SUM(CTR_JURSUJ) AS CTR_JURSUJ, ';
  strSQL := strSQL + '  CTR_BCOCRR, ';
  strSQL := strSQL + '  CTR_NN_CRR, ';
  strSQL := strSQL + '  CTR_CARTEI, ';
  strSQL := strSQL + '  CTR_TX_PIX, ';
  strSQL := strSQL + '  TRIM(CADCLI.CLI_C_G_C_) AS CLI_C_G_C_, ';
  strSQL := strSQL + '  CASE WHEN CLI_PROPER = "S" THEN "Sim" ELSE "Não" END AS CLI_PROPER, ';
  strSQL := strSQL + ' ' + strAgreg + ' ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCLI  ';
  strSQL := strSQL + '  JOIN CADREC ON CTR_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADCID D1 ON CLI_CODCID = D1.CID_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CADCID D2 ON CLI_CIDCOB = D2.CID_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CADPOR ON CTR_CODPOR = POR_CODPOR ';
  strSQL := strSQL + '  LEFT JOIN CADCBI ';
  strSQL := strSQL + '    ON CBI_NUMDUP = CTR_NUMDUP AND ';
  strSQL := strSQL + '       CBI_PARCEL = CTR_PARCEL AND ';
  strSQL := strSQL + '       CBI_ESPDOC = CTR_ESPDOC AND ';
  strSQL := strSQL + '       CBI_CODCLI = CTR_CODCLI AND ';
  strSQL := strSQL + '       CBI_CODEMP = CTR_CODEMP ';


  If (rdgOcorrencias.ItemIndex=1) or (rdgOcorrencias.ItemIndex=2) Then
  Begin
    strSQL := strSQL + '  LEFT JOIN REMDET ';
    strSQL := strSQL + '    ON DET_DUPLIC = CADREC.AUTOINCREM AND ';
    strSQL := strSQL + '       DET_DTAREC IS NOT NULL             ';
  End;

  If rdgNotas.Visible Then
  Begin
    strSQL := strSQL + '  LEFT JOIN LOGNFE L ';
    strSQL := strSQL + '    ON NFE_NUMDOC = CTR_NUMDUP AND  ';
    strSQL := strSQL + '       NFE_ESPDOC = CTR_ESPDOC AND  ';
    strSQL := strSQL + '       NFE_CODEMP = CTR_CODEMP  AND ';
    strSQL := strSQL + '       NFE_CODCLI = CTR_CODCLI ';
  End;

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  '+strDtaFiltro+' BETWEEN :DTAINI AND :DTAFIN AND ';
  strSQL := strSQL + '  CBI_NUMDUP IS NULL AND ';


  If FblnEnvPro Then
    strSQL := strSQL + '  CTR_DTAVEN < CURRENT_DATE AND COALESCE(CTR_DTAPRO, "") = "" AND ';

  If (rdgOcorrencias.ItemIndex=1) Then
  Begin
    strSQL := strSQL + '  CTR_DTAENV IS NOT NULL AND ';
    strSQL := strSQL + '  CTR_BCOBOL = :BCOBOL AND ';
    strSQL := strSQL + '  COALESCE(DET_TIPREM, 0) <> 1 AND ';
    strSQL := strSQL + '  ((CTR_BAIMAN = "S") OR (CTR_RECPIX = "S")) AND ';
    strSQL := strSQL + '  DET_DUPLIC IS NULL     ';
  End
  Else if (rdgOcorrencias.ItemIndex=2) then
  Begin
    strSQL := strSQL + '  CTR_DTAREC IS NULL AND ';
    strSQL := strSQL + '  CTR_DTAENV IS NOT NULL AND ';
    strSQL := strSQL + '  COALESCE(DET_TIPREM, 0) <> 1 AND ';
    strSQL := strSQL + '  CTR_BCOBOL = :BCOBOL  ';
  End
  Else
  Begin
    strSQL := strSQL + '  CTR_DTAREC IS NULL AND ';

    If (Not FblnEnvPro) Then
      strSQL := strSQL + '  CTR_DTAENV IS NULL AND '
    Else
      strSQL := strSQL + '  CTR_DTAVEN < CURRENT_DATE AND COALESCE(CTR_DTAPRO, "") = "" AND ';

    strSQL := strSQL + '  CTR_VALDUP > 0 ';
  End;

  If (Not fEmptyStr(edtEmpresa.Text)) And (edtEmpresa.Text <> '000') Then
    strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP '
  Else
  Begin
    If Length(arrEmpresa) > 0 Then
    Begin
      strEmpAce := '';
      For recItem in arrEmpresa Do
        strEmpAce := strEmpAce + recItem.strCodigo + '_';
      strSQL := strSQL + '  AND LOCATE(CTR_CODEMP, ' + QuotedStr(strEmpAce) + ') > 0 ';
    End
    Else
      strSQL := strSQL + '  AND LOCATE(CTR_CODEMP, ' + QuotedStr(fRetEmpAcessoCTR(strLoginUsuarioLogado)) + ') > 0 ';
  End;

  If Not fEmptyStr(edtPortador.Text) Then
    strSQL := strSQL + '  AND CTR_CODPOR = :CODPOR '
  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + ' AND (IFNULL(CTR_CODPOR, "") = "" ';
    strSQL := strSQL + ' OR LOCATE(CTR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;

  If Not fEmptyStr(edtCodCliente.Text) Then
     strSQL := strSQL + fStrLocate(edtCodCliente, arrClientes, 'CTR_CODCLI', 'CODCLI');

  If (Not fEmptyStr(edtCepIni.Text)) And (Not fEmptyStr(edtCepFin.Text)) Then
    strSQL := strSQL + '  AND IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CLI_C_E_P_, CLI_CEPCOB) BETWEEN :CEPINI AND :CEPFIN ';

  If LeftStr(strNomBanco, 3) <> '003' Then
  Begin
    If rdgBoletos.ItemIndex = 0 Then
    Begin
      strSQL := strSQL + '  AND IFNULL(CTR_NOSNUM, "") <> "" ';
      strSQL := strSQL + '  AND CTR_BCOBOL = :BCOBOL ';
    End
    Else If rdgBoletos.ItemIndex = 1 Then
      strSQL := strSQL + '  AND IFNULL(CTR_NOSNUM, "") = "" '
    Else
      strSQL := strSQL + '  AND ((IFNULL(CTR_NOSNUM, "") = "") OR  (IFNULL(CTR_NOSNUM, "") <> "" AND CTR_BCOBOL = :BCOBOL ))';
  End
  Else
    strSQL := strSQL + '  AND IFNULL(CTR_NOSNUM, "") = "" ';

  If rdgNotas.Visible Then
  begin
    If rdgNotas.ItemIndex = 1 Then
      strSQL := strSQL + '  AND NFE_ACESSO IS NOT NULL '
    Else If rdgNotas.ItemIndex = 2 Then
      strSQL := strSQL + '  AND NFE_ACESSO IS NULL ';
  end;

  strSQL := strSQL + ' AND (CADPOR.POR_PERAUT IS NULL OR CADPOR.POR_PERAUT<>"N") ';

  strSQL := strSQL + ' GROUP BY CTR_NUMDUP, CTR_PARCEL, CTR_ESPDOC, CTR_CODEMP, CTR_CODCLI, CTR_SEQCON, CTR_EMPBAI, CTR_DTABAI ' ;

  strSQL := strSQL + '  ORDER BY ' + strDtaFiltro + ')';

  strSQL := strAux + strSQL;

  strSQL := AnsiReplaceStr(strSQL,'TABINT','CADREC');

  With qryDuplic Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

    If (Not fEmptyStr(edtEmpresa.Text)) And (edtEmpresa.Text <> '000') Then
      ParamByName('CODEMP').AsString := edtEmpresa.Text;

    If Not fEmptyStr(edtPortador.Text) Then
      ParamByName('CODPOR').AsString := edtPortador.Text;

    If Not fEmptyStr(edtCodCliente.Text) Then
       pSetaParam(edtCodCliente.Text, arrClientes, strClientes, 'CODCLI', qryDuplic);

    If (Not fEmptyStr(edtCepIni.Text)) And (Not fEmptyStr(edtCepFin.Text)) Then
    Begin
      ParamByName('CEPINI').AsString := edtCepIni.Text;
      ParamByName('CEPFIN').AsString := edtCepFin.Text;
    End;

    If ((rdgBoletos.ItemIndex = 0) Or (rdgBoletos.ItemIndex = 2) Or (rdgOcorrencias.ItemIndex=1) or (rdgOcorrencias.ItemIndex=2)) And (LeftStr(strNomBanco, 3) <> '003') Then
    begin
      If strNomBanco = 'IEPTB-SP' then
        ParamByName('BCOBOL').AsString := '341'
      else
        ParamByName('BCOBOL').AsString := LeftStr(strNomBanco, 3);
    end;

    ExecSQL;

    strSQL := '';
    strSQL := strSQL + 'ALTER TABLE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'ADD ';
    strSQL := strSQL + '  CTR_MARCAD VARCHAR(1) ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

    strSQL := '';
    strSQL := strSQL + 'ALTER TABLE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'ADD ';
    strSQL := strSQL + '  CTR_PROTES VARCHAR(1) ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

    strSQL := '';
    strSQL := strSQL + 'ALTER TABLE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'ADD ';
    strSQL := strSQL + '  CTR_PRZPRO INT ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

    strSQL := '';
    strSQL := strSQL + 'ALTER TABLE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'ADD ';
    strSQL := strSQL + '  CTR_CODCAR INT ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  CTR_PROTES = "N" ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

    strSQL := '';
    strSQL := strSQL + 'ALTER TABLE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'ADD ';
    strSQL := strSQL + '  DEPOSI VARCHAR(12) ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

    strSQL := '';
    strSQL := strSQL + 'ALTER TABLE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'ADD ';
    strSQL := strSQL + '  CODTED VARCHAR(100) ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

    strSQL := '';
    strSQL := strSQL + 'ALTER TABLE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'ADD ';
    strSQL := strSQL + '  CTR_OCORRE VARCHAR(50) ' +
                       IIF((rdgOcorrencias.ItemIndex=1) And (MatchStr(LeftStr(strNomBanco, 3), ['756', '237', '001', '033', '341', '748']) ),
                           ' DEFAULT "02 - Solicitação de Baixa"',
                           '');


    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

    pAdicionaValorCorrigido;

    SQL.Clear;
    SQL.Add('SELECT * FROM TMP_ATBREC ORDER BY CTR_DTAVEN');
    Open;

    If Not IsEmpty Then
    Begin
      Try
        First;
        While Not Eof Do
        Begin
          TotalDuplicatas := TotalDuplicatas + FieldByName('CTR_VALDUP').AsFloat;
          Next;
        End;

        pCriarFormularios(TfrmGerDupSel,frmGerDupSel);

        frmGerDupSel.qryDuplic := qryDuplic;

        frmGerDupSel.Caption := 'AutBan';

        frmGerDupSel.pnlTopo.Caption  := 'Geração de Duplicatas - ' + strNomBanco;
        frmGerDupSel.strLog           := 'GERAÇÃO DE DUPLICATAS';
        frmGerDupSel.strCodBco        := LeftStr(strNomBanco,3);
        frmGerDupSel.strJuros         := edtJuros.Text;
        frmGerDupSel.blnEnvPro        := FblnEnvPro;
        frmGerDupSel.blnOcorrencias   := IIF(rdgOcorrencias.Enabled,rdgOcorrencias.ItemIndex=1,False);
        frmGerDupSel.edtTotalDup.Text := FloatToStrF(TotalDuplicatas,ffNumber,15,2);
        frmGerDupSel.BOLECODE         := IIF(rdgOcorrencias.Enabled,rdgOcorrencias.ItemIndex=3,False);
        frmGerDupSel.TipoRemessa      := rdgOcorrencias.ItemIndex;

        if (not frmGerDupSel.blnOcorrencias) then
        begin
          frmGerDupSel.blnOcorrencias         := IIF(rdgOcorrencias.Enabled,rdgOcorrencias.ItemIndex=2,False);
          frmGerDupSel.blnOcorrenciaAlteracao := frmGerDupSel.blnOcorrencias;
        end;

        frmGerDupSel.lblMensagem.Caption := '';
        If rdgNotas.Visible Then
        Begin
          If rdgNotas.ItemIndex = 1 Then
            frmGerDupSel.lblMensagem.Caption := '* Somente duplicatas com chave (NF-e) '
          Else If rdgNotas.ItemIndex = 2 Then
            frmGerDupSel.lblMensagem.Caption := '* Somente duplicatas sem chave (NF-e) ';
        End;

    		{***************************************}
	  	  {* VARIÁVEIS UTILIZADAS NA VERIFICAÇÃO *}
		    {* DAS CARTEIRAS PARA SELEÇÃO          *}
    		{************************************JU*}
        If (LeftStr(strNomBanco, 3) = '001') And
           (RightStr(strNomBanco, 2) <> '7d') Then
          frmGerDupSel.blnBB6d := True
        Else
        If (LeftStr(strNomBanco, 3) = '001') And
           (RightStr(strNomBanco, 2) = '7d') Then
          frmGerDupSel.strCodBco := LeftStr(strNomBanco,3) + 'D7'
        Else

        If (LeftStr(strNomBanco, 3) = '104') And
             (RightStr(strNomBanco, 4) = '[7D]') Then
             frmGerDupSel.strCodBco := LeftStr(strNomBanco,3) + '7D'
        Else

        If (LeftStr(strNomBanco, 3) = '748') Then
        Begin
          If  (RightStr(strNomBanco, 4) = '240p') Then
            frmGerDupSel.strCodBco := LeftStr(strNomBanco,3) + '_240p'
          Else
            frmGerDupSel.strCodBco := LeftStr(strNomBanco,3) + '-'
        End
        Else

        If (LeftStr(strNomBanco, 3) = '756') Then
        Begin
          If  (RightStr(strNomBanco, 4) = '240p') Then
            frmGerDupSel.strCodBco := LeftStr(strNomBanco,3) + '_240p'
          Else
            frmGerDupSel.strCodBco := LeftStr(strNomBanco,3) + '-'
        End
        Else

        If (LeftStr(strNomBanco, 3) = '090') Then
        Begin
          If  (RightStr(strNomBanco, 6) = '(400p)') Then
            frmGerDupSel.strCodBco := LeftStr(strNomBanco,3) + '_400p'
          Else
            frmGerDupSel.strCodBco := LeftStr(strNomBanco,3) + '-'
        End
        Else
        If (LeftStr(strNomBanco, 3) = '104') And
           (RightStr(strNomBanco, 4) = '400p') Then
        Begin
          frmGerDupSel.strCodBco := LeftStr(strNomBanco,3) + 'p400';
          frmGerDupSel.blnCEF400 := True;
        End;

        If (LeftStr(strNomBanco, 3) = '033') And
           (RightStr(strNomBanco, 6) = '[240p]') Then
        Begin
          frmGerDupSel.strCodBco := LeftStr(strNomBanco,3) + 'B240p';
          frmGerDupSel.blnCEF400 := True;
        End;

        if Pos('Vendor', strNomBanco) > 0  then
          frmGerDupSel.strCodBco := LeftStr(strNomBanco,3) + '_VENDOR';

        frmGerDupSel.strTipGer        := 'R';
        frmGerDupSel.EhOcorrenciaDeBaixa := IIF(rdgOcorrencias.Enabled,rdgOcorrencias.ItemIndex=1,False);
        frmGerDupSel.ShowModal;
      Finally
        FreeAndNil(frmGerDupSel);
      End;
    End
    Else
      fMensagem('','Não há dados para gerar duplicata!',['&O K']);

  End;

end;

procedure TfrmGerDup.rdgOcorrenciasClick(Sender: TObject);
begin
  inherited;

  If (rdgOcorrencias.ItemIndex=1) And LeftStr(strNomBanco, 3).Equals('001') And (strTipGer <> 'P') Then
    rdgData.Items.Add('Data de Baixa')

  Else If (strNomBanco = '237 - Bradesco') and (strTipGer <> 'P') and (rdgOcorrencias.ItemIndex=1) Then
    rdgData.Items.Add('Data de Baixa')

  Else If (strNomBanco = '341 - Itaú') and (strTipGer <> 'P') and (rdgOcorrencias.ItemIndex=1)Then
    rdgData.Items.Add('Data de Baixa')

  Else If (strNomBanco = '033 - Santander') and (strTipGer <> 'P') and (rdgOcorrencias.ItemIndex=1)Then
    rdgData.Items.Add('Data de Baixa')

  Else If (strNomBanco = '756 - Bancoob_240p') and (strTipGer <> 'P') and (rdgOcorrencias.ItemIndex=1) Then
    rdgData.Items.Add('Data de Baixa');


  If (rdgData.Items.Count=3) and (rdgOcorrencias.ItemIndex<>1) Then
  Begin
   rdgData.Items.Delete(2);
   rdgData.ItemIndex:=0;
  End;

end;

function TfrmGerDup.RetornaConfiguracaoCTA(ABanco: String): String;
begin
 If ABanco = '033 - Santander' Then
    Result := 'CONFIGCTA033'

  Else  If ABanco = '422 - Safra' Then
    Result := 'CONFIGCTA422'

  Else If ABanco = '104 - Caixa Federal' Then
    Result := 'CONFIGCTA104'

  Else If ABanco = '001 - Banco do Brasil' Then
    Result := 'CONFIGCTA001'

  Else If ABanco = '341 - Itaú' Then
    Result := 'CONFIGCTA341'

  Else If ABanco = '748 - Sicredi' Then
    Result := 'CONFIGCTA748'

  Else If ABanco = '001 - Banco do Brasil [Online]' Then
    Result := 'CONFIGCTAAPI001'

  Else If ABanco = '274 - BMP Money Plus - X Baas' Then
    Result := 'CONFIGCTA274'

  Else  If ABanco = '237 - Bradesco' Then
    Result := 'CONFIGCTA237'

  Else  If ABanco = '237 - Bradesco - 240p' Then
    Result := 'CONFIGCTA237_240p'

  Else If ABanco = '041 - Banrisul' Then
    Result := 'CONFIGCTA041'

  Else If ABanco = '756 - Bancoob' Then
    Result := 'CONFIGCTA756'

  Else If ABanco = '246 - ABC Brasil' Then
    Result := 'CONFIGCTA246'

  Else   If ABanco = '021 - Banestes' Then
    Result := 'CONFIGCTA021'
end;

procedure TfrmGerDup.pGeraDupContasPagar;
  Var
    strSQL : String;
    strAux : String;
    strDtaFiltro : String;
    strEmpAce: String;
    recItem  : TConsultas;
    strFinalidadeTED: String;
    TotalDuplicatas: Double;
begin
  TotalDuplicatas  := 0;
  strFinalidadeTED := '00010 - Crédito em Conta';
  strSQL := '';
  strAux := '';
  strAux := strAux + 'CREATE TEMPORARY TABLE TMP_ATBPAG ';

  Case rdgData.ItemIndex Of
    0: strDtaFiltro := 'CTP_DTACAD';
    1: strDtaFiltro := 'CTP_DTAVEN';
  End;

  strSQL := strSQL + '(SELECT        ';
  strSQL := strSQL + '  CONCAT(CTP_NUMDUP,CTP_PARCEL) AS CTP_NUMDUP, ';
  strSQL := strSQL + '  CTP_NUMDUP AS NUMDUP, ';
  strSQL := strSQL + '  CTP_PARCEL, ';
  strSQL := strSQL + '  CTP_SEQBAI, ';
  strSQL := strSQL + '  CTP_SERIE_, ';
  strSQL := strSQL + '  CTP_DTAVEN, ';
  strSQL := strSQL + '  CTP_DTACAD, ';
  strSQL := strSQL + '  IF((COALESCE(CTP_QTDDIA, 0) = 0) OR (CTP_DTAVEN - CTP_QTDDIA < ' + fCurrentDate + '), ';
  strSQL := strSQL + '  CTP_DTAVEN, CAST(CTP_DTAVEN - CTP_QTDDIA AS DATE)) AS CTP_DTAPAG, ';
  strSQL := strSQL + '  CTP_VALDUP, ';
  if fCfgSis('TOTCTP', varBoolean) then
    strSQL := strSQL + '  CTP_VALDUP + IFNULL(CTP_JURSUJ, 0) + IFNULL(CTP_MULSUJ, 0) - IFNULL(CTP_DESSUJ, 0) + IFNULL(CTP_VENDOR, 0) + IFNULL(CTP_OUTENT, 0) AS VALORTOTAL, '
  else
    strSQL := strSQL + '  CTP_VALDUP + IFNULL(CTP_OUTENT, 0) - IFNULL(CTP_DESSUJ, 0) AS VALORTOTAL, ';
  strSQL := strSQL + '  IFNULL(CTP_JURSUJ, 0) AS CTP_JURSUJ, ';
  strSQL := strSQL + '  IFNULL(CTP_VALJUR, 0) AS CTP_VALJUR, ';
  strSQL := strSQL + '  IFNULL(CTP_OUTENT, 0) AS CTP_OUTENT, ';
  strSQL := strSQL + '  IFNULL(CTP_DESSUJ, 0) AS CTP_VALDES, ';
  strSQL := strSQL +  ' IFNULL(CTP_MULSUJ, 0) AS CTP_MULSUJ, ';
  strSQL := strSQL + '  IFNULL(CTP_VENDOR, 0) AS CTP_VENDOR, ';
  strSQL := strSQL + '  ' + fCurrentDate + ' AS CTP_DTAENV, ';
  strSQL := strSQL + '  CTP_CODEMP, ';
  strSQL := strSQL + '  CTP_QTDDIA, ';
  strSQL := strSQL + '  CTP_CODFOR, ';
  strSQL := strSQL + '  FOR_NOMFOR, ';

  strSQL := strSQL + '  CONCAT(FOR_ENDERE," ", IFNULL(FOR_ENDNUM,"")) AS FOR_ENDCOB, ';
  strSQL := strSQL + '  FOR_BAIRRO AS FOR_BAICOB, ';
  strSQL := strSQL + '  D1.CID_NOMCID AS FOR_NOMCID, ';
  strSQL := strSQL + '  D1.CID_ESTADO AS FOR_ESTADO, ';
  strSQL := strSQL + '  FOR_C_E_P_ AS FOR_CEPCOB, ';

  strSQL := strSQL + '  CTP_HIST01, ';
  strSQL := strSQL + '  CTP_HIST02, ';
  strSQL := strSQL + '  CTP_CODVEL, ';
  strSQL := strSQL + '  CTP_CODCTA, ';
  strSQL := strSQL + '  CTP_CODBAR, ';
  strSQL := strSQL + '  CTP_LINDIG, ';
  strSQL := strSQL + '  CTP_DTALIB, ';
  strSQL := strSQL + '  A.PAG_AUTCTP, ';

  strSQL := strSQL + '  CTP_TIPDOC, ';
  strSQL := strSQL + '  CTP_Q_GUIA, ';
  strSQL := strSQL + '  CTP_CODREC, ';
  strSQL := strSQL + '  CTP_COMPET, ';
  strSQL := strSQL + '  CTP_FORPIX, ';
  strSQL := strSQL + '  CTP_BCOFOR, ';
  strSQL := strSQL + '  CONCAT("BCO: ", RPAD(B.BCF_CODBCO, 4, " "), ';
  strSQL := strSQL + '         "AG: ", RPAD(CONCAT(B.BCF_NUMAGE, IF(B.BCF_DIGAGE = "", "", "-"), B.BCF_DIGAGE), 8, " "), ';
  strSQL := strSQL + '         "CONTA: ", RPAD(CONCAT(B.BCF_NUMCTA, IF(B.BCF_DIGCTA = "", "", "-"), B.BCF_DIGCTA), 14, " ")) AS CONTAFOR, ';

  strSQL := strSQL + '  IF(((CTP_DEPOSI = "S")), "Depósito", "Boleto") AS DEPOSI, ';
  strSQL := strSQL + '  IF(CTP_TIPDOC = "2", "00001 - Pagamento de Impostos, Tributos e Taxas", CAST('+QuotedStr(strFinalidadeTED)+' AS CHAR(60))) AS CODTED, ';

  strSQL := strSQL + '  CADPAG.AUTOINCREM AS AUTOINCREM  ';
  strSQL := strSQL + 'FROM      ';
  strSQL := strSQL + '  CADFOR  ';
  strSQL := strSQL + '  JOIN CADPAG ON CTP_CODFOR = FOR_CODFOR ';
  strSQL := strSQL + '  LEFT JOIN CADCID D1 ON FOR_CODCID = D1.CID_CODCID ';
  strSQL := strSQL + '  LEFT JOIN BCOFOR B ON B.AUTOINCREM = CTP_BCOFOR ';
  strSQL := strSQL + '  LEFT JOIN CTRPAG A ON A.PAG_AUTCTP = CADPAG.AUTOINCREM ';
  strSQL := strSQL + 'WHERE     ';
  strSQL := strSQL + '  '+strDtaFiltro+' BETWEEN :DTAINI AND :DTAFIN AND ';
  strSQL := strSQL + '  CTP_DTAPAG IS NULL AND ';
  strSQL := strSQL + '  CTP_DTACAD IS NOT NULL AND ';
  strSQL := strSQL + '  CTP_DTAENV IS NULL AND ';
  strSQL := strSQL + '  CTP_BCOENV IS NULL ';

  // apenas duplicatas GNRE
  If blnPGG Then
    strSQL := strSQL + ' AND CTP_Q_GUIA = "7" ';

  If (chkComCodBar.Checked) And (chkDupDeposi.Checked) Then
  Begin
    strSQL := strSQL + ' AND ((IFNULL(CTP_CODBAR, "") <> "") ';
    strSQL := strSQL + ' OR (CTP_DEPOSI = "S")) ';
  end
  else
  Begin
    If chkComCodBar.Checked Then
      strSQL := strSQL + ' AND (IFNULL(CTP_CODBAR, "") <> "") ';

    If chkDupDeposi.Checked Then
      strSQL := strSQL + ' AND CTP_DEPOSI = "S" ';
  End;

  If (Not fEmptyStr(edtEmpresa.Text)) And (edtEmpresa.Text <> '000') Then
    strSQL := strSQL + '  AND CTP_CODEMP = :CODEMP '
  Else
  Begin
    If (Length(arrEmpresa) > 0)  Then
    Begin
      strEmpAce := '';
      For recItem in arrEmpresa Do
        strEmpAce := strEmpAce + recItem.strCodigo + '_';
      strSQL := strSQL + '  AND LOCATE(CTP_CODEMP, ' + QuotedStr(strEmpAce) + ') > 0 ';
    End
    Else
      strSQL := strSQL + '  AND LOCATE(CTP_CODEMP, ' + QuotedStr(fRetEmpAcessoCTR(strLoginUsuarioLogado)) + ') > 0 ';
  End;

  If (Not fEmptyStr(edtCepIni.Text)) And (Not fEmptyStr(edtCepFin.Text)) Then
    strSQL := strSQL + '  AND FOR_C_E_P_ BETWEEN :CEPINI AND :CEPFIN ';

  If Not fEmptyStr(edtPortador.Text) Then
    strSQL := strSQL + '  AND CTP_CODPOR = :CODPOR '
  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + ' AND (IFNULL(CTP_CODPOR, "") = "" ';
    strSQL := strSQL + ' OR LOCATE(CTP_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;

  If (rdgLiberados.Visible) Then
  Begin
    Case rdgLiberados.ItemIndex Of
      0: strSQL := strSQL + '  AND CTP_DTALIB IS NOT NULL ';
      1: strSQL := strSQL + '  AND CTP_DTALIB IS NULL ';
    End;
  End;

  Case rdgChavesPix.ItemIndex Of
    1: strSQL := strSQL + '  AND CTP_FORPIX IS NOT NULL ';
    2: strSQL := strSQL + '  AND CTP_FORPIX IS NULL ';
  End;

  strSQL := strSQL + '  GROUP BY CADPAG.AUTOINCREM ';
  strSQL := strSQL + '  ORDER BY ' + strDtaFiltro + ')';

  strSQL := strAux + strSQL;

  With qryDuplic Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

    If (Not fEmptyStr(edtEmpresa.Text)) And (edtEmpresa.Text <> '000') Then
      ParamByName('CODEMP').AsString := edtEmpresa.Text;

    If Not fEmptyStr(edtPortador.Text) Then
      ParamByName('CODPOR').AsString := edtPortador.Text;

    If (Not fEmptyStr(edtCepIni.Text)) And (Not fEmptyStr(edtCepFin.Text)) Then
    Begin
      ParamByName('CEPINI').AsString := edtCepIni.Text;
      ParamByName('CEPFIN').AsString := edtCepFin.Text;
    End;

    ExecSQL;

    strSQL := '';
    strSQL := strSQL + 'ALTER TABLE ';
    strSQL := strSQL + '  TMP_ATBPAG ';
    strSQL := strSQL + 'ADD ';
    strSQL := strSQL + '  CTP_MARCAD VARCHAR(1) ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

    strSQL := '';
    strSQL := strSQL + 'ALTER TABLE ';
    strSQL := strSQL + '  TMP_ATBPAG ';
    strSQL := strSQL + 'ADD ';
    strSQL := strSQL + '  CTP_PROTES VARCHAR(1) ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  TMP_ATBPAG ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  CTP_PROTES = "N" ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  TMP_ATBPAG ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  DEPOSI = "Depósito", ';
    strSQL := strSQL + '  CODTED = "00004 - Pagamento de Salários" ';
    strSQL := strSQL + 'WHERE PAG_AUTCTP IS NOT NULL ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM TMP_ATBPAG ORDER BY CTP_DTAVEN');
    Open;

    If Not IsEmpty Then
    Begin
      Try
        First;
        While Not Eof Do
        Begin
          TotalDuplicatas := TotalDuplicatas + FieldByName('VALORTOTAL').AsFloat;
          Next;
        End;

        pCriarFormularios(TfrmGerDupSel,frmGerDupSel);

        frmGerDupSel.qryDuplic := qryDuplic;

        frmGerDupSel.Caption := 'AutBan';

        //REDIMENSIONANDO A TELA PARA APRESENTAR OS DADOS DE FORMA DE PAGAMENTO E CÓDIGO DO TED
        If (blnMosTED) Then
          frmGerDupSel.Width               := 1230;

        frmGerDupSel.lblMensagem.Caption := '';
        frmGerDupSel.pnlTopo.Caption  := 'Geração de Duplicatas - ' + strNomBanco;
        frmGerDupSel.strLog           := 'GERAÇÃO DE DUPLICATAS';
        frmGerDupSel.strCodBco        := LeftStr(strNomBanco,3);
        frmGerDupSel.strJuros         := edtJuros.Text;
        frmGerDupSel.strTipoBanco     := strTipoBanco;
        frmGerDupSel.strTipGer        := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
        frmGerDupSel.blnMosTED        := blnMosTED;
        frmGerDupSel.blnPGG           := blnPGG;
        frmGerDupSel.ContasAPagarAPI  := FContasAPagarAPI;
        frmGerDupSel.BancoArquivoPix  := FBancoArquivoPix;
        frmGerDupSel.edtTotalDup.Text := FloatToStrF(TotalDuplicatas,ffNumber,15,2);
        frmGerDupSel.ShowModal;
      Finally
        FreeAndNil(frmGerDupSel);
      End;
    End
    Else
      fMensagem('','Não há dados para gerar duplicata!',['&O K']);

  End;

end;

procedure TfrmGerDup.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);

  If LeftStr(strNomBanco, 3) = '003' Then
    rdgBoletos.Enabled := False
  Else
    rdgBoletos.Enabled := True;

end;

procedure TfrmGerDup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  fDropTable('TMP_ATBREC');
  fDropTable('TMP_ATBPAG');
end;

procedure TfrmGerDup.FormCreate(Sender: TObject);
  Var
    LCasasDecimaisMora: Integer;
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  qryDuplic := fCriaQuery(Self);
  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  strTipoBanco := '';
  blnMosTED    := False;
  FblnEnvPro   := False;
  LCasasDecimaisMora := fCfgSis('CSDMOR', VarInteger);
  FDefaultJuros := '0,' + fStrZero('0',LCasasDecimaisMora);
  edtJuros.EditFormat := '###,' + fPadR('#',LCasasDecimaisMora,'#')
                         + '0.' + fPadR('0',LCasasDecimaisMora,'0');
end;

procedure TfrmGerDup.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If key = VK_RETURN Then
  Begin
    If (ActiveControl Is TRadioGroup) or (ActiveControl Is TRadioButton) Then
    Begin
//      pProximoControle(Sender);
    End;
  End;
end;

end.


