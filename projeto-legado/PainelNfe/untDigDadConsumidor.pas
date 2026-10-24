unit untDigDadConsumidor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, cxLookAndFeelPainters, Mask, MaskEditFocus, StdCtrls,
  EditFocus, cxButtons, ExtCtrls, cxGraphics, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBExtLookupComboBox, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,

  {$IF Defined(UNIDAC)}
    Uni,
  {$ELSE}
    ZConnection, ZDataset,
  {$IFEND}

  {$IFDEF VER300}
  cxDataControllerConditionalFormattingRulesManagerDialog,
  {$ENDIF}

  StrUtils,
  cxLookAndFeels,
  cxNavigator,
  Faturamento.Classes.CNPJ;

type
  TfrmDigDadConsumidor = class(TForm)
    pnlBotoes: TPanel;
    pnlFundo: TPanel;
    btnCancelar: TcxButton;
    btnConfirma: TcxButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    lblIncEst: TLabel;
    lblRg: TLabel;
    edtNomCli: TEditFocus;
    edtEndere: TEditFocus;
    edtBairro: TEditFocus;
    mskTelCon: TMaskEditFocus;
    mskNumCep: TMaskEditFocus;
    edtCgcCpf: TEditFocus;
    edtInsEst: TEditFocus;
    edtEstado: TEditFocus;
    edtRgCli: TEditFocus;
    mskNumCgc: TMaskEditFocus;
    dbeCidade: TcxExtLookupComboBox;
    cxGridRepository: TcxGridViewRepository;
    cxGridCadCid: TcxGridDBTableView;
    cxColCodCid: TcxGridDBColumn;
    cxColNomCid: TcxGridDBColumn;
    cxColEstado: TcxGridDBColumn;
    dtsCadCid: TDataSource;
    edtEmail: TEditFocus;
    lbl1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure dbeCidadePropertiesChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCgcCpfChange(Sender: TObject);
    procedure mskNumCgcKeyPress(Sender: TObject; var Key: Char);
    procedure mskNumCgcExit(Sender: TObject);
    procedure edtCgcCpfExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    qryCadCid: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    qryCliCon: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    procedure pCarregaConsumidor;
    function fValidaCampos(Sender: TWinControl): Boolean;
    function fValidaCnpjCpf(strOpcao, strValor: String; blnPassaVazio: Boolean = True; blnPermiteDigitosIguais: Boolean = False): Boolean;
    function fValidaIES(strIES, strEstado: String): Boolean;
    function fVerificaCampos: Boolean;
    function fVerificaSubObjeto(objObjeto: TWinControl): Boolean;
    function fRetCgcCpf(strCodCli: String): String;
    function fTestaCgc(xCGC: String): Boolean;
    function fValidaCPF(sCPF: string): Boolean;
  public
    { Public declarations }
    blnConfirma: Boolean;
    strCodCli  : String;
    strCodCid  : String;
  end;

var
  frmDigDadConsumidor: TfrmDigDadConsumidor;

implementation

uses untUtil, untModulo{$IF Defined(VER250) Or Defined(VER270) Or Defined(VER280) Or Defined(VER300)}, System.UITypes{$IFEND};

{$R *.dfm}

procedure TfrmDigDadConsumidor.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDigDadConsumidor.btnConfirmaClick(Sender: TObject);
begin

  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Close;
  End;

end;

procedure TfrmDigDadConsumidor.dbeCidadePropertiesChange(Sender: TObject);
begin
  edtEstado.Text := dbeCidade.Properties.DataController.DataSet.FieldByName('CID_ESTADO').AsString;
end;

procedure TfrmDigDadConsumidor.edtCgcCpfChange(Sender: TObject);
begin
  If edtCgcCpf.Text = '1' Then
  Begin
    edtRgCli.Clear;
    edtRgCli.Enabled := False;
    edtRgCli.Visible := False;
    lblRg.Visible    := False;

    edtInsEst.Enabled := True;
    edtInsEst.Visible := True;
    edtInsEst.Left    := 102;
    edtInsEst.Width   := 173;
    lblIncEst.Visible := True;
    lblIncEst.Left    := 9;
  End
  Else
  Begin
    edtInsEst.Clear;
    edtInsEst.Enabled := False;
    edtInsEst.Visible := False;
    lblIncEst.Visible := False;

    edtRgCli.Enabled := True;
    edtRgCli.Visible := True;
    edtRgCli.Left    := 102;
    edtRgCli.Width   := 173;
    lblRg.Visible    := True;
    lblRg.Left       := 82;
  End;
end;

procedure TfrmDigDadConsumidor.edtCgcCpfExit(Sender: TObject);
begin
  If (edtCgcCpf.Text = '1') Then
    mskNumCgc.EditMask := '>aa\.aaa\.aaa/aaaa-99;0;'
  Else
    mskNumCgc.EditMask := '999.999.999-99;0;';
end;

procedure TfrmDigDadConsumidor.FormCreate(Sender: TObject);
begin
  blnConfirma := False;
  qryCadCid := fCriaQuery(Self);
  qryCliCon := fCriaQuery(Self);

  qryCadCid.Close;
  qryCadCid.SQL.Text := 'SELECT * FROM CADCID WHERE CID_ESTADO = :ESTADO ORDER BY CID_NOMCID';

  dtsCadCid.DataSet := qryCadCid;

  {$IFDEF VER300}
  dbeCidade.Style.LookAndFeel.ScrollbarMode := sbmClassic;
  {$ENDIF};
