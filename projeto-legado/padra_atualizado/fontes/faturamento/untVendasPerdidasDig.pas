unit untVendasPerdidasDig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, StrUtils,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, DBCtrls, DBEditFocus,
  untConstantes, BitBtnLockedIncrem, MemDS, DBAccess, Datasnap.Provider,
  frxClass, frxExportCSVTestabilidade, MemoFocus, Datasnap.DBClient;

type

  TRegistroConsumidor = Record
    strCliNom,
    strCliEnd,
    strCliBai,
    strCliCep,
    strCodCid,
    strCliCid,
    strCliEst,
    strCliTel,
    strCliCgc,
    strCliIes,
    strCli_Rg: String;
    intCgcCpf: Integer;
  End;

  TfrmVendasPerdidasDig = class(TfrmPaiOrdena)
    Panel1: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    lblCliFor: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    Label6: TLabel;
    Label7: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtSenVen: TEditFocus;
    edtNomVen: TEditFocus;
    edtCodigo: TEditFocus;
    mskDtaCad: TMaskEditFocus;
    btnExcluir: TBitBtnLocked;
    Label8: TLabel;
    mskDtaAlt: TMaskEditFocus;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtQtdIte: TEditFocus;
    edtMotivo: TEditFocus;
    btnExcVen: TBitBtnLocked;
    edtCodMot: TEditFocus;
    memObserv: TMemoFocus;
    Label221: TLabel;
    Label12: TLabel;
    edtUnitar: TEditFocus;
    Label15: TLabel;
    edtTotIte: TEditFocus;
    pnlConcorrencia: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    edtCodCon: TEditFocus;
    edtDesCon: TEditFocus;
    edtVlrCon: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure edtCodCliEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExcVenClick(Sender: TObject);
    procedure edtCodMotKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    function fMotivoInformaConcorrencia(strCodMot: string): Boolean;
    procedure edtCodConKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    fltVlrUniOri: Double;
    intDecUni: Integer;
    tipOperac: TTipoOperacao;

    regConsum: TRegistroConsumidor;

    qryMovVpg,
    qryConCli,
    qryCadIte: TUniQuery;

    strIteAnt,
    strCliAnt,
    strCodigo,
    strCodVen: String;

    FCliIni: String;
    FVenIni: String;
    FProIni: String;

    function fCarregaVendaPerdida(strCodigo: String): Boolean;
    Function fGravaVendaPerdida: Boolean;
    Function fIncluiVendaPerdida: Boolean;
    Function fAlteraVendaPerdida: Boolean;
    Function fTemItemVenda: Boolean;
    Function fDigDadosConsumidor: Boolean;

    procedure pIniciaVenda;
    Procedure pLimpaTela;
    Procedure pCarregaCabec;
    procedure pTravaItemFracionadoKey(Sender: TObject; var Key: Char);
    Procedure pCarregaItem(strCodIte: String);
    procedure pExcluiItem;
    Procedure pAlteraMovVpg(strCodigo, strCodCli, strCodVen, strCpfCon: String; dtaDtaAlt: TDate);
    Procedure pApagaMovVpd(strCodigo: String);
    procedure pMostraItem;
    procedure pLimpaItem;
    procedure pGravaItem;
    Procedure pEditaItem;
    Procedure pCarregaDadosConsumidor(strCodCli: String);
    procedure pExcluiVendaPerdida(strCodigo: String);

    function fPreencherDadosIniciais: Boolean;
    function fPegaPrecoVenda(strCodIte, strCodEmp: String): String;

    procedure pInsereDEL_MOVVPD;
    procedure pInsereDEL_MOVVPG;

  public
    property strCliIni: String Read FCliIni Write FCliIni;
    property strVenIni: String Read FVenIni Write FVenIni; // Armazena a senha do Ven;
    property strProIni: String Read FProIni Write FProIni;
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
    function fAbreConsulta(blnLike: Boolean = True): Boolean; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmVendasPerdidasDig: TfrmVendasPerdidasDig;

implementation

uses untPai,untPesqAux, untPanelCxClientes, untConsultas, untTypesSistema,
     untFuncoesSimples,untFuncoes, untFatDadosCliConsumidor,untPnlDadosCliente,
     untVendasPerdidas, untCadConcorrencia;

{$R *.dfm}

procedure TfrmVendasPerdidasDig.FormCreate(Sender: TObject);
begin
  inherited;

  pSetaCodIte( edtCodIte );
  tipOperac := opIncluir;

  qryMovVpg := fCriaQuery(Self);
  qryConCli := fCriaQuery(Self);
  QRYCADITE := fCriaQuery(Self);

  blnSempreRelerBanco := False;
  blnTemSelecao       := False;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  edtQtdIte.EditFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  edtVlrCon.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

  FCliIni := '';
  FVenIni := '';
  FProIni := '';

  intDecUni := fCfgSis('DECUNI', varInteger);
  if intDecUni = 0 then intDecUni := 2 ;

  edtUnitar.EditFormat := fMskDigitos(intDecUni);
end;

procedure TfrmVendasPerdidasDig.FormShow(Sender: TObject);
begin
  inherited;
  pIniciaVenda;
end;

function TfrmVendasPerdidasDig.fGetSql(blnLike: Boolean): String;
Begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '   VPD_CODITE, ';
  Result := Result + '   IF(LOCATE("ITEM ESPECIAL", ITE_DESITE), VPD_DESITE, ITE_DESITE) AS VPD_DESITE, ';
  Result := Result + '   VPD_QTDITE, ';
  Result := Result + '   VPD_UNIORI, ';
  Result := Result + '   VPD_UNITAR, ';
  Result := Result + '   VPD_TOTITE, ';
  Result := Result + '   VPD_CODMOT, ';
  Result := Result + '   VPD_OBSERV, ';
  Result := Result + '   MOT_DESMOT, ';
  Result := Result + '   VPD_CODCON, ';
  Result := Result + '   VPD_VLRCON, ';
  Result := Result + '   CNR_DESCON  ';
  Result := Result + ' FROM     ';
  Result := Result + '   MOVVPD ';
  Result := Result + '   INNER JOIN CADITE ON ITE_CODITE = VPD_CODITE ';
  Result := Result + '   LEFT  JOIN MOTVPD ON MOT_CODMOT = VPD_CODMOT ';
  Result := Result + '   LEFT  JOIN CADCNR ON CNR_CODCON = VPD_CODCON ';
  Result := Result + ' WHERE    ';
  Result := Result + '   VPD_CODEMP = :CODEMP AND ';
  Result := Result + '   VPD_CODIGO = :CODIGO     ';
End;

function TfrmVendasPerdidasDig.fPreencherDadosIniciais: Boolean;
begin
  Result := (Not fEmptyStr(strCliIni)) And
            (Not fEmptyStr(strVenIni));
end;

function TfrmVendasPerdidasDig.fSetParametros: Boolean;
Begin
  With qryConsulta Do
  Begin
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODIGO').AsString := strCodigo;
  End;
  Result := True;
End;