end;

procedure TfrmDigDadConsumidor.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  Case Key Of
    VK_Return: SelectNext(ActiveControl,True,True);
    VK_Escape: btnCancelar.Click;
  End;

end;

procedure TfrmDigDadConsumidor.FormShow(Sender: TObject);
begin
  qryCadCid.Close;
  qryCadCid.ParamByName('ESTADO').AsString := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_CODCID'], [strCodCid], frmModulo.Database);
  qryCadCid.Open;

  dbeCidade.EditValue := strCodCid;
  dbeCidadePropertiesChange(dbeCidade);
end;

function TfrmDigDadConsumidor.fRetCgcCpf(strCodCli: String): String;
  Var
    strSQL   : String;
    qryGenCli: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin
  Try

    qryGenCli := fCriaQuery(Self);

    Result := '';
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CLI_C_G_C_ ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCLI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

    With qryGenCli Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      Open;
      Result := FieldByName('CLI_C_G_C_').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenCli);
  End;

End;

procedure pPesquisaCadCliCon(qryTabela: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}; strCpf: String);
begin
  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Text := 'SELECT * FROM CLICON WHERE CON_C_P_F_ = :C_P_F_ ';
  qryTabela.ParamByName('C_P_F_').AsString := strCpf;
  qryTabela.Open;
end;

procedure TfrmDigDadConsumidor.pCarregaConsumidor;
begin
  pPesquisaCadCliCon(qryCliCon, mskNumCgc.Text);
  With qryCliCon Do
  Begin
    If (Not IsEmpty) And (Not fEmptyStr(FieldByName('CON_C_P_F_').AsString)) Then
    Begin
      mskNumCgc.Text := FieldByName('CON_C_P_F_').AsString;
      edtCgcCpf.Text := FieldByName('CON_CGCCPF').AsString;
      edtNomCli.Text := FieldByName('CON_NOMCON').AsString;
      edtEndere.Text := FieldByName('CON_ENDERE').AsString;
      edtBairro.Text := FieldByName('CON_BAIRRO').AsString;
      mskNumCep.Text := FieldByName('CON_C_E_P_').AsString;
      dbeCidade.EditValue := FieldByName('CON_CODCID').AsString;
      mskTelCon.Text := FieldByName('CON_FONE01').AsString;
      edtInsEst.Text := FieldByName('CON_I_E_S_').AsString;
      edtRgCli.Text  := FieldByName('CON_NUMR_G').AsString;
      {***************************************************}
      {* SE O CAMPO GER_EMLCON EXISTIR NA TABELA MOVGER, *}
      {* PEGA O E-MAIL DO CLIENTE "CONSUMIDOR"           *}
      {************************************************RV*}
      If fCampoExiste('MOVGER', 'GER_EMLCON') Then
        edtEmail.Text  := FieldByName('CON_EMLCON').AsString;

    End
    Else
    Begin
      edtNomCli.Clear;
      edtEndere.Clear;
      edtBairro.Clear;
      mskNumCep.Clear;
      dbeCidade.Clear;
      mskTelCon.Clear;
      edtInsEst.Clear;
      edtRgCli.Clear;
      edtEmail.Clear;
    End;
  End;
end;

function TfrmDigDadConsumidor.fValidaCampos(Sender: TWinControl): Boolean;
begin
  Result := True;

  If (Sender = edtNomCli) Then
  Begin
    If fEmptyStr(edtNomCli.Text) Then
    Begin
      MessageDlg('O Nome deve ser preenchido!', mtInformation, [mbOK], 0);
      Result := False;
    End;
  End

  Else If (Sender = edtEndere) Then
  Begin
    If fEmptyStr(edtEndere.Text) Then
    Begin
      MessageDlg('O Endereço deve ser preenchido!', mtInformation, [mbOK], 0);
      Result := False;
    End;
  End

  Else If (Sender = edtBairro) Then
  Begin
    If fEmptyStr(edtBairro.Text) Then
    Begin
      MessageDlg('O Bairro deve ser preenchido!', mtInformation, [mbOK], 0);
      Result := False;
    End;
  End

  Else If (Sender = mskNumCep) Then
  Begin

    If fEmptyStr(mskNumCep.Text) Then
    Begin
      MessageDlg('O CEP deve ser preenchido!', mtInformation, [mbOK], 0);
      Result := False;
    End
    Else If (Length(mskNumCep.Text) < 8) Then
    Begin
      MessageDlg('O CEP deve conter 8 digitos!', mtInformation, [mbOK], 0);
      Result := False;
    End;

    (*If (Result) And (fCfgSis('USACEP', varBoolean)) Then
    Begin

      If (Not fCadCepDadosCep(mskNumCep.Text, strCodCid, strEndere, strBairro, strNomCid,
                                                qryConCid.FieldByName('CID_ESTADO').AsString,
                                                qryConCid.FieldByName('CID_CODCOR').AsString)) Then
      Begin
        fMensagem('ATENÇÃO!', 'CEP não encontrado! Verifique.', ['&Ok']);
        Result := False;
      End
      Else
      Begin

        If (fEmptyStr(strCodCid)) Then
        Begin

          If Not fEmptyStr(fRetNomCidade(edtCodCid.Text)) Then
          Begin

            If fMensagem('ATENÇÃO!', 'O Código Correios da cidade ' + edtNomCid.Text + ' está em branco.' + #13#10 +
                         'Deseja que o mesmo seja preenchido automaticamente no Cadastro de Cidades?', ['&Sim', '&Não']) = 1 Then
            Begin
              pAtualizaCodigoCorreios(edtCodCid.Text, mskNumCep.Text);
            End

            Else Result := False;

          End Else
          Begin
            fMensagem('ATENÇÃO!', 'Esse CEP não tem nenhum endereço associado no cadastro do AutCom.' + #13#10 +
                                'Será aberto o Cadastro de Cidades para o preenchimento do Código Correios.', ['&Ok']);
            pCriarForm(TfrmCadCidades, frmCadCidades);
            Result := False;
          End;

        End
        {***********************************}
        {* CASO O CEP NÃO POSSUIR ENDERECO *}
        {********************************JB*}
        Else If (Not fEmptyStr(strNomCid)) Then
        Begin
          edtEndere.Text := fTiraCaracEspeciais(strNomCid);
          strEndere      := edtEndere.Text;
        End;

        If Result Then
        Begin

          blnAtualizar := False;

          If (Copy(strCepAnt, 0, 5) <> Copy(mskNumCep.Text, 0, 5)) Then
          Begin
            If (Not fEmptyStr(edtEndere.Text)) Then
            Begin
              If fMensagem('ATENÇÃO!', 'O CEP foi alterado, deseja atualizar o endereço?', ['&Sim', '&Não']) = 1 Then
              Begin
                blnAtualizar := True;
              End;
            End
            Else
              blnAtualizar := True;
          End;

          If fEmptyStr(edtCodCid.Text) Or (blnAtualizar) Then
          Begin
            edtCodCid.Text := strCodCid;
            pCarregaCidade;
          End;

          If fEmptyStr(edtEndere.Text) Or (blnAtualizar) Then
            edtEndere.Text := strEndere;

          If fEmptyStr(edtBairro.Text) Or (blnAtualizar) Then
            edtBairro.Text := strBairro;
        End;

      End;

      If (Result) Then
        strCepAnt := mskNumCep.Text;

    End;*)

  End

  Else If (Sender = dbeCidade) Then
  Begin

    If fEmptyStr(dbeCidade.Text) Then
    Begin
      MessageDlg('O Código da Cidade deve ser preenchido!', mtInformation, [mbOK], 0);
      Result := False;
    End;

  End

  Else If (Sender = edtCgcCpf) Then
  Begin
    If (edtCgcCpf.Text <> '1') And (edtCgcCpf.Text <> '2') Then
    Begin
      MessageDlg('O campo CGC/CPF deve ser 1 ou 2!', mtInformation, [mbOK], 0);
      Result := False;
    End;
  End

  Else If (Sender = mskNumCgc) Then
  Begin
    If fEmptyStr(mskNumCgc.Text) Then
    Begin
      If (fCfgSis('CPFOBR', varBoolean)) Then
        Result := False;
    End
    Else
    Begin
      Result := fValidaCnpjCpf(edtCgcCpf.Text, mskNumCgc.Text, False, True);
    End;
  End

  Else If (Sender = edtInsEst) And (edtInsEst.Visible) Then
  Begin
    If (Not fEmptyStr(edtInsEst.Text))                  And
       (Not fEmptyStr(dbeCidade.EditValue)) Then
    Begin
      If Not fValidaIES(edtInsEst.Text, edtEstado.Text) Then
      Begin
        MessageDlg(edtInsEst.Text + ' não é uma Inscrição Estadual válida!', mtInformation, [mbOK], 0);
        Result := False;
      End;
    End
    Else
      edtInsEst.Clear;

  End;

  If Not Result Then
    Sender.SetFocus;

end;

{*****************************************}
{* VALIDA O CNPJ OU CGC, DE ACORDO COM   *}
{* 'strOpcao'                            *}
{**************************************MV*}
function TfrmDigDadConsumidor.fValidaCnpjCpf(strOpcao, strValor: String; blnPassaVazio: Boolean = True; blnPermiteDigitosIguais: Boolean = False): Boolean;
begin
  Result := True;
  If (blnPassaVazio) And (strOpcao = '0') Then
    Exit;

  If strOpcao = '1' Then
  Begin
    Result := fTestaCgc(strValor);
    If Not Result Then
      MessageDlg(strValor + ' não é um Número de CNPJ válido!', mtInformation, [mbOK], 0);
  End
  Else If strOpcao = '2' Then
  Begin
    Result := fValidaCPF(strValor);
    If Not Result Then
      MessageDlg(strValor + ' não é um Número de CPF válido!', mtInformation, [mbOK], 0);
  End;

end;

{*****************************************}
{* VALIDA A INSCRIÇÃO ESTADUAL           *}
{**************************************MV*}
function TfrmDigDadConsumidor.fValidaIES(strIES, strEstado: String): Boolean;
  Var
    intContador : Integer;
    intValG     : Integer;
    intVSom     : Integer;
    intVRes     : Integer;
    intVPro     : Integer;
    intP        : Integer;
    intD        : Integer;
    intN        : Integer;
    strVDig1    : String;
    strVDig2    : String;
    strVBase    : String;
    strVBase2   : String;
    strBase     : String;
    strOrigem   : String;
    strMascara  : String;
    strVSom     : String;
    arrVMul     : Array Of Integer;