Procedure TfrmVendasPerdidasDig.pLimpaTela;
Begin
  FillChar(regConsum, SizeOf(regConsum), #0);

  strCodigo := '';
  strCliAnt := '';

  edtCodigo.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtSenVen.Clear;
  edtNomVen.Clear;
  mskDtaCad.Text := DateToStr(VS_Date);
  mskDtaAlt.Text := DateToStr(VS_Date);
  edtCodigo.ReadOnly := False;
  edtCodigo.TabStop  := True;

  pLimpaItem;
End;

Procedure TfrmVendasPerdidasDig.pCarregaCabec;
Begin
  With qryMovVpg Do
  Begin

    edtCodigo.Text   := FieldByName('VPG_CODIGO').AsString;
    edtCodCli.Text   := FieldByName('VPG_CODCLI').AsString;
    edtNomCli.Text   := fRetNomCliente(FieldByName('VPG_CODCLI').AsString);
    mskDtaCad.Text   := DateToStr(FieldByName('VPG_DTACAD').AsDateTime);
    mskDtaAlt.Text   := DateToStr(FieldByName('VPG_DTAALT').AsDateTime);
    edtSenVen.Clear;
    edtNomVen.Clear;

    edtCodigo.ReadOnly := True;
    edtCodigo.TabStop  := False;

    strCodigo := FieldByName('VPG_CODIGO').AsString;

    With regConsum Do
    Begin
      intCgcCpf := FieldByName('CON_CGCCPF').AsInteger;
      If (Not fEmptyStr(IntToStr(intCgcCpf))) Then
      Begin
        strCliNom := FieldByName('CON_NOMCON').AsString;
        strCliEnd := FieldByName('CON_ENDERE').AsString;
        strCliBai := FieldByName('CON_BAIRRO').AsString;
        strCliCep := FieldByName('CON_C_E_P_').AsString;
        strCodCid := FieldByName('CON_CODCID').AsString;
        strCliCid := fRetNomCidade(strCodCid);
        strCliEst := fRetNomCidade(strCodCid, 1);
        strCliTel := FieldByName('CON_FONE01').AsString;
        strCliCgc := FieldByName('CON_C_P_F_').AsString;
        strCliIes := FieldByName('CON_I_E_S_').AsString;
        strCli_Rg := FieldByName('CON_NUMR_G').AsString;

        If (fEmptyStr(strCliNom)) Then
          strCliNom := edtNomCli.Text
        Else
          edtNomCli.Text := strCliNom;
      End

      Else If fClienteConsumidor(edtNomCli.Text, False, True) Then
             pCarregaDadosConsumidor(edtCodCli.Text);

    End;

    fAbreConsulta;

    pSetFocus(edtSenVen);

  End;
End;

function TfrmVendasPerdidasDig.fCarregaVendaPerdida(strCodigo: String): Boolean;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT  SQL_NO_CACHE ';
  strSQL := strSQL + '   VPG_CODIGO, ';
  strSQL := strSQL + '   VPG_DTAALT, ';
  strSQL := strSQL + '   VPG_DTACAD, ';
  strSQL := strSQL + '   VPG_CODVEN, ';
  strSQL := strSQL + '   VPG_CODCLI, ';
  strSQL := strSQL + '   VPG_CODCON, ';
  strSQL := strSQL + '   C.*         ';
  strSQL := strSQL + ' FROM   ';
  strSQL := strSQL + '   MOVVPG ';
  strSQL := strSQL + ' LEFT JOIN CLICON C ON CON_C_P_F_ = VPG_CPFCON ';
  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   VPG_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   VPG_CODIGO = :CODIGO     ';

  With qryMovVpg, SQL Do
  Begin
    Close;

    Clear;

    Add(strSQL);

    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODIGO').AsString := strCodigo;

    Open;

    Result := Not IsEmpty;

    If IsEmpty Then
      pIniciaVenda
    Else
      pCarregaCabec;

    btnExcVen.Visible := Not IsEmpty;

  End;
End;

Procedure TfrmVendasPerdidasDig.pCarregaDadosConsumidor(strCodCli: String);
  Var
    qryCadCli: TUniQuery;
Begin
  qryCadCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  pPesquisaCadCli(qryCadCli, qryCadCli, edtCodCli.Text);
  With regConsum, qryCadCli Do
  Begin
    strCliEnd := FieldByName('CLI_ENDERE').AsString + ', ' +
                          FieldByName('CLI_ENDNUM').AsString + '  ' +  //         - Endereco
                          FieldByName('CLI_ENDCOM').AsString;

    strCliBai := FieldByName('CLI_BAIRRO').AsString;                   //         - Bairro
    strCliCep := FieldByName('CLI_C_E_P_').AsString;                   //         - Cep
    strCodCid := FieldByName('CLI_CODCID').AsString;                   //         - Cód. Cidade
    strCliTel := FieldByName('CLI_FONE01').AsString;                   //         - Telefone
    strCliCid := fRetNomCidade(strCodCid);                             // - Cidade
    strCliEst := fRetNomCidade(strCodCid, 1);                          // - Estado

    strCliNom := FieldByName('CLI_NOMCLI').AsString;                   //         - Nome
    strCliCgc := FieldByName('CLI_C_G_C_').AsString;                   //         - CNPJ
    strCliIes := FieldByName('CLI_I_E_S_').AsString;                   //         - Ins.Estadual
    strCli_Rg := FieldByName('CLI_NUMR_G').AsString;                   //         - RG

    If fEmptyStr(FieldByName('CLI_CGCCPF').AsString) Then
      intCgcCpf := 0
    Else
      intCgcCpf := FieldByName('CLI_CGCCPF').AsInteger;                //         - CGC/CPF
  End;
  FreeAndNil(qryCadCli);
End;

function TfrmVendasPerdidasDig.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    strCliOri: String;
Begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    blnMudarFoco := True;

    If (Sender = edtCodigo) Then
    Begin

      If (Not edtCodigo.ReadOnly) Then
      Begin

        If (Not SameText(edtCodigo.Text,strCodigo)) And fCarregaVendaPerdida(edtCodigo.Text) Then
        Begin
          blnMudarFoco := False;
        End

        Else If Not fEmptyStr(edtCodigo.Text) Then
        Begin
          pMensagemOk('Sequencial não encontrado!');
          Result := False;
        End

        Else blnMudarFoco := True;

      End;

    End

    Else If Sender = edtCodCli Then
    Begin

      If fEmptyStr(edtCodCli.Text) Then
      Begin
        pMensagemOk('O Cliente deve ser preenchido!');
        Result := False;
      End Else
      Begin
        strCliOri := fRetNomCliente(edtCodCli.Text);

        If Not SameText(strCliAnt, edtCodCli.Text) Then
          edtNomCli.Text := strCliOri;

        If fEmptyStr(edtNomCli.Text) Then
        Begin
          pMensagemOk('Cliente não encontrado!');
          Result := False;
        End

        Else If blnBuscaPorChave Then
        Begin
          If fClienteConsumidor(strCliOri, False, True) Then
          Begin
            If Not SameText(strCliAnt, edtCodCli.Text) Then
              pCarregaDadosConsumidor(edtCodCli.Text);
            fDigDadosConsumidor;
          End;
        End;

        If Result Then
          strCliAnt := edtCodCli.Text;

      End

    End

    Else If Sender = edtSenVen Then
    Begin

      If fEmptyStr(edtSenVen.Text) Then
      Begin
        strCodVen := '';
        pMensagemOk('O vendedor deve ser preenchido!');
        Result := False;
      End
      Else
      Begin
        strCodVen := fRetCodVendedor(edtSenVen.Text);
        edtNomVen.Text := fRetNomVendRep(strCodVen);

        If fEmptyStr(edtNomVen.Text) Then
        Begin
          pMensagemOk('Vendedor não encontrado!');
          Result := False;
        End;

      End;

    End

    Else If Sender = edtCodIte Then
    Begin

      If fEmptyStr(edtCodIte.Text) Then
      Begin
        pMensagemOk('O Código do Item deve ser preenchido!');
        Result := False;
      End

      Else
      With qryCadIte Do
      Begin

        pCarregaItem(edtCodIte.Text);

        If IsEmpty Then
        Begin
          pMensagemOk('Item não encontrado!');
          Result := False;
        End

        Else If Not SameText(FieldByName('ITE_ITEATI').AsString, 'S') Then
        Begin
          pMensagemOk('Item inativo!');
          Result := False;
        End

        Else
        Begin

           If (strIteAnt <> FieldByName('ITE_CODITE').AsString) Or fEmptyStr(edtDesIte.Text) Then
           Begin
             edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
             edtUnitar.Text := fPegaPrecoVenda(FieldByName('ITE_CODITE').AsString, VS_strCodEmp ) ;
             fltVlrUniOri   := fStrToFloat(edtUnitar.Text);
           end;

           strIteAnt := FieldByName('ITE_CODITE').AsString;

        End;

      End;

    End

    Else If Sender = edtDesIte Then
    Begin

      If Not edtDesIte.ReadOnly Then
      Begin

        If fEmptyStr(edtDesIte.Text) Then
        Begin
          pMensagemOk('A descrição do item deve ser preenchida!');
          Result := False;
        End;

      End;

    End

    Else If Sender = edtQtdIte Then
    Begin

      If fStrToFloat(edtQtdIte.Text) <= 0 Then
      Begin
        pMensagemOk('A quantidade deve ser maior que zero!');
        Result := False;
      End
      else
      If not fEmptyStr(edtDesIte.Text) Then
        edtTotIte.Text := FormatFloat(fMskDigitos(2), fStrToFloat(edtQtdIte.Text) * fStrToFloat(edtUnitar.Text) );
    End

    Else If Sender = edtUnitar Then
    Begin

      If fStrToFloat(edtUnitar.Text) <= 0 Then
      Begin
        pMensagemOk('O valor unitário deve ser maior que zero!');
        Result := False;
      End
      else
      If not fEmptyStr(edtDesIte.Text) Then
        edtTotIte.Text := FormatFloat(fMskDigitos(2), fStrToFloat(edtQtdIte.Text) * fStrToFloat(edtUnitar.Text) );
    End

    Else If Sender = edtCodMot Then
    Begin

      If fEmptyStr(edtCodMot.Text) Then
      Begin
        pMensagemOk('O Motivo deve ser preenchido!');
        Result := False;
      End
      Else
      Begin
        edtMotivo.Text := fRetMotivoVendasPerdidas(edtCodMot.Text);

        If fEmptyStr(edtMotivo.Text) Then
        Begin
          pMensagemOk('Motivo não encontrado!');
          Result := False;
        End;
        pnlConcorrencia.Visible := fMotivoInformaConcorrencia(edtCodMot.Text);
      End;

    End

    Else If (pnlConcorrencia.Visible) And (Sender = edtCodCon) Then
    Begin
      If (fEmptyStr(edtCodCon.Text)) Then
      Begin
        fMensagem('', 'A concorrência deve ser preenchida!' , ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtDesCon.Text := fRetDesConcorrencia(edtCodCon.Text);
        If (fEmptyStr(edtDesCon.Text)) Then
        Begin
          fMensagem('AVISO', 'Concorrência não encontrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (pnlConcorrencia.Visible) And (Sender = edtVlrCon) Then
    Begin
      If (StrToFloatDef(AnsiReplaceStr(edtVlrCon.Text,'.',''), 0) <= 0) Then
      Begin
        fMensagem('', 'Valor deve ser maior que zero!' , ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

End;

procedure TfrmVendasPerdidasDig.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
    objfrmPnl  : TPanelCxClientes;
begin
  inherited;
  objfrmPnl := TPanelCxClientes.Create(TfrmPnlDadosCliente);

  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliEmpresaIdent, Self, edtCodCli, edtNomCli, qryTabela, Key, arrClientes, True, objfrmPnl) And (Not edtCodCli.ReadOnly) Then
  Begin
    If (fValidaCampos(edtCodCli, True)) and (blnMudarFoco) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

  FreeAndNil(objfrmPnl);
end;

procedure TfrmVendasPerdidasDig.edtCodConKeyPress(Sender: TObject;
  var Key: Char);
var
  arrConcorrencia: TConsultasArray;
begin
  inherited;
  if fPesqConcorrencia(Self, edtCodCon, edtDesCon, Nil, Key, arrConcorrencia) then
  begin
    if fValidaCampos(edtCodCon, True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmVendasPerdidasDig.pTravaItemFracionadoKey(Sender: TObject; var Key: Char);
Begin

  If CharInSet(Key, [',','.','-']) Then
    Key := #0;

End;

function TfrmVendasPerdidasDig.fAbreConsulta(blnLike: Boolean = True): Boolean;
Begin
  Result := inherited fAbreConsulta;
  cdsConsulta.Tag := 1;
End;

Procedure TfrmVendasPerdidasDig.pCarregaItem(strCodIte: String);
Begin
  With qryCadIte, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT ');
    Add('  ITE_CODITE, ');
    Add('  ITE_DESITE, ');
    Add('  ITE_CODUNI, ');
    Add('  ITE_ITEATI  ');
    Add('FROM CADITE');
    Add('WHERE ITE_CODITE = :CODITE');

    ParamByName('CODITE').AsString := strCodIte;

    Open;

    If Not IsEmpty Then
    Begin
      If Not fItemFracionado(FieldByName('ITE_CODUNI').AsString) Then
        edtQtdIte.OnKeyPress := pTravaItemFracionadoKey
      Else
        edtQtdIte.OnKeyPress := Nil;

      edtDesIte.ReadOnly := Pos('ITEM ESPECIAL', FieldByName('ITE_DESITE').AsString) = 0;
      edtDesIte.TabStop  := Not edtDesIte.ReadOnly;
    End;

  End;
End;

procedure TfrmVendasPerdidasDig.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  With cdsConsulta Do
  If fVerificaCampos Then
    pGravaItem;

end;

procedure TfrmVendasPerdidasDig.pExcluiItem;
Begin
  With cdsConsulta Do
  Begin

    If (Not IsEmpty) And fPergunta('Deseja excluir o item?') Then
      Delete;

    pLimpaItem;  
  End;
End;

procedure TfrmVendasPerdidasDig.btnExcluirClick(Sender: TObject);
begin
  inherited;

  pExcluiItem;

end;

procedure TfrmVendasPerdidasDig.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: pEditaItem;
    VK_DELETE: pExcluiItem;
  End;

end;

procedure TfrmVendasPerdidasDig.pIniciaVenda;
Begin
  pLimpaTela;
  fAbreConsulta;
  pSetFocus(edtCodigo);
End;

Function TfrmVendasPerdidasDig.fTemItemVenda: Boolean;
Begin
  With cdsConsulta Do
  Begin
    Result := Not IsEmpty;
    If Not Result Then
      pMensagemOk('Informe os itens da venda!');
  End;
End;

procedure TfrmVendasPerdidasDig.btnGravarClick(Sender: TObject);
begin
  inherited;

  If pnlPesquisa.Visible Then
    pLimpaPesquisa;
  
  With cdsConsulta Do
  If fValidaCampos(edtCodCli, False) And
     fValidaCampos(edtSenVen, False) And
     fTemItemVenda Then
  Begin
    If State in [dsEdit, dsInsert] Then
      Post;

    DisableControls;

    If fGravaVendaPerdida Then
    Begin
      pIniciaVenda;

      pMensagemOk('Venda incluída com sucesso!');
    End;

    EnableControls;
  End;

end;

Function TfrmVendasPerdidasDig.fGravaVendaPerdida: Boolean;
Begin
  If fEmptyStr(edtCodigo.Text) Then
    Result := fIncluiVendaPerdida
  Else
    Result := fAlteraVendaPerdida;
End;

Procedure TfrmVendasPerdidasDig.pAlteraMovVpg(strCodigo, strCodCli, strCodVen, strCpfCon: String; dtaDtaAlt: TDate);
  Var
    qryGen: TUniQuery;
Begin
  if fEmptyStr(strCodCli) then
    raise EMovVpg.Create('Código do Cliente não informado!');

  qryGen := fCriaQuery;
  With qryGen Do
  Begin

    SQL.Clear;
    SQL.Add('SELECT * FROM MOVVPG WHERE');
    SQL.Add('VPG_CODIGO = :CODIGO AND');
    SQL.Add('VPG_CODEMP = :CODEMP    ');

    ParamByName('CODIGO').AsString   := strCodigo;
    ParamByName('CODEMP').AsString   := VS_strCodEmp;
    Open;

    Edit;
    FieldByName('VPG_CODCLI').AsString   := strCodCli;
    FieldByName('VPG_CODVEN').AsString   := strCodVen;
    FieldByName('VPG_DTAALT').AsDateTime := dtaDtaAlt;
    FieldByName('VPG_CPFCON').AsString   := strCpfCon;

    If fEmptyStr(strCpfCon) Then
      FieldByName('VPG_CPFCON').Clear;

    Post;

  End;

  FreeAndNil(qryGen);
End;

Procedure TfrmVendasPerdidasDig.pApagaMovVpd(strCodigo: String);
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;

  With qryGen Do
  Begin

    SQL.Clear;
    SQL.Add('DELETE FROM MOVVPD WHERE');
    SQL.Add('VPD_CODIGO = :CODIGO AND');
    SQL.Add('VPD_CODEMP = :CODEMP    ');

    ParamByName('CODIGO').AsString   := strCodigo;
    ParamByName('CODEMP').AsString   := VS_strCodEmp;
    ExecSQL;

  End;

  FreeAndNil(qryGen);
End;

Function TfrmVendasPerdidasDig.fIncluiVendaPerdida: Boolean;
Begin
  With cdsConsulta Do
  Try
    fStartTransaction;

    strCodigo := fAtualizaProCod('MOVVPG', 'VPG_CODIGO');

    pIncluiMovVpg(strCodigo, edtCodCli.Text, strCodVen, regConsum.strCliCgc, VS_Date,
      '', '', '','DIGITAÇÃO DE VENDAS PERDIDAS');

    First;
    While Not Eof Do
    Begin
      pIncluiMovVpd(strCodigo,
                    FieldByName('VPD_CODITE').AsString,
                    FieldByName('VPD_DESITE').AsString,
                    FieldByName('VPD_CODMOT').AsString,
                    FieldByName('VPD_QTDITE').AsFloat,
                    FieldByName('VPD_UNIORI').AsFloat,
                    FieldByName('VPD_UNITAR').AsFloat,
                    FieldByName('VPD_TOTITE').AsFloat,
                    FieldByName('VPD_OBSERV').AsString,
                    FieldByName('VPD_CODCON').AsString,
                    FieldByName('VPD_VLRCON').AsFloat);

      Next;
    End;

    fCommit;
    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[fIncluiVendaPerdida]');
    End;
  End;
End;

function TfrmVendasPerdidasDig.fMotivoInformaConcorrencia(
  strCodMot: string): Boolean;
var
  qryMotivo: TUniQuery;
begin
  Result := False;
  qryMotivo := fCriaQuery;

  try
    qryMotivo.Close;
    qryMotivo.SQL.Clear;
    qryMotivo.SQL.Add('SELECT MOT_INFCON');
    qryMotivo.SQL.Add('FROM MOTVPD');
    qryMotivo.SQL.Add('WHERE MOT_CODMOT = :CODMOT');

    qryMotivo.ParamByName('CODMOT').AsString := strCodMot;

    qryMotivo.Open;

    if (not qryMotivo.IsEmpty) and (qryMotivo.FieldByName('MOT_INFCON').AsString = 'S') then
    begin
      Result := True;
    end;
  finally
    FreeAndNil(qryMotivo);
  end;
end;

Function TfrmVendasPerdidasDig.fAlteraVendaPerdida: Boolean;
Begin
  With cdsConsulta Do
  Try
    fStartTransaction;

    pAlteraMovVpg(strCodigo, edtCodCli.Text, strCodVen, regConsum.strCliCgc, VS_Date);

    pApagaMovVpd(strCodigo);

    First;
    While Not Eof Do
    Begin
      pIncluiMovVpd(strCodigo,
                    FieldByName('VPD_CODITE').AsString,
                    FieldByName('VPD_DESITE').AsString,
                    FieldByName('VPD_CODMOT').AsString,
                    FieldByName('VPD_QTDITE').AsFloat,
                    FieldByName('VPD_UNIORI').AsFloat,
                    FieldByName('VPD_UNITAR').AsFloat,
                    FieldByName('VPD_TOTITE').AsFloat,
                    FieldByName('VPD_OBSERV').AsString,
                    FieldByName('VPD_CODCON').AsString,
                    FieldByName('VPD_VLRCON').AsFloat);

      Next;
    End;

    fCommit;
    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[fAlteraVendaPerdida]');
    End;
  End;
End;

procedure TfrmVendasPerdidasDig.edtCodigoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryPesqui: TUniQuery;
    arrSel   : TConsultasArray;

begin
  inherited;

  qryPesqui := fCriaQuery;

  If fPesqVenPerd(Self, edtCodigo, qryPesqui, Key, arrSel) Then
  Begin
    fValidaCampos(edtCodigo, True);
  End;

end;

procedure TfrmVendasPerdidasDig.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  frmCadConcorrenciaLocal: TfrmCadConcorrencia;
begin
  inherited;

  Case Key Of
    VK_F10: btnGravar.Click;
  End;

  if (edtCodCon.Focused) then
  begin
    if (Key = VK_INSERT) then
    begin
      pCriarFormularios(TfrmCadConcorrencia, frmCadConcorrenciaLocal);
      try
        frmCadConcorrenciaLocal.ShowModal;
      finally
        pFreeAndNil(frmCadConcorrenciaLocal);
      end;
    end;
  end;
end;

procedure TfrmVendasPerdidasDig.edtCodIteKeyPress(Sender: TObject;var Key: Char);
  Var
    qryConGen: TUniQuery;
    arrSel : TConsultasArray;
begin
  inherited;

  If (fEntraCons(Key)) And (Not edtCodIte.ReadOnly) Then
  Begin

    qryConGen    := fCriaQuery;
    Try
      if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryConGen, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
      Begin
        If fValidaCampos(edtCodIte, True) Then
          Self.SelectNext(ActiveControl, True, True);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmPrincipal.pConsultaItem]');
      End;
    End;
    FreeAndNil(qryConGen);
  End;
end;

procedure TfrmVendasPerdidasDig.edtCodMotKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCodMot: TConsultasArray;
begin
  inherited;
  If fPesqMotVendasPerdidas(Self, edtCodMot, edtMotivo, Nil, Key, arrCodMot) Then
  Begin
    if fValidaCampos(edtCodMot, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmVendasPerdidasDig.pMostraItem;
Begin
  With cdsConsulta Do
  Begin
    If State In [dsEdit, dsInsert] Then
      Exit;

    If IsEmpty Then
      Exit;

    pCarregaItem(FieldByName('VPD_CODITE').AsString);

    edtCodIte.Text := FieldByName('VPD_CODITE').AsString;
    edtDesIte.Text := FieldByName('VPD_DESITE').AsString;
    edtCodMot.Text := FieldByName('VPD_CODMOT').AsString;
    edtMotivo.Text := FieldByName('MOT_DESMOT').AsString;
    edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat, FieldByName('VPD_QTDITE').AsFloat);
    edtUnitar.Text := FormatFloat(edtUnitar.EditFormat, FieldByName('VPD_UNITAR').AsFloat);
    edtTotIte.Text := FormatFloat(edtTotIte.EditFormat, FieldByName('VPD_TOTITE').AsFloat);
    memObserv.Texto:= FieldByName('VPD_OBSERV').AsString;
    strIteAnt := FieldByName('VPD_CODITE').AsString;
    edtCodCon.Text := FieldByName('VPD_CODCON').AsString;
    edtDesCon.Text := FieldByName('CNR_DESCON').AsString;
    edtVlrCon.Text := FormatFloat(edtVlrCon.EditFormat, FieldByName('VPD_VLRCON').AsFloat);

    tipOperac := opAlterar;
  End;
End;

procedure TfrmVendasPerdidasDig.pLimpaItem;
Begin
  strIteAnt := '';
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtCodMot.Clear;
  edtMotivo.Clear;
  edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat,   0);
  edtUnitar.Text := FormatFloat(fMskDigitos(intDecUni), 0);
  edtTotIte.Text := FormatFloat(fMskDigitos(2),         0);
  tipOperac      := opIncluir;
  fltVlrUniOri   := 0;
  memObserv.Clear;
  edtCodCon.Clear;
  edtDesCon.Clear;
  edtVlrCon.Text := FormatFloat(fMskDigitos(intDecUni), 0);
  pnlConcorrencia.Visible := False;

  pSetFocus(edtCodIte);
End;

procedure TfrmVendasPerdidasDig.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;

  pMostraItem;
end;

procedure TfrmVendasPerdidasDig.pGravaItem;
Begin
  With cdsConsulta Do
  Begin
    Case tipOperac Of
      opIncluir : Insert;
      opAlterar : Edit;
      Else        Exit;
    End;

    FieldByName('VPD_CODITE').AsString := edtCodIte.Text;
    FieldByName('VPD_DESITE').AsString := edtDesIte.Text;
    FieldByName('VPD_CODMOT').AsString := edtCodMot.Text;
    FieldByName('MOT_DESMOT').AsString := edtMotivo.Text;
    FieldByName('VPD_QTDITE').AsFloat  := fStrToFloat(edtQtdIte.Text);
    if FieldByName('VPD_UNIORI').AsFloat = 0 then
       FieldByName('VPD_UNIORI').AsFloat := fltVlrUniOri;
    FieldByName('VPD_UNITAR').AsFloat  := fStrToFloat(edtUnitar.Text);
    FieldByName('VPD_TOTITE').AsFloat  := fStrToFloat(edtTotIte.Text);
    FieldByName('VPD_OBSERV').AsString := memObserv.Texto;

    if pnlConcorrencia.Visible then
    begin
      FieldByName('VPD_CODCON').AsString := edtCodCon.Text;
      FieldByName('VPD_VLRCON').AsFloat  := StrToFloatDef(AnsiReplaceStr(edtVlrCon.Text,'.',''), 0);
      FieldByName('CNR_DESCON').AsString := edtDesCon.Text;
    end
    else
    begin
      FieldByName('VPD_CODCON').Clear;
      FieldByName('VPD_VLRCON').Clear;
      FieldByName('CNR_DESCON').Clear;
    end;

    Post;

    pLimpaItem;

  End;
End;

Procedure TfrmVendasPerdidasDig.pEditaItem;
Begin
  pMostraItem;
  pSetFocus(edtCodIte);
End;

procedure TfrmVendasPerdidasDig.btnCancelaItemClick(Sender: TObject);
begin
  inherited;

  pLimpaItem;

end;

function TfrmVendasPerdidasDig.fDigDadosConsumidor: Boolean;
begin

  With regConsum Do
  Try
    pCriarFormularios(TfrmFatDadosCliConsumidor, frmFatDadosCliConsumidor);

    {*******************************************}
    {* CARREGANDO DADOS                        *}
    {****************************************AF*}
    frmFatDadosCliConsumidor.strCodCli      := edtCodCli.Text;      // - Código
    frmFatDadosCliConsumidor.edtNomCli.Text := strCliNom;           // - Nome
    frmFatDadosCliConsumidor.edtEndere.Text := strCliEnd;           // - Endereco
    frmFatDadosCliConsumidor.edtBairro.Text := strCliBai;           // - Bairro
    frmFatDadosCliConsumidor.mskNumCep.Text := strCliCep;           // - Cep
    frmFatDadosCliConsumidor.edtCodCid.Text := strCodCid;           // - Cod. Cidade
    frmFatDadosCliConsumidor.edtNomCid.Text := strCliCid;           // - Cidade
    frmFatDadosCliConsumidor.edtEstado.Text := strCliEst;           // - Estado
    frmFatDadosCliConsumidor.mskTelCon.Text := strCliTel;           // - Telefone
    frmFatDadosCliConsumidor.mskNumCgc.Text := strCliCgc;           // - CNPJ
    frmFatDadosCliConsumidor.edtCgcCpf.Text := IntToStr(intCgcCpf); // - CGC/CPF
    frmFatDadosCliConsumidor.edtInsEst.Text := strCliIes;           // - Ins.Estadual
    frmFatDadosCliConsumidor.edtRgCli.Text  := strCli_Rg;           // - Rg
    frmFatDadosCliConsumidor.strEstado      := strCliEst;           // - Estado

    frmFatDadosCliConsumidor.showModal;

    Result := frmFatDadosCliConsumidor.blnConfirma;

    {*******************************************}
    {* DADOS ALTERADOS                         *}
    {****************************************AF*}
    If frmFatDadosCliConsumidor.blnConfirma Then
    Begin
      strCliNom := frmFatDadosCliConsumidor.edtNomCli.Text; // - Nome
      strCliEnd := frmFatDadosCliConsumidor.edtEndere.Text; // - Endereco
      strCliBai := frmFatDadosCliConsumidor.edtBairro.Text; // - Bairro
      strCliCep := frmFatDadosCliConsumidor.mskNumCep.Text; // - Cep
      strCodCid := frmFatDadosCliConsumidor.edtCodCid.Text; // - Cód. Cidade
      strCliCid := frmFatDadosCliConsumidor.edtNomCid.Text; // - Cidade
      strCliEst := frmFatDadosCliConsumidor.edtEstado.Text; // - Estado
      strCliTel := frmFatDadosCliConsumidor.mskTelCon.Text; // - Telefone
      strCliCgc := frmFatDadosCliConsumidor.mskNumCgc.Text; // - CNPJ
      strCli_Rg := frmFatDadosCliConsumidor.edtRgCli.Text;  // - RG

      If fEmptyStr(frmFatDadosCliConsumidor.edtCgcCpf.Text) Then
        intCgcCpf := 0
      Else
        intCgcCpf := StrToInt(frmFatDadosCliConsumidor.edtCgcCpf.Text); // - CGC/CPF

      strCliIes := frmFatDadosCliConsumidor.edtInsEst.Text;             // - Ins.Estadual

      edtNomCli.Text := strCliNom;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fDigDadosConsumidor]');
    End;
  End;

  pFreeAndNil(frmFatDadosCliConsumidor);
end;

procedure TfrmVendasPerdidasDig.edtCodCliEnter(Sender: TObject);
begin
  inherited;

  strCliAnt := edtCodCli.Text;
end;

procedure TfrmVendasPerdidasDig.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodigo);

  If (fPreencherDadosIniciais) Then
  Begin
    edtCodCli.Text := strCliIni;
    fValidaCampos(edtCodCli, True);
    edtSenVen.Text := strVenIni;
    fValidaCampos(edtSenVen, True);

    If (Not fEmptyStr(strProIni)) Then
    Begin
      edtCodIte.Text := strProIni;
      fValidaCampos(edtCodIte, True);
      pSetFocus(edtQtdIte);
    End
    Else
      pSetFocus(edtCodIte);
  End;
end;

procedure TfrmVendasPerdidasDig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  With cdsConsulta Do
  If (ModalResult <> mrOk) And
     (edtCodigo.ReadOnly Or (Active And (not IsEmpty))) Then
  Begin
    Action := caNone;
    pIniciaVenda;
  End;

end;

procedure TfrmVendasPerdidasDig.pExcluiVendaPerdida(strCodigo: String);
  Var
    qryGen: TUniQuery;
Begin

  qryGen := fCriaQuery;

  Try

    Try
      fStartTransaction;

      pInsereDEL_MOVVPD;
      pInsereDEL_MOVVPG;

      With qryGen, SQL Do
      Begin
        Clear;
        Add('DELETE FROM MOVVPG');
        Add('WHERE VPG_CODIGO = :CODIGO');

        ParamByName('CODIGO').AsString := strCodigo;

        ExecSQL;
        fCommit;
      End;
    Except

      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmVendasPerdidasDig.btnExcVenClick]');
        abort;
      End;

    end;

  Finally
     FreeAndNil(qryGen);
  end;

End;

procedure TfrmVendasPerdidasDig.btnExcVenClick(Sender: TObject);
begin
  inherited;

  If fPergunta('Deseja excluir a Venda Perdida?') Then
  Begin
    pExcluiVendaPerdida(strCodigo);
    pIniciaVenda;
  End;