begin
  strVBase   := '';
  strBase    := '';
  strOrigem  := '';
  strMascara := '99999999999999';

  intP := 0;
  intD := 0;
  Result := False;
  If fEmptyStr(strIES) Then
  Begin
    Result := True;
    Exit;
  End;

  For intContador := 1 To Length(Trim(strIES)) Do
  Begin
    If Pos(strIES[intContador], '0123456789P') > 0 Then
      strOrigem := strOrigem + strIES[intContador];
  End;

  If (strEstado <> 'SP') And (LeftStr(strOrigem, 1) = 'P') Then
  Begin
    Result := TRUE;
    Exit;
  End;

  If strEstado = 'AC' Then
  Begin
    strMascara := '999,99999,999-99';
    strBase    := fPadR(strOrigem, 13, '0');

    intVSom := 0;
    SetLength(arrVMul, 12);
    arrVMul := VarArrayOf([4,3,2,9,8,7,6,5,4,3,2]);
    For intContador := 0 To 10 Do
    Begin
      intValG := StrToIntDef(strBase[intContador+1],0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes   := intVSom Mod 11;
    strVDig1  := IntToStr(IIF(11 - intVRes < 10, 11 - intVRes, 0));
    strVBase2 := LeftStr(strBase, 11) + strVDig1;

    intVSom := 0;
    SetLength(arrVMul, 0);
    SetLength(arrVMul, 12);
    arrVMul := VarArrayOf([5,4,3,2,9,8,7,6,5,4,3,2]);

    For intContador := 0 To 11 Do
    Begin
      intValG := StrToIntDef(strVBase2[intContador+1],0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes   := intVSom Mod 11;
    strVDig2  := IntToStr(IIF(11 - intVRes < 10, 11 - intVRes, 0));
    strVBase2 := strVBase2 + strVDig2;
    Result := (strVDig1 = Copy(strBase, 12, 1)) And (strVDig2 = Copy(strBase, 13, 1));
  End
  Else If strEstado = 'AL' Then
  Begin

    strMascara := '999999999';
    strBase    := fPadR(strOrigem, 9, '0');

    If LeftStr(strBase, 2) = '24' Then
    Begin
      intVSom := 0;
      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador],0);
        intValG := intValG * (10 - intContador);
        intVSom := intVSom + intValG;
      End;

      intVPro  := intVSom * 10;
      intVRes  := intVPro Mod 11;
      strVDig1 := IntToStr(IIF(intVRes = 10, 0, intVRes));
      strVBase := LeftStr(strBase, 8) + strVDig1;
      Result   := (strVBase = strOrigem);
    End;

  End
  Else If strEstado = 'AM' Then
  Begin

    strMascara := '99,999,999-9';                                             
    strBase    := fPadR(strOrigem, 9, '0');                                   
    intVSom    := 0;                                                          

    For intContador := 1 To 8 Do                                              
    Begin
      intValG := StrToIntDef(strBase[intContador],0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    If intVSom < 11 Then
      strVDig1 := IntToStr(11 - intVSom)
    Else
    Begin
      intVRes := intVSom Mod 11;
      strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11-intVRes));
    End;                                                                      

    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);



  End
  Else If strEstado = 'AP' Then
  Begin

    strMascara := '999999999';
    strBase    := fPadR(strOrigem, 9, '0');

    If LeftStr(strBase, 2) = '03' Then
    Begin
      intN := StrToIntDef(LeftStr(strBase, 8),0);
      If (intN >= 3000001) And (intN <= 3017000) Then
      Begin
        intP := 5;
        intD := 0;
      End
      Else If (intN >= 3017001) And (intN <= 3019022) Then
      Begin
        intP := 9;
        intD := 1;
      End
      Else If intN >= 3019023 Then
      Begin
        intP := 0;
        intD := 0;
      End;

      intVSom := intP;

      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador],0);
        intValG := intValG * (10 - intContador);
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := IntToStr(11 - intVRes);

      If StrToIntDef(strVDig1,0) = 10 Then
        strVDig1 := '0'
      Else If StrToIntDef(strVDig1,0) = 11 Then
        strVDig1 := IntToStr(intD);

      strVBase := LeftStr(strBase, 8) + strVDig1;
      Result := (strVBase = strOrigem);
    End;

  End
  Else If strEstado = 'BA' Then
  Begin

    strMascara := '999999-99';
    strBase    := fPadR(strOrigem, 9, '0');

    intVSom := 0;
    If Pos(strBase[1], '0123458') > 0 Then
    Begin
      For intContador := 1 To 6 Do
      Begin
        intValG := StrTointDef(strBase[intContador],0);
        intValG := intValG * (8 - intContador);
        intVSom := intVSom + intValG;
      End;

      intVRes   := intVSom Mod 10;
      strVDig2  := IntToStr(IIF(intVRes = 0, 0, 10 - intVRes));
      strVBase2 := LeftStr(strBase, 6) + strVDig2;

      intVSom := 0;

      For intContador := 1 To 7 Do
      Begin
        intValG := StrToIntDef(strVBase2[intContador],0);
        intValG := intValG * (9 - intContador);
        intVSom := intVsom + intValG;
      End;

      intVRes  := intVSom Mod 10;
      strVDig1 := IntToStr(IIF(intVRes = 0, 0, 10 - intVRes));
    End
    Else
    Begin
      For intContador := 1 To 6 Do
      Begin
        intValG := StrToIntDef(strBase[intContador], 0);
        intValG := intValG * (8 - intContador);
        intVSom := intVSom + intValG;
      End;

      intVRes   := intVSom Mod 11;
      strVDig2  := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
      strVBase2 := LeftStr(strBase, 6) + strVDig2;

      intVSom := 0;

      For intContador := 1 To 7 Do
      Begin
        intValG := StrToIntDef(strVBase2[intContador], 0);
        intValG := intValG * (9 - intContador);
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    End;

    strVBase2 := LeftStr(strBase, 6) + strVDig1 + strVDig2;
    Result    := (strVBase2 = strOrigem);
  End
  Else If strEstado = 'CE' Then
  Begin

    strMascara := '99999999-9';
    strBase    := fPadR(strOrigem, 9, '0');
    intVSom    := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(11 - intVRes);
    If StrToIntDef(strVDig1, 0) > 9 Then
      strVDig1 := '0';

    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'DF' Then
  Begin

    strMascara := '999,99999,999-99';
    strBase    := fPadR(strOrigem, 13, '0');

    If LeftStr(strBase, 2) = '07' Then
    Begin
      intVSom := 0;
      SetLength(arrVMul, 12);
      arrVMul := VarArrayOf([4,3,2,9,8,7,6,5,4,3,2]);
      For intContador := 0 To 10 Do
      Begin
        intValG := StrToIntDef(strBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes   := intVSom Mod 11;
      strVDig1  := IntToStr(IIF(11 - intVRes < 10, 11 - intVRes, 0));
      strVBase2 := LeftStr(strBase, 11) + strVDig1;

      intVSom := 0;
      SetLength(arrVMul, 0);
      SetLength(arrVMul, 12);
      arrVMul := VarArrayOf([5,4,3,2,9,8,7,6,5,4,3,2]);

      For intContador := 0 To 11 Do
      Begin
        intValG := StrToIntDef(strVBase2[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes   := intVSom Mod 11;
      strVDig2  := IntToStr(IIF(11 - intVRes < 10, 11 - intVRes, 0));
      strVBase2 := strVBase2 + strVDig2;
      Result := (strVDig1 = Copy(strBase, 12, 1)) And (strVDig2 = Copy(strBase, 13, 1));
    End;
  End
  Else If strEstado = 'ES' Then
  Begin
    strMascara := '999999999';
    strBase    := fPadR(strOrigem, 9, '0');
    intVSom    := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVsom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);
  End
  Else If strEstado = 'GO' Then
  Begin

    strMascara := '99,999,999-9';
    strBase    := fPadR(strOrigem, 9, '0');

    If Pos(LeftStr(strBase, 2), '10.11.15') > 0 Then
    Begin
      intVSom := 0;
      arrVMul := VarArrayOf([9,8,7,6,5,4,3,2]);

      For intContador := Low(arrVMul) To High(arrVMul) Do
      Begin
        intVSom := intVSom + (StrToIntDef(strBase[intContador+1], 0) * arrVMul[intContador]); 
      End;

      intVRes := intVSom Mod 11;

      //Quando a inscrição for 11094402 o dígito verificador pode ser zero (0) e pode ser um (1);
      If (LeftStr(strBase, 8) = '11094402') Then
      Begin
        If (Pos(RightStr(strBase, 1), '01') > 0) Then
          Result := True
        Else
          Result := False;

        Exit;
      End
      Else If (intVRes = 0) Then
      BEgin
        strVDig1 := '0'
      End
      Else If (intVRes = 1) Then
      Begin

        intN := StrToIntDef(LeftStr(strBase, 8), 0);
        strVDig1 := IIF((intN >= 10103105) And (intN <= 10119997), 1, 0);

      End
      Else
      Begin
        strVDig1 := IntToStr(11 - intVRes);
      End;

{      For intContador := 1 To 8 Do
      Begin
        intValG := StrToInt(strBase[intContador]);
        intValG := intValG + (10 * intContador);
        intVsom := intVSom + intValG;
      End;

      intVRes := intVSom Mod 11;

      If intVRes = 0 Then
        strVDig1 := '0'
      Else If intVRes = 1 Then
      Begin
        intN     := StrToInt(LeftStr(strBase, 8));
        strVDig1 := IIF((intN >= 10103105) And (intN <= 10119997), 1, 0);
      End
      Else
        strVDig1 := IntToStr(11 - intVRes);}

      strVBase := LeftStr(strBase, 8) + strVDIg1;
      Result   := (strVBase = strOrigem);
    End;

  End
  Else If strEstado = 'MA' Then
  Begin

    strMascara := '999999999';
    strBase    := fPadR(strOrigem, 9, '0');

    If LeftStr(strBase, 2) = '12' Then
    Begin
      intVSom := 0;

      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador], 0);
        intValG := intValG * (10 - intContador);
        intVSom := intVSom + intValG;
      End;

      intVRes   := intVSom Mod 11;
      strVDig1  := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
      strVBase  := LeftStr(strBase, 8) + strVDig1;
      Result    := (strVBase = strOrigem);
    End;

  End
  Else If strEstado = 'MT' Then
  Begin

    {strMascara := '9999999999-9';
    strBase    := fPadR(strOrigem, 10, '0');
    intVSom    := 0;
    SetLength(arrVMul, 10);
    arrVMul := VarArrayOf([3,2,9,8,7,6,5,4,3,2]);

    For intContador := 0 To 9 Do
    Begin
      intValG := StrToInt(strBase[intContador+1]);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(11 - intVRes);

    If StrToInt(strVDig1) > 9 Then
      strVDig1 := IntToStr(StrToInt(strVDig1) - 10);

    strVBase := LeftStr(strBase, 10) + strVDig1;
    Result   := (strVBase = strOrigem);}

    strMascara := '999999999';
    strBase := fPadR(strOrigem, 9, '0');
    intVSom := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    intVRes := intVSom Mod 11;
    strVDig1 := IntToStr(IIF(intVRES < 2, 0, 11 - intVRes));
    strVBase2 := LeftStr(strBase, 8) + strVDig1;

    Result := (strVBase2 = strOrigem);

  End
  Else If strEstado = 'MS' Then
  Begin

    strMascara := '999999999';
    strBase    := fPadR(strOrigem, 9, '0');

    If (LeftStr(strBase, 2) = '28') Or (LeftStr(strBase, 2) = '50') Then
    Begin
      intVSom := 0;
      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador], 0);
        intValG := intValG * (10 - intContador);
        intVSom := intVSom + intValG; 
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
      strVBase := LeftStr(strBase, 8) + strVDig1;
      Result   := (strVBase = strOrigem);
    End;

  End
  Else If strEstado = 'MG' Then
  Begin

    strMascara := '999,999,999/9999';
    strBase    := fPadR(strOrigem, 13, '0');
    strVBase2  := LeftStr(strBase, 3) + '0' + Copy(strBase, 4, 8);
    intN       := 2;
    strVSom    := '';

    For intContador := 1 To 12 Do
    Begin
      intValG := StrToIntDef(strVBase2[intContador], 0);
      intN    := IIF(intN = 2, 1, 2);
      intValG := intValG * intN;
      strVSom := strVSom + IntToStr(intValG);
    End;

    intN := 0;
    For intContador := 1 To Length(strVSom) Do
      intN := intN + StrToIntDef(strVSom[intContador],0);

    intVSom := intN;
    While RightStr(IntToStr(intN), 1) <> '0' Do
    Begin
      Inc(intN);
    End;

    strVDig1 := IntToStr(intN - intVSom);
    strVBase := leftStr(strBase, 11) + strVDig1;

    intVSom := 0;
    SetLength(arrVMul, 12);
    arrVMul := VarArrayOf([3,2,11,10,9,8,7,6,5,4,3,2]);
    For intContador := 0 To 11 Do
    Begin
      intValG := StrToIntDef(strVBase[intContador+1], 0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig2 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := strVBase + strVDig2;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'PA' Then
  Begin

    strMascara := '99-999999-9';
    strBase    := fPadR(strOrigem, 9, '0');

    If pos(LeftStr(strBase, 2), '15_75_') > 0 Then
    Begin
      intVSom := 0;

      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador], 0);
        intValG := intValG * (10 - intContador);
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
      strVBase := LeftStr(strBase, 8) + strVDig1;
      Result   := (strVBase = strOrigem);
    End;

  End
  Else If strEstado = 'PB' Then
  Begin

    strMascara := '99,999,999-9';
    strBase    := fPadR(strOrigem, 9, '0');
    intVSom    := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(11 - intVRes);

    If StrToIntDef(strVDig1, 0) > 9 Then
      strVDig1 := '0';

    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'PE' Then
  Begin

    // VALIDAÇÃO DA INSCRICAO ESTADUAL ANTIGA - 14 dígitos
    If length(strIES) > 9 Then
    Begin
      strMascara := '99,9,999,9999999-9';
      strBase    := fPadR(strOrigem, 14, '0');
      intVSom    := 0;
      Setlength(arrVMul, 13);
      arrVMul := VarArrayOf([5,4,3,2,1,9,8,7,6,5,4,3,2]);

      For intContador := 0 To 12 Do
      Begin
        intValG := StrToIntDef(strBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := IntToStr(11 - intVRes);

      If StrToIntDef(strVDig1, 0) > 9 Then
        strVDig1 := IntToStr(StrToIntDef(strVDig1, 0) - 10);

      strVBase := LeftStr(strBase, 13) + strVdig1;
      Result := (strVBase = strOrigem);
    End
    Else
    // VALIDAÇÃO DA INSCRICAO ESTADUAL NOVA - 9 dígitos
    Begin
      strMascara := '9999999-99';
      strBase    := fPadR(strOrigem, 9, '0');
      intVSom    := 0;
      Setlength(arrVMul, 7);
      arrVMul := VarArrayOf([8,7,6,5,4,3,2]);

      For intContador := 0 To 6 Do
      Begin
        intValG := StrToIntDef(strBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;

      If (intVRes = 1) Or (intVRes = 0) Then
        strVDig1 := '0'
      Else
        strVDig1 := IntToStr(11 - intVRes);

      strBase    := fPadR(strOrigem, 9, '0');
      intVSom    := 0;
      Setlength(arrVMul, 8);
      arrVMul := VarArrayOf([9,8,7,6,5,4,3,2]);

      For intContador := 0 To 7 Do
      Begin
        intValG := StrToIntDef(strBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;

      If (intVRes = 1) Or (intVRes = 0) Then
        strVDig2 := '0'
      Else
        strVDig2 := IntToStr(11 - intVRes);

      strVBase := LeftStr(strBase, 7) + strVDig1 + strVDig2;
      Result := (strVBase = strOrigem);
    End;
  End
  Else If strEstado = 'PI' Then
  Begin

    strMascara := '999999999';
    strBase    := fPadR(strOrigem, 9, '0');
    intVSom    := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'PR' Then
  Begin

    strMascara := '999,99999-99';
    strBase    := fPadR(strOrigem, 10, '0');
    intVSom    := 0;
    SetLength(arrVMul, 8);
    arrVMul := VarArrayOf([3,2,7,6,5,4,3,2]);

    For intContador := 0 To 7 Do
    Begin
      intValG := StrToIntDef(strBase[intContador+1], 0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := LeftStr(strBase, 8) + strVDig1;

    intVSom := 0;
    SetLength(arrVMul, 0);
    SetLength(arrVMul, 9);
    arrVMul := VarArrayOf([4,3,2,7,6,5,4,3,2]);

    For intContador := 0 To 8 Do
    Begin
      intValG := StrToIntDef(strVBase[intContador+1], 0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig2 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := strVBase + strVdig2;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'RJ' Then
  Begin

    strMascara := '99,999,99-9';
    strBase    := fPadR(strOrigem, 8, '0');
    intVSom    := 0;
    SetLength(arrVMul, 7);
    arrVMul := VarArrayOf([2,7,6,5,4,3,2]);

    For intContador := 0 To 6 Do
    Begin
      intValG := StrToIntDef(strBase[intContador+1], 0);
      intValG := intValG * arrVMul[intContador];
      intVSom  := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := LeftStr(strBase, 7) + strVDig1;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'RN' Then
  Begin

    strMascara := '99,999,999-9';
    strBase    := fPadR(strOrigem, 9, '0');

    If LeftStr(strBase, 2) = '20' Then
    Begin
      intVSom := 0;
      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador], 0);
        intValG := intValG * (10 - intContador);
        intVSom := intVSom + intValG;
      End;
      intVPro  := intVSom * 10;
      intVRes  := intVPro Mod 11;
      strVDig1 := IntToStr(IIF(intVRes > 9, 0, intVres));
      strVBase := LeftStr(strBase, 8) + strVDig1;
      Result   := (strVBase = strOrigem);
    End;
  End
  Else If strEstado = 'RO' Then
  Begin

    strMascara := '9999999999999-9';
    strBase    := fPadR(strOrigem, 14, '0');
    intVSom    := 0;
    arrVMul := VarArrayOf([6,5,4,3,2,9,8,7,6,5,4,3,2]);

    For intContador := Low(arrVMul) To High(arrVMul) Do
    Begin
      intValG := StrToIntDef(strBase[intContador+1], 0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(11 - intVRes);

    If StrToIntDef(strVDig1, 0) > 9 Then
      strVDig1 := IntToStr(StrToIntDef(strVDig1, 0) - 10);

    strVBase := LeftStr(strBase, 13) + strVDig1;
    Result   := (strVbase = strOrigem);

  End
  Else If strEstado = 'RR' Then
  Begin

    strMascara := '99999999-9';
    strBase    := fPadR(strOrigem, 9, '0');

    If LeftStr(strBase, 2) = '24' Then
    Begin
      intVSom := 0;
      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador], 0);
        intValG := intValG * intContador;
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 9;
      strVDig1 := IntToStr(intVRes);
      strVBase := LeftStr(strBase, 8) + strVDig1;
      Result   := (strVBase = strOrigem);

    End;

  End
  Else If strEstado = 'RS' Then
  Begin

    strMascara := '999/999999-9';
    strBase    := fPadL(strOrigem, 10, '0');

    intVSom := 0;
    SetLength(arrVMul, 9);
    arrVMul := VarArrayOf([2,9,8,7,6,5,4,3,2]);

    For intContador := 0 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador+1], 0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(11 - intVRes);

    If StrToIntDef(strVDig1, 0) > 9 Then
      strVDig1 := '0';

    strVBase := LeftStr(strBase, 9) + strVDig1;
    Result   := (strVBase = fPadL(strOrigem, 10, '0'));

  End
  Else If strEstado = 'SC' Then
  Begin

    strMascara := '999,999,999';
    strBase    := fPadR(strOrigem, 9, '0');
    intVSom    := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'SE' Then
  Begin

    strMascara := '99999999-9';
    strBase    := fPadR(strOrigem, 9, '0');
    intVSom    := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(11 - intVRes);
    If StrToIntDef(strVDig1, 0) > 9 Then
      strVDig1 := '0';

    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'SP' Then
  Begin

    intVSom := 0;
    If LeftStr(strOrigem, 1) = 'P' Then
    Begin
      strMascara := 'P-99999999,9/999';
      strBase    := fPadR(strOrigem, 13, '0');
      strVBase   := Copy(strBase, 2, 8);
      SetLength(arrVMul, 8);
      arrVMul := VarArrayOf([1,3,4,5,6,7,8,10]);

      For intContador := 0 To 7 Do
      Begin
        intValG := StrToIntDef(strVBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := RightStr(IntToStr(intVRes), 1);
      strVBase := LeftStr(strBase, 9) + strVDig1 + Copy(strBase, 11, 3);
    End
    Else
    Begin
      strMascara := '999,999,999,999';
      strBase    := fPadR(strOrigem, 12, '0');
      SetLength(arrVMul, 8);
      arrVMul := VarArrayOf([1,3,4,5,6,7,8,10]);

      For intContador := 0 To 7 Do
      Begin
        intValG := StrToIntDef(strBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := RightStr(IntToStr(intVRes), 1);
      strVBase := LeftStr(strBase, 8) + strVDig1 + Copy(strBase, 10,2);
      intVSom  := 0;
      SetLength(arrVMul, 11);
      arrVMul  := VarArrayOf([3,2,10,9,8,7,6,5,4,3,2]);

      For intContador := 0 To 10 Do
      Begin
        intValG := StrToIntDef(strVBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig2 := RightStr(IntToStr(intVRes), 1);
      strVBase := strVBase + strVDig2;

    End;
    Result := (strVBase = strOrigem);

  End
  Else If strEstado = 'TO' Then
  Begin

    strMascara := '99 999999 9';
    strBase    := fPadR(strOrigem, 09, '0');

    intVSom := 0;
    For intContador := 9 DownTo 2 Do
    Begin
      intVSom := intVSom + (StrToIntDef(strBase[10-intContador], 0) * intContador);
    End;
    intVRes := intVSom Mod 11;

    If intVRes < 2 Then
      strVDig1 := '0'
    Else
      strVDig1 := IntToStr(11 - intVRes);

    Result := (RightStr(strBase, 1) = strVDig1)

{    If Pos(Copy(strBase, 3, 2), '01.02.03.99') > 0 Then
    Begin
      strVBase := LeftStr(strBase, 2) + Copy(strBase, 5, 6);
      intVSom  := 0;


      For intContador := 1 To 8 Do
      Begin
        intValG := StrToInt(strVBase[intContador]);
        intValG := intValG * (10 - intContador);
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
      strVBase := LeftStr(strBase, 10) + strVDig1;
      Result   := (strVBase = strOrigem);
    End;}
  End
  Else
  Begin
    MessageDlg('Unidade Federal Inválida!', mtInformation, [mbOK], 0);
  End;

end;

function TfrmDigDadConsumidor.fVerificaCampos: Boolean;
begin
  Result := fVerificaSubObjeto(Self);
end;

{*********************************}
{* VERIFICA TODOS OS COMPONENTES *}
{* DENTRO DE PANEL OU SCROLLBOX  *}
{* (RECURSIVO)                   *}
{******************************AF*}
function TfrmDigDadConsumidor.fVerificaSubObjeto(objObjeto: TWinControl): Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  For intContador := 0 To objObjeto.ComponentCount -1 Do
  Begin
    {**********************************}
    {* SE O COMPONETE FOR UM PANEL,   *}
    {* UM SCROLLBOX OU TABSHEET       *}
    {*******************************AF*}
    If (objObjeto.Components[intContador] Is TPanel)     Or
       (objObjeto.Components[intContador] Is TScrollBox) Or
       (objObjeto.Components[intContador] Is TGroupBox)  Then
    Begin
      Result := fVerificaSubObjeto((objObjeto.Components[intContador] As TWinControl));

      If Not Result Then
        Exit;

    End
    Else
    Begin
      {**************************************}
      {* SE A TAG DO COMPONENTES = 99 ENTÃO *}
      {***********************************AF*}
      If (objObjeto.Components[intcontador].Tag = 99) And
         (objObjeto.Components[intContador] Is TWinControl) Then
      Begin
        Result := fValidaCampos((objObjeto.Components[intContador] As TWinControl));
      End;

      If Not Result Then
        Exit;
    End;

  End;

end;

procedure TfrmDigDadConsumidor.mskNumCgcExit(Sender: TObject);
begin
  If (Not fEmptyStr(fTiraCaracEspeciais(mskNumCgc.Text))) And (fRetCgcCpf(strCodCli) <> fTiraCaracEspeciais(mskNumCgc.Text)) Then
    pCarregaConsumidor;
end;

procedure TfrmDigDadConsumidor.mskNumCgcKeyPress(Sender: TObject;
  var Key: Char);
begin
  If (edtCgcCpf.Text = '0') Or (fEmptyStr(edtCgcCpf.Text)) Then
    Key := #0;
end;

{*********************************}
{* VALIDA CGC                    *}
{*********************************}
function TfrmDigDadConsumidor.fTestaCgc(xCGC: String):Boolean;
begin
  Result := TCNPJ.fTestaCNPJ(xCGC, fCfgSis('NWCNPJ', varBoolean));
end;

{*********************************}
{* VALIDA CPF                    *}
{*********************************}
function TfrmDigDadConsumidor.fValidaCPF(sCPF: string):Boolean;
var
   sDigs, sVal  : string;
   iSTot, iSTot2: integer;
   i: integer;
begin
  Result := False;
  sCPF   := Trim(AnsiReplaceText(sCPF, '.', ''));
  sCPF   := Trim(AnsiReplaceText(sCPF, '-', ''));
  iSTot  := 0;
  iSTot2 := 0;
  If Length(sCPF) = 11 Then
  begin
    For i := 9 Downto 1 Do
    Begin
      iSTot  := iSTot  + StrToIntDef(Copy(sCPF,i,1),0) * (11-i);
      iSTot2 := iSTot2 + StrToIntDef(Copy(sCPF,i,1),0) * (12-i);
    End;
    iSTot  := iSTot Mod 11;
    sDigs  := sDigs + IntToStr(iif(iSTot < 2, 0, 11-iSTot));

    iSTot2 := iSTot2 + 2*StrToIntDef(sDigs,0);
    isTot2 := iSTot2 Mod 11;
    sDigs  := sDigs + IntToStr(iif(iSTot2 < 2, 0, 11-iSTot2));

    sVal   := Copy(sCPF,10,2);
    Result := sDigs = sVal;
  End;
end;

end.