end;

function TfrmVendasPerdidasDig.fPegaPrecoVenda(strCodIte,strCodEmp:String): String;
var fltValorUnitario : Double;
    qryPrecoVenda    : TUniQuery;
    intPreco         : Integer;
    intTabelaCliente : Integer;
    intTabelaSugestao: Integer;

    function fTabPrecoCliente(Const strCodCli: String): String;
    begin
      Result := fCampoTabela('CLI_TABPRE', 'CADCLI',
                            ['CLI_CODCLI'],
                            [strCodCli], False);

      If fEmptyStr(Result) And fCfgSis('HIETAB', VarBoolean) Then
        Result := fCampoTabela('OPE_TABPRE', 'CADOPE', ['OPE_CODOPE'], [strCodVen], False);
    end;

Begin

  intTabelaCliente  := StrToIntDef(fTabPrecoCliente( edtCodCli.Text ), 0);
  intTabelaSugestao := StrToIntDef( fCfgSis('TBPSUG'), 0);

  qryPrecoVenda := fCriaQuery(Nil);
  With qryPrecoVenda Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ITE_PREVE1, ITE_PREVE2, ITE_PREVE3, ITE_PREVE4, ITE_PREVE5, ITE_PREVE6, ITE_PREVE7 ');
    SQL.Add('  FROM ITEGER                                                                             ');
    SQL.Add(' WHERE ITE_CODITE = :CODITE                                                               ');
    SQL.Add('   AND ITE_CODEMP = :CODEMP                                                               ');
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    fltValorUnitario := 0;

    If (Not IsEmpty) Then
    Begin
      If (intTabelaCliente > 0) and (FieldByName('ITE_PREVE'+IntToStr(intTabelaCliente)).AsFloat > 0) Then
        fltValorUnitario := FieldByName('ITE_PREVE'+IntToStr(intTabelaCliente)).AsFloat
      Else If (intTabelaSugestao > 0) and (FieldByName('ITE_PREVE'+IntToStr(intTabelaSugestao)).AsFloat > 0) Then
        fltValorUnitario := FieldByName('ITE_PREVE'+IntToStr(intTabelaSugestao)).AsFloat
      Else
      Begin
        For intPreco := 1 to 7 Do
        Begin
          If FieldByName('ITE_PREVE'+IntToStr(intPreco)).AsFloat > 0 Then
          Begin
            fltValorUnitario := FieldByName('ITE_PREVE'+IntToStr(intPreco)).AsFloat;
            Break;
          End;
        End;
      End;
    End;
  End;
  FreeAndNil(qryPrecoVenda);

  Result := FormatFloat(fMskDigitos(intDecUni), fltValorUnitario);
end;

procedure TfrmVendasPerdidasDig.pInsereDEL_MOVVPD;
  Var
    qryMovVpd: TUniQuery;
Begin

  qryMovVpd := fCriaQuery(Self);

  Try
    qryMovVpd.sql.clear;
    qryMovVpd.sql.add('SELECT * FROM MOVVPD WHERE VPD_CODIGO = :CODIGO AND VPD_CODEMP = :VPD_CODEMP');
    qryMovVpd.parambyname('CODIGO').asstring := strCodigo;
    qryMovVpd.parambyname('VPD_CODEMP').asstring := VS_strCodEmp;
    qryMovVpd.open;

    While (Not qryMovVpd.eof) do
    Begin
      fVerificaIntegridade('frmVendasPerdidasDig', 'MOVVPD', qryMovVpd);
      qryMovVpd.Next;

    end;
  Finally
    FreeAndNil(qryMovVpd);
  End;

end;

procedure TfrmVendasPerdidasDig.pInsereDEL_MOVVPG;
  Var
    qryConsultaVpg: TUniQuery;
Begin

  qryConsultaVpg := fCriaQuery(Self);

  Try
    qryConsultaVpg.sql.clear;
    qryConsultaVpg.sql.add('SELECT * FROM MOVVPG WHERE VPG_CODIGO = :CODIGO AND VPG_CODEMP = :VPG_CODEMP');
    qryConsultaVpg.parambyname('CODIGO').asstring := strCodigo;
    qryConsultaVpg.parambyname('VPG_CODEMP').asstring := VS_strCodEmp;
    qryConsultaVpg.open;

    if (Not qryMovVpg.Isempty) Then
      fVerificaIntegridade('frmVendasPerdidasDig', 'MOVVPG', qryConsultaVpg);
  Finally
    FreeAndNil(qryConsultaVpg);
  End;

end;

End.


