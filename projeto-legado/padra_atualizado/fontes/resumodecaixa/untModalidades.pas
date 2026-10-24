{***************************************}
{* ATENÇÃO AO MEXER NESTA UNIT ALTERAR *}
{* A UNTRCXCONFCUPOMMODAL POIS É       *}
{* EQUIVALENTE                         *}
{************************************AF*}
unit untModalidades;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, ComboBoxFocus,
  Grids, DBGridCitel, DBGrids, DB, UniClientDataSet, Mask, DBCtrls, Uni, EditFocus,
  CurrencyEditFocus, DBEditFocus, MaskEditFocus, untTypesSistema,
  AppEvnts, StrUtils, MaskUtils, untConstantes, untFiscal, untFuncoesSimples,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Datasnap.DBClient, cxTextEdit, cxCurrencyEdit, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmModalidades = class(TfrmPai)
    pnlGrid: TPanel;
    cbxModalidades: TComboBoxFocus;
    dtsModalidades: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    Shape4: TShape;
    StaticText1: TStaticText;
    Panel3: TPanel;
    Shape5: TShape;
    StaticText5: TStaticText;
    Panel4: TPanel;
    Shape6: TShape;
    StaticText2: TStaticText;
    Panel5: TPanel;
    Shape7: TShape;
    StaticText3: TStaticText;
    Label1: TLabel;
    dbePago: TDBEditFocus;
    lblValCompra: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Panel6: TPanel;
    dbgModalidades: TDBGridCitel;
    Label2: TLabel;
    edtValor: TCurrencyEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cdsModalidades: TUniClientDataSet;
    cdsModalidadesVALOR: TFloatField;
    cdsModalidadesTROCO: TFloatField;
    cdsModalidadesRESTANTE: TFloatField;
    cdsModalidadesDESMOD: TStringField;
    cdsModalidadesECF_CODMOD: TStringField;
    cdsModalidadesECF_IDENTI: TStringField;
    cdsModalidadesCALC_RESTANTE: TFloatField;
    cdsModalidadesAGG_PAGO: TAggregateField;
    memAviso: TMemo;
    cdsModalidadesARQUIVOTEF: TStringField;
    lblValRestante: TLabel;
    lblValTroco: TLabel;
    mskCgcCpf: TMaskEditFocus;
    lblCpf: TLabel;
    cdsModalidadesECF_INFADI: TStringField;
    chkEndEnt: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgModalidadesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cdsModalidadesAfterDelete(DataSet: TDataSet);
    procedure cbxModalidadesExit(Sender: TObject);
    procedure mskCgcCpfExit(Sender: TObject);
    procedure cdsModalidadesAfterPost(DataSet: TDataSet);
  private
    { Private declarations }

    strSessaoTef : String;
    strPatIni           : String;
    strCodEcf           : String;

    fltValPag           : Double;
    qryEcfMod           : TUniQuery;

    optTroco : TOperacaoTroco;   // CHEQUE A VISTA
    optTrocoPre: TOperacaoTroco; // CHEQUE PRÉ
    optTrocoCar: TOperacaoTroco; // CARTAO

    stlModalidade       : TStringList;
    stlDesMod           : TStringList; 
    stlImpVencimento    : TStringList;
    blnPrimeiraVendaTEF : Boolean;

    intSemaforoConfirma: Integer;

    function fRetornaValorTotalPago:Double;
//    function fRetornaMaiorValorTotalPago:Double;
    function fTemModalidadeFaturado(Var fltTotFat: Double): Boolean;
    function fImprimeCupom: Boolean;
    function fRetVencimentos(strConPag: String;
      dtaDtaEnt: TDateTime): String;

    function fImprimeEnderecoEntregaNova(strDesMod: String; objFiscal: TFiscalBrd;
      strNumCOO: String; cdsModali: TUniClientDataSet; qryItens: TUniQuery): Boolean;
    Function fImprimeDadosGarantia: Boolean;      
    procedure pImprimeModalidadesSintetizadas(objFiscal: TFiscalBrd; arrParametros: Array Of TObject);

    procedure pConfirma;

  public
    { Public declarations }
    fltValDin: Double;
    fltValCqV: Double;
    fltValCqP: Double;
    fltValCar: Double;
    fltFatura: Double;
    fltTotal : Double;
    fltOutros: Double;
    fltTroco_: Double;
    strNomArq: String;
    strNumCcf: String;
    strNumCoo: String;
    strNumSer: String;
    strSeqGer: String;
    strConPag: String;
    dtaDtaEnt: TDateTime;
    blnF10Automatico: Boolean;

    arrDuplicOri : Array[0..23] Of TArrDigDuplic;

    strTabelaGer: String;

    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodCli: String;
    strSerie : String;

    function fSetaModalidade(strCodMod: String): Boolean;
    procedure pFechaCupom;

  protected
    procedure pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState); Override;
    procedure pEscapePressed; Override;

  end;

var
  frmModalidades: TfrmModalidades;

implementation

uses untFuncoes, untFuncoesGenerica, untFunTef, untCarnePagto,
     untPafGerais,untImpDadosGarantia, untImpressorCupom, untDuplicatas, untLogTef;

{$R *.dfm}

procedure TfrmModalidades.FormCreate(Sender: TObject);
  Const
    ARR_MODALIDADES : Array[1..5] Of String[10] = ('Dinheiro','Cheque-Pré','Cartão','Cheque','Faturado');
  Var
    intCont: Integer;
    IntIndex: Integer;
begin
  inherited;

  TLogTef.blnExcedeuTempoTEF := False;

  intSemaforoConfirma := -1;

  strPatIni := fCfgSis('DIRINI');
  strCodEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', strPatIni + '/opcoes_fiscal.ini' );

  For intCont := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intCont] Is TDBEditFocus) Then
      (Self.Components[intCont] As TDBEditFocus).OnKeyDown := pOnKeyDownEdits

    Else If (Self.Components[intCont] Is TEditFocus) Then
      (Self.Components[intCont] As TEditFocus).OnKeyDown := pOnKeyDownEdits

    Else If (Self.Components[intCont] Is TCurrencyEditFocus) Then
      (Self.Components[intCont] As TCurrencyEditFocus).OnKeyDown := pOnKeyDownEdits;

  End;

  qryEcfMod := fCriaQuery(Self);

  stlModalidade    := TStringList.Create;
  stlImpVencimento := TStringList.Create;
  stlDesMod        := TStringList.Create;

  If (fCfgSis('USACUP', varBoolean)) Then
  Begin

    With qryEcfMod Do
    Begin
      Close;
      SQL.Clear;

      SQL.Add('SELECT ');
      SQL.Add('  F.FPG_CODIGO, ');
      SQL.Add('  F.FPG_DESCRI, ');
      SQL.Add('  E.ECF_DESMOD, ');
      SQL.Add('  IFNULL(FE.ECF_CODMOD, "01") AS ECF_CODMOD, ');
      SQL.Add('  IFNULL(E.ECF_IDENTI, "1") AS ECF_IDENTI, ');
      SQL.Add('  IFNULL(E.ECF_INFADI, "N") AS ECF_INFADI ');
      SQL.Add('FROM ');
      SQL.Add('  CADFPG F ');
      SQL.Add('JOIN FPGECF FE ON FE.FPG_CODIGO = F.FPG_CODIGO ');
      SQL.Add('JOIN ECFMOD E ON E.ECF_CODECF = FE.ECF_CODECF AND ');
      SQL.Add('                 E.ECF_CODEMP = FE.ECF_CODEMP AND ');
      SQL.Add('                 E.ECF_CODMOD = FE.ECF_CODMOD AND ');
      SQL.Add('                 E.ECF_CODECF = :CODECF ');
      SQL.Add('WHERE ');
      SQL.Add('  F.FPG_MOSMOD = "S" AND ');
      SQL.Add('  F.FPG_STATUS = "A" AND ');
      SQL.Add('  F.FPG_CODIGO <> "009" ');

      ParamByName('CODECF').AsString := strCodEcf;
      Open;

      While Not Eof Do
      Begin
        cbxModalidades.Items.Add(FieldByName('ECF_CODMOD').AsString + ' - ' + FieldByName('FPG_DESCRI').AsString);
        stlDesMod.Add(FieldByName('ECF_DESMOD').AsString);
        stlModalidade.Add(FieldByName('ECF_IDENTI').AsString);
        stlImpVencimento.Add(FieldByName('ECF_INFADI').AsString);
        Next;
      End;

    End;

  End
  Else
  Begin

    For intIndex := Low(ARR_MODALIDADES) to High(ARR_MODALIDADES) do
    Begin
      cbxModalidades.Items.Add(IntToStr(intIndex) + ' - ' + String(ARR_MODALIDADES[intIndex]));
      stlModalidade.Add(IntToStr(intIndex));
      stlDesMod.Add(IntToStr(intIndex));
      stlImpVencimento.Add('N');
    End;

  End;

  cbxModalidades.ItemIndex := 0;

  lblValCompra.Caption := FloatToStrF(fltTotal, ffFixed, 12, 2);

  cdsModalidades.CreateDataSet;
  ModalResult := mrNone;

  fltValDin := 0;
  fltValCqV := 0;
  fltValCqP := 0;
  fltValCar := 0;
  fltFatura := 0;
  fltOutros := 0;
  fltTroco_ := 0;

  blnPrimeiraVendaTEF  := True;

  lblValRestante.Caption := FloatToStrF(0, ffFixed, 12, 2);
  lblValTroco.Caption    := FloatToStrF(0, ffFixed, 12, 2);

  lblValRestante.Caption := lblValCompra.Caption;
  edtValor.Text := lblValRestante.Caption;

  strSessaoTef := '';
end;

procedure TfrmModalidades.FormShow(Sender: TObject);
begin
  inherited;

  lblValCompra.Caption := FloatToStrF(fltTotal, ffFixed, 12, 2);
  lblValRestante.Caption := lblValCompra.Caption;
  edtValor.Text := lblValRestante.Caption;

  Try
    If (mskCgcCpf.Visible) Then
      pSetFocus(mskCgcCpf);
  Except
    //
  End;

end;

procedure TfrmModalidades.edtValorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If Key = '-' Then
    Key := #0;

end;

procedure TfrmModalidades.edtValorExit(Sender: TObject);
  Var
    shiftState  : TShiftState;
    Ky          : Word;

    strIdeMod   : String;
    strDesMod   : String;
    strInfAdi   : String;

    fltValDig   : Double;
    fltTotDig   : Double;
    intQtdMod   : Integer;

    strValorTEF : String;
    blnExcluiTEF: Boolean;
    blnUltCartao: Boolean;
    strArqRet: String;
begin
  inherited;

  {*******************************************}
  {* VERIFICA SE O USUÁRIO NÃO DEIXOU O      *}
  {* VAL0R EM BRANCO OU DEIXOU IGUAL A ZERO  *}
  {****************************************RL*}
  fltValDig := 0;
  fltTroco_ := 0;

  If (Not fEmptyStr(edtValor.Text)) Then
    fltValDig := fFormataFloat(fStrToFloat(edtValor.Text), 2);

  If (fltValDig <= 0) Then
  Begin
    pSetFocus(edtValor);
    Exit;
  End;

  If (fCfgSis('TEFEXC', varBoolean)) And (TLogTef.blnExcedeuTempoTEF) Then
  Begin
    fMensagem('ATENÇÃO!', MSG_TEF_EXCEDEU_TEMPO, ['&OK']);
    Exit;
  End;

  {*******************************************}
  {* PEGA CODIGO IDENTI                      *}
  {****************************************WI*}
  strIdeMod := stlModalidade.Strings[cbxModalidades.ItemIndex];
  strDesMod := stlDesMod.Strings[cbxModalidades.ItemIndex];
  strInfAdi := stlImpVencimento.Strings[cbxModalidades.ItemIndex];

  {*******************************************}
  {* CALCULA TOTAL DIGITADO                  *}
  {****************************************WI*}
  fltTotDig := IIF( TAggregateField(cdsModalidades.FieldByName('AGG_PAGO')).Value = Null, 0.00, TAggregateField(cdsModalidades.FieldByName('AGG_PAGO')).Value);
  fltTotDig := fltTotDig + fltValDig;

  {*******************************************}
  {* RETORNA MAIOR VALOR PAGO E PEGA TAMBEM  *}
  {* A QUANTIDADE DE MODALIDADES DIGITADA    *}
  {****************************************WI*}
  intQtdMod := cdsModalidades.RecordCount;

  {*******************************************}
  {* VALIDA TROCO                            *}
  {****************************************WI*}
  If (fFormataFloat(fltTotDig,2) > fFormataFloat(fltTotal,2)) Then
  Begin

    {*******************************************}
    {* -> TRAVA TROCO PARA < CARTAO >          *}
    {****************************************WI*}
    If (strIdeMod = '3') Then
    Begin
      If (fFormataFloat(fltValDig,2) > fFormataFloat(fltTotal,2)) Then
      Begin
        fMensagem('', 'O valor para modalidade CARTÃO' +#13 +
                      'não pode ultrapassar  o  valor' +#13 +
                      'total da compra.', ['&Ok']);
        pSetFocus(edtValor);
        Exit;
      End
      Else
      Begin
        fMensagem('', 'Não permitido troco para CARTÃO.', ['&Ok']);
        pSetFocus(edtValor);
        Exit;
      End;

    End
    {*******************************************}
    {* -> TRAVA TROCO PARA < CHEQUE >          *}
    {****************************************WI*}
    Else If (strIdeMod = '4') Then
    Begin

      If (fFormataFloat(fltValDig,2) > fFormataFloat(fltTotal,2)) Then
      Begin
        fMensagem('', 'O valor para modalidade CHEQUE' +#13 +
                      'não pode ultrapassar  o  valor' +#13 +
                      'total da compra.', ['&Ok']);
        pSetFocus(edtValor);
        Exit;
      End
      Else
      Begin
        fMensagem('', 'Não permitido troco para CHEQUE.', ['&Ok']);
        pSetFocus(edtValor);
        Exit;
      End;

    End

    {*******************************************}
    {* -> TRAVA TROCO PARA < CHEQUE PRE >      *}
    {****************************************WI*}
    Else If (strIdeMod = '2') Then
    Begin

      If (fFormataFloat(fltValDig,2) > fFormataFloat(fltTotal,2)) Then
      Begin
        fMensagem('', 'O valor para modalidade CHEQUE-PRÉ' +#13 +
                      'não pode ultrapassar o valor total' +#13 +
                      'da compra.', ['&Ok']);
        pSetFocus(edtValor);
        Exit;
      End
      Else
      Begin
        fMensagem('', 'Não permitido troco para CHEQUE-PRÉ.', ['&Ok']);
        pSetFocus(edtValor);
        Exit;
      End;

    End

    {*******************************************}
    {* -> TRAVA TROCO PARA < FATURADO >        *}
    {****************************************WI*}
    Else If (strIdeMod = '5') Then
    Begin

      If (fFormataFloat(fltValDig,2) > fFormataFloat(fltTotal,2)) Then
      Begin
        fMensagem('', 'O valor para modalidade VENDA A' +#13 +
                      'PRAZO não  pode  ultrapassar  o' +#13 +
                      'valor total da compra.', ['&Ok']);
        pSetFocus(edtValor);
        Exit;
      End
      Else
      Begin
        fMensagem('', 'Não permitido troco para VENDA A PRAZO.', ['&Ok']);
        pSetFocus(edtValor);
        Exit;
      End;

    End

    {**************************************}
    {* TRAVA SE HOUVER OUTRA MODALIDADE   *}
    {***********************************AF*}
    Else If intQtdMod >= 1 Then
    Begin
      fMensagem('', 'Não permitido troco pois existem modalidades que não permitem.', ['&Ok']);
      pSetFocus(edtValor);
      Exit;
    End;

    {*******************************************}
    {* -> CALCULA TROCO                        *}
    {****************************************RL*}
    If (fFormataFloat(fltTotDig,2) >= fFormataFloat(fltTotal,2) ) Then
    Begin
      fltTroco_  := (fltTotDig - fltTotal);
      lblValTroco.Caption := FloatToStrF(fltTroco_, ffFixed, 12, 2);
    End;
  End
  Else
  Begin
    lblValTroco.Caption := FloatToStrF(fltTroco_, ffFixed, 12, 2);
  End;

  If (fltTroco_ > 0) Then
  Begin
    lblValTroco.Font.Color := clBlack;
    StaticText3.Font.Color := clBlack;
    Shape7.Brush.Color     := clRed;
    StaticText3.Color      := clRed;
    lblValTroco.Color      := clRed;
  End
  Else
  Begin
    lblValTroco.Font.Color := clWhite;
    StaticText3.Font.Color := clWhite;
    Shape7.Brush.Color     := clGray;
    StaticText3.Color      := clGray;
    lblValTroco.Color      := clGray;
  End;

  {*******************************************}
  {* -> CALCULA VR. RESTANTE                 *}
  {****************************************RL*}
  If (fFormataFloat(fltTotDig,2) <= fFormataFloat(fltTotal,2) ) Then
    lblValRestante.Caption := FloatToStrF((fltTotal - fltTotDig), ffFixed, 12, 2)
  Else
    lblValRestante.Caption := '0,00';

  {*******************************************}
  {* ADICIONA MODALIDADE                     *}
  {****************************************RL*}
  With cdsModalidades Do
  Begin
    blnExcluiTEF := False;

    {*******************************************}
    {* -> ADICIONA REGISTRO                    *}
    {****************************************RL*}
    Insert;
    FieldByName('VALOR').AsFloat       := fltValDig;
    FieldByName('DESMOD').AsString     := strDesMod; //Copy(cbxModalidades.Text, 5, Length(cbxModalidades.Text));
    FieldByName('ECF_CODMOD').AsString := Copy(cbxModalidades.Text, 1, 2);
    FieldByName('ECF_IDENTI').AsString := strIdeMod;
    FieldByName('ECF_INFADI').AsString := strInfAdi;
    Post;

    If (VS_strUsaTef = 'S') Then
    Begin
      {*******************************************}
      {* PEDE TELA DIGITACAO TEF ( CARTAO )      *}
      {****************************************RL*}
      If (strIdeMod = '3') Then
      Begin
        strValorTEF := FloatToStrF(fltValDig, ffFixed, 12, 2);
        strValorTEF := fTiraCaracter(strValorTEF);

        blnUltCartao := False;
        If (fltTotDig - fltTotal >= 0) Then
          blnUltCartao := True;

        Self.Enabled := False;

        If Not VS_objTef.fTef_Crt(strValorTEF, blnPrimeiraVendaTEF, blnUltCartao, strArqRet) Then
        Begin
          Self.Enabled := True;
          cdsModalidades.Delete;
          blnExcluiTEF := True;
        End;

        Self.Enabled := True;
        SetForegroundWindow(Handle);

        blnPrimeiraVendaTEF := False;
      End
      {*******************************************}
      {* PEDE TELA DIGITACAO TEF ( 4-CHEQUE ) E  *}
      {* ( 2-CHEQUE PRE )                        *}
      {****************************************RL*}
      {Else If (Pos(strIdeMod, '24') > 0) Then
      Begin
        strArqTEF   := '';
        strValorTEF := FloatToStrF(fltValDig, ffFixed, 12, 2);
        strValorTEF := fTiraCaracter(strValorTEF);

        Self.Enabled := False;
        If Not VS_objTef.fTef_Chq(strValorTEF, blnPrimeiraVendaTEF, strArqTEF) Then
        Begin
          Self.Enabled := True;
          cdsModalidades.Delete;
          blnExcluiTEF := True;
        End
        Else
        Begin
          Edit;
          FieldByName('ARQUIVOTEF').AsString := strArqTEF;
          Post;
        End;
        Self.Enabled := True;
        SetForegroundWindow(Handle);

        blnPrimeiraVendaTEF := False;
      End};
    End;

    {*******************************************}
    {* TOTALIZA VARIAVEIS DE MODALIDADES       *}
    {****************************************RL*}
    If (Not blnExcluiTEF) Then
    Begin
      If (strIdeMod = '1') Then
        fltValDin := fltValDin + fltValDig

      Else If (strIdeMod = '3') Then
        fltValCar := fltValCar + fltValDig

      Else If (strIdeMod = '4') Then
        fltValCqV := fltValCqV + fltValDig

      Else If (strIdeMod = '2') Then
        fltValCqP := fltValCqP + fltValDig

      Else If (strIdeMod = '5') Then
        fltFatura := fltFatura + fltValDig

      Else
        fltOutros := fltOutros + fltValDig

    End;

  End;

  {*******************************************}
  {* CALCULA VALOR TOTAL PAGO                *}
  {****************************************RL*}
  fltValPag := fRetornaValorTotalPago;

  If blnF10Automatico Then
    pSetFocus(cbxModalidades);

  edtValor.Clear;
  edtValor.Text := lblValRestante.Caption;

  {*******************************************}
  {* CASO O VALOR PAGO SEJA MAIOR OU IGUAL AO*}
  {* VALOR DA COMPRA                         *}
  {****************************************RL*}
  If (fFormataFloat(fltValPag, 2) >= fFormataFloat(fltTotal, 2)) And
     (blnF10Automatico)                                          Then
  Begin
    edtValor.Enabled := False;
    pSetFocus(dbgModalidades);

    Ky := VK_F10;
    FormKeyDown(Self, Ky, ShiftState);
  End;

  chkEndEnt.Visible := (fCfgSis('CUPEET') = 'S');

  If Not chkEndEnt.Visible Then
    chkEndEnt.Checked := FALSE
  Else
    chkEndEnt.Checked := (fCfgSis('CHKENT', varString) = 'S');

end;

{*******************************************}
{* RETORNA VALOR TOTAL PAGO                *}
{****************************************RL*}
function TfrmModalidades.fRetornaValorTotalPago:Double;
  Var
    intRecno: Integer;
Begin
  Result   := 0;

  intRecno := cdsModalidades.RecNo;
  cdsModalidades.DisableControls;

  cdsModalidades.First;
  While (Not cdsModalidades.Eof) Do
  Begin
    Result := Result + cdsModalidades.FieldByName('VALOR').AsFloat;

    cdsModalidades.Next;
  End;

  cdsModalidades.RecNo := intRecno;
  cdsModalidades.EnableControls;
end;

{*******************************************}
{* RETORNA MAIOR VALOR PAGO                *}
{****************************************RL*}
{function TfrmModalidades.fRetornaMaiorValorTotalPago: Double;
  Var
    intRecno: Integer;
Begin
  Result := 0;

  intRecno := cdsModalidades.RecNo;
  cdsModalidades.DisableControls;

  cdsModalidades.First;
  While (Not cdsModalidades.Eof) Do
  Begin

    If (cdsModalidades.FieldByName('VALOR').AsFloat > Result) Then
      Result := cdsModalidades.FieldByName('VALOR').AsFloat;

    cdsModalidades.Next;
  End;

  cdsModalidades.RecNo := intRecno;
  cdsModalidades.EnableControls;
end;                }


procedure TfrmModalidades.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  If ((VS_strUsaTef = 'S') And (cdsModalidades.Locate('ECF_IDENTI', '3',[])) ) Then
  Begin
    Action := caNone;
    Exit;
  End
  Else
  Begin

    If ((VS_strUsaTef = 'S') And (cdsModalidades.Locate('ECF_IDENTI', '2',[])    Or
                                  cdsModalidades.Locate('ECF_IDENTI', '4',[])) ) Then
    Begin
      VS_objTef.pDelArqRet;
    End;

  End;
  
  FreeAndNil(stlModalidade);
  FreeAndNil(stlDesMod);

  inherited;

end;

procedure TfrmModalidades.pEscapePressed;
  Var
    OnExit: TNotifyEvent;
begin

  If ((ActiveControl) = cbxModalidades) Then
    inherited

  Else If (ActiveControl) <> cbxModalidades Then
  Begin
    OnExit          := edtValor.OnExit;
    edtValor.OnExit := Nil;
    pSetFocus(cbxModalidades);
    edtValor.OnExit := OnExit;
  End;

end;

procedure TfrmModalidades.pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  If (Key = VK_Return) Then
  Begin

    If Sender Is TDBEditFocus Then
      pProximoControle(Sender)

    Else If Sender Is TEditFocus Then
      pProximoControle(Sender)

    Else If Sender Is TCurrencyEditFocus Then
      pProximoControle(Sender);

  End
  Else If (Key = VK_Escape) Then
    pEscapePressed;

end;

function TfrmModalidades.fTemModalidadeFaturado(Var fltTotFat: Double): Boolean;
Begin
  Result := cdsModalidades.Locate('ECF_IDENTI','5',[]);

  If Result Then
    fltTotFat := cdsModalidades.fieldByName('VALOR').AsFloat
  Else
    fltTotFat := 0;

End;

procedure TfrmModalidades.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    OnExitEditV: TNotifyEvent;
    OnExitCombo: TNotifyEvent;
begin
  inherited;

  If Not Self.Enabled Then
  Begin
    Key := 0;
    Exit;
  End;

  {*******************************************}
  {* [ F5 ]                                  *}
  {****************************************RL*}
  If Key = Vk_F5 Then
  Begin
    OnExitEditV := edtValor.OnExit;
    OnExitCombo := cbxModalidades.OnExit;

    edtValor.OnExit       := Nil;
    cbxModalidades.OnExit := Nil;

    pSetFocus(dbgModalidades);

    edtValor.OnExit       := OnExitEditV;
    cbxModalidades.OnExit := OnExitCombo;
  End
  {*******************************************}
  {* [ F10 ]                                 *}
  {****************************************RL*}
  Else If Key = Vk_F10 Then
  Begin

    Key := 0;

    pConfirma;

  End;

end;

procedure TfrmModalidades.dbgModalidadesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = Vk_Delete) And (Not cdsModalidades.IsEmpty) Then
  Begin

    {*******************************************}
    {* SÓ PERMITE EXCLUIR MODALIDADES DIFERENTE*}
    {* CARTAO E CHEQUE                         *}
    {****************************************RL*}
    If (Not (VS_strUsaTef = 'S')) Or
       ((VS_strUsaTef = 'S') And (Pos(cdsModalidades.FieldByName('ECF_IDENTI').AsString, '3') <= 0)) Then
    Begin

      If (Pos(cdsModalidades.FieldByName('ECF_IDENTI').AsString, '24') > 0) Then
        DeleteFile(cdsModalidades.FieldByName('ARQUIVOTEF').AsString);

      If      (cdsModalidades.FieldByName('ECF_IDENTI').AsString = '1') Then
        fltValDin := fltValDin - cdsModalidades.FieldByName('VALOR').AsFloat

      Else If (cdsModalidades.FieldByName('ECF_IDENTI').AsString = '3') Then
        fltValCar := fltValCar - cdsModalidades.FieldByName('VALOR').AsFloat

      Else If (cdsModalidades.FieldByName('ECF_IDENTI').AsString = '4') Then
        fltValCqV := fltValCqV - cdsModalidades.FieldByName('VALOR').AsFloat

      Else If (cdsModalidades.FieldByName('ECF_IDENTI').AsString = '2') Then
        fltValCqP := fltValCqP - cdsModalidades.FieldByName('VALOR').AsFloat

      Else If (cdsModalidades.FieldByName('ECF_IDENTI').AsString = '5') Then
        fltFatura := fltFatura - cdsModalidades.FieldByName('VALOR').AsFloat

      Else
        fltOutros := fltOutros - cdsModalidades.FieldByName('VALOR').AsFloat;

      cdsModalidades.Delete;
      fltValPag := fRetornaValorTotalPago;
      lblValRestante.Caption := FloatToStrF(fltTotal - fltValPag, ffFixed, 12, 2);
      edtValor.Value         := fltTotal - fltValPag;

    End;

    edtValor.Enabled := True;

  End
  Else If (Key = Vk_Return) Or (Key = Vk_Escape) Then
    pSetFocus(cbxModalidades)

end;

procedure TfrmModalidades.cdsModalidadesAfterDelete(DataSet: TDataSet);
begin
  inherited;

  If fltValPag < fltTotal Then
  Begin
    edtValor.Enabled := True;

    If Not cdsModalidades.IsEmpty Then
      pSetFocus(dbgModalidades)
    Else
      pSetFocus(cbxModalidades);
  End;

end;

procedure TfrmModalidades.cdsModalidadesAfterPost(DataSet: TDataSet);
begin
  inherited;
  chkEndEnt.Visible := (fCfgSis('CUPEET') = 'S');
end;

procedure TfrmModalidades.cbxModalidadesExit(Sender: TObject);
  Var
    intRegistro: Integer;
    strIdeMod  : String;
begin
  inherited;

  memAviso.Visible := False;

  If Not edtValor.Enabled Then
    Exit;

  {*******************************************}
  {* PEGA CODIGO IDENTI                      *}
  {****************************************WI*}
  If (cbxModalidades.ItemIndex < 0) Then
    Exit;
    
  strIdeMod := stlModalidade.Strings[cbxModalidades.ItemIndex];

  {*******************************************}
  {* PARA IDENTI <> CARTAO NAO PODE EXISTIR  *}
  {* MAIS DE UMA MODALIDADE                  *}
  {****************************************WI*}
  If (strIdeMod <> '3') Then
  Begin
    cdsModalidades.DisableControls;
    intRegistro := cdsModalidades.RecNo;

    If (cdsModalidades.Locate('ECF_IDENTI', strIdeMod, [])) Then
    Begin
      memAviso.Visible := True;
      pSetFocus(cbxModalidades);
    End;

    cdsModalidades.RecNo := intRegistro;
    cdsModalidades.EnableControls;
  End;

end;

procedure TfrmModalidades.mskCgcCpfExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(mskCgcCpf.Text)) Then
  Begin

    If Not fValidaCnpjCpf(IIF(lblCpf.Caption = 'CPF:','2','1'), mskCgcCpf.Text, True, True) Then
      pSetFocus(mskCgcCpf);

  End;
end;

{************************************}
{* EFETUA IMPRESSAO DO CUPOM FISCAL *}
{*********************************AF*}
function TfrmModalidades.fImprimeCupom: Boolean;
  Var
    qryGen   : TUniQuery;
    fltValMod: Double;
    fltFatDiv: Double;
    fltTotGerSav: Double;
    fltPreMod: Double;
    fltDifMod: Double;
    strSQL   : String;
    strInfAdi: String;
    strDesMod: String;
    strModAtu: String;
    cdsModAux: TUniClientDataSet;
    impressorCupom: TImpressorCupom;
    strBarCon : String;
    objCarnePagto : TCarnePagamento;
Begin

  Result := False;

  If (Not VS_blnTesTef) And (VS_objFiscal.fStatusImpressora <> '1') Then
  Begin
    fMensagem('', 'Não foi possível comunicar com impressora!', ['&Ok']);
    Exit;
  End;

  If VS_strUsaPaf = 'S' Then
  Begin
    If (Not fComparaNumeroSerieGrandeTotal) Then
    Begin
      Exit;
    End;
  End;

  Try

    cdsModAux := TUniClientDataSet.Create(Self);
    Self.Enabled := False;

    Try

      qryGen := fCriaQuery(Nil);

      With qryGen Do
      Begin

        {*****************************************}
        {* PEGA CUPOM DA VENDA                   *}
        {**************************************AF*}
        strSQL := '';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   DET_NUM_PD, ';
        strSQL := strSQL + '   DET_CODITE, ';
        strSQL := strSQL + '   CONCAT(IF(DET_IDEPRO <> "NOR", CONCAT(DET_IDEPRO, " - "), ""), DET_DESCRI) AS DET_DESCRI, ';
        strSQL := strSQL + '   DET_UNIDAD, ';
        strSQL := strSQL + '   DET_QTDITE, ';
        strSQL := strSQL + '   DET_UNITAR, ';
        strSQL := strSQL + '   DET_PREEMB, ';
        strSQL := strSQL + '   DET_PROEMB, ';
        strSQL := strSQL + '   DET_CODFIS, ';
        strSQL := strSQL + '   DET_ALQICM, ';
        strSQL := strSQL + '   DET_DESESP, ';
        strSQL := strSQL + '   DET_IDEPRO, ';
        strSQL := strSQL + '   DET_TOTITE  ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + '   ' + strNomArq + ' ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   DET_SEQGER = :SEQGER ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('SEQGER').AsString := strSeqGer;
        Open;

        If IsEmpty Then
          fMensagem('', 'Não foi encontrado nenhum Item para Impressão do Cupom!' , ['&Ok'])
        Else
          Result := True;

      End;

      If VS_blnTesTef Then
      Begin

        If (VS_strUsaTef = 'S') Then
        Begin
          If Not VS_objTef.fTefFinRet Then
          Begin
            {************************************}
            {* -> VERIFICA CNC / NCN            *}
            {*********************************WI*}
            VS_objTef.pVerificaCncNcn;
          End;
        End;

      End
      Else
      Begin
        If Result Then
        Begin
          impressorCupom := TImpressorCupomNovo.Create(VS_objFiscal, pImprimeModalidadesSintetizadas);
          Try
            impressorCupom.pImprimirCupom(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie);
          Finally
            FreeAndNil(impressorCupom);
          End;

          {*****************************************}
          {* MARCA COMO JA FATURADO                *}
          {**************************************NC*}
          strNumCcf := VS_objFiscal.fNumeroCCF;
          strNumCoo := VS_objFiscal.fRetornaCOO;
          strNumSer := VS_objFiscal.fNumeroSerie;

          pMarcaCupomImpresso(strSeqGer, strNumDoc, strEspDoc, strCodEmp, strCodCli,
                              strSerie, strNumSer, strNumCoo, strNumCcf, strTabelaGer);

          {***************************************}
          {* CRIA OS AGGREGATES                  *}
          {************************************AF*}
          cdsModAux.AggregatesActive := True;
          With TAggregateField.Create(Self) Do
          Begin
            Name          := 'TOT_VALOR';
            FieldName     := 'TOT_VALOR';
            DataSet       := cdsModAux;
            Expression    := 'SUM(VALOR)';
            Active        := True;
          End;

          {*****************************************}
          {* FAZ UMA COPIA DA ESTRUTURA            *}
          {**************************************AF*}
          cdsModAux.Data := cdsModalidades.Data;
          cdsModAux.EmptyDataSet;

          fltTotGerSav := fltTotal;
          fltFatDiv:=0;

          cdsModalidades.First;
          While Not cdsModalidades.Eof Do
          Begin

            strModAtu := cdsModalidades.FieldByName('ECF_CODMOD').AsString;
            strDesMod := Trim(cdsModalidades.FieldByName('DESMOD').AsString);
            fltValMod := 0.0;
            strInfAdi := cdsModAux.FieldByName('ECF_INFADI').AsString;

            While (Not cdsModalidades.Eof) And (strModAtu = cdsModalidades.FieldByName('ECF_CODMOD').AsString) Do
            Begin
              fltValMod := fltValMod + cdsModalidades.FieldByName('VALOR').AsFloat;
              cdsModalidades.Next;
            End;

            {*****************************************}
            {* AJUSTE DAS MODALIDADES                *}
            {**************************************RN*}
            fltFatDiv := fltTotGerSav / fltTotal; // fStrToFloat(edtTotGer.Text)  * conferir esse total
            fltPreMod := fFormataFloat(fltValMod * fltFatDiv, 2);

            cdsModAux.Append;
            cdsModAux.FieldByName('ECF_CODMOD').AsString := strModAtu;
            cdsModAux.FieldByName('DESMOD').AsString := strDesMod;
            cdsModAux.FieldByName('ECF_INFADI').AsString := strInfAdi;
            cdsModAux.FieldByName('VALOR').AsFloat       := fltPreMod;
            cdsModAux.Post;
          End;

          {*****************************************}
          {* TERMINO DE AJUSTE DAS MODALIDADES     *}
          {**************************************RN*}
          cdsModAux.First;
          fltPreMod := cdsModAux.AggFields.FieldByName('TOT_VALOR').Value;

          If (optTroco    In [otNada, otCredito]) And
             (optTrocoPre In [otNada, otCredito]) And
             (optTrocoCar In [otNada, otCredito]) Then
            fltPreMod := fltPreMod - fFormataFloat(fltTroco_ * fltFatDiv, 2);

          fltDifMod := fltTotGerSav - fltPreMod;

          If fltDifMod <> 0 Then
          Begin
            cdsModAux.Edit;
            cdsModAux.FieldByName('VALOR').AsFloat := cdsModAux.FieldByName('VALOR').AsFloat + fltDifMod;
            cdsModAux.Post;
          End;

          {**************************************}
          {* FINALIZA TEF                       *}
          {***********************************AF*}
          If (VS_strUsaTef = 'S') Then
          Begin
            If Not VS_objTef.fTefFinRet Then
            Begin
              {************************************}
              {* -> VERIFICA CNC / NCN            *}
              {*********************************WI*}
              VS_objTef.pVerificaCncNcn;
            End;
          End;

          If chkEndEnt.Checked And chkEndEnt.Visible Then
          Begin
            fImprimeEnderecoEntregaNova(strDesMod, VS_objFiscal, strNumCOO, cdsModAux, qryGen);
          End;

          If fCfgSis('IMPGAR',varBoolean) Then
            fImprimeDadosGarantia;

          If (fCfgSis('SISCRE', VarBoolean)) And (fCfgSis('IMPCAR', VarBoolean)) And
             (fCfgSis('ESPCAR', VarString) <> '2') Then
          Begin
            strBarCon := fCampoTabela('CTR_BARCON', 'CADREC', ['CTR_NUMDUP', 'CTR_ESPDOC', 'CTR_CODEMP', 'CTR_CODCLI'], [strNumDoc, strEspDoc, strCodEmp, strCodCli]);

            If (Not fEmptyStr(strBarCon)) Then
            Begin
              objCarnePagto := TCarnePagamento.Create(nil, strBarCon);
              Try
                objCarnePagto.fImprimirContrato;
                objCarnePagto.fImprimirCarneRecibo;
              Finally
                FreeAndNil(objCarnePagto);
              End;
            End;
          End;

          {*******************************************}
          {* ABRE GAVETA                             *}
          {****************************************MV*}
          If fCfgSis('ABRGAV', varBoolean) Then
            VS_objFiscal.fAbreGaveta;
          
        End
        Else
        Begin
          Result := False;

          If (VS_strUsaTef = 'S') Then
            VS_objTef.pVerificaCncNcn;

        End;
      End;

      cdsModalidades.EmptyDataSet;
      Close;

    Except
      On E: EAbort Do
      Begin
        Result := False;

        If (Not VS_blnTesTef) And (E.HelpContext <> ERRO_ABERTURA_CUPOM) Then
          VS_objFiscal.fCancelaCupom;

        If (VS_strUsaTef = 'S') Then
            VS_objTef.pVerificaCncNcn;

      End;

      On E: Exception Do
      Begin
        Result := False;

        If Not VS_blnTesTef Then
          VS_objFiscal.fCancelaCupom;

        If (VS_strUsaTef = 'S') Then
            VS_objTef.pVerificaCncNcn;

        pMensagensErro('Houve um erro na impressão do cupom!' + #13#10 + E.Message,
                       '[Impressão de Cupom]');
      End;
    End;

  Finally

    Self.Enabled := True;
    FreeAndNil(cdsModAux);
    FreeAndNil(qryGen);
    SetForegroundWindow(Handle);

  End;

End;

function TfrmModalidades.fImprimeDadosGarantia: Boolean;
  Var
    objImpGar: TImpDadosGarantia;
begin
  objImpGar := TImpDadosGarantia.Create(Self);
  Result    := objImpGar.fImprimirGarantia(strNumDoc, 'IF', strCodEmp, strCodCli);

  FreeAndNil(objImpGar);
end;

function TfrmModalidades.fImprimeEnderecoEntregaNova(strDesMod: String;
  objFiscal: TFiscalBrd; strNumCOO: String; cdsModali: TUniClientDataSet; qryItens: TUniQuery): Boolean;
Var
    intContador: Integer;

    strLinItem: String;
    strCGCCPF: String;
    strIESCli: String;
    strRG_Cli: String;

    strModali: string;
    strDescMo: String;

    fltModVal: Double;
    fltTotPro: Double;
    fltDesEsp: Double;

    stlMen001: TStringList;
    stlMen002: TStringList;

    arrDuplicata: TarrDuplicata;

  Procedure pMensagemVinculado(strMensagem: String);
    Var
      stlMensagem: TStringList;
      intContador: Integer;
  Begin
    stlMensagem := TStringList.Create;
    stlMensagem.Text := strMensagem;

    If Not fEmptyStr(strMensagem) Then
    Begin
      VS_objFiscal.fRelatorioGerencial(fPadR( '', 48));
      For intContador := 0 To stlMensagem.Count - 1 Do
        VS_objFiscal.fRelatorioGerencial(fPadR( stlMensagem[intContador], 48 ));
    End;

    FreeAndNil(stlMensagem);
  End;
begin
  pZeraDigDuplic(arrDuplicata);

  Result := FALSE;

  If Not VS_objFiscal.fAbreRelatorioGerencial Then
    Exit;

  stlMen001 := TStringList.Create;
  stlMen002 := TStringList.Create;

//  If Not fEmptyStr(objFiscal.strMen001) Then stlMen001.Text := WrapText(fatVenda.strMen001, 45);
//  If Not fEmptyStr(fatVenda.strMen002) Then stlMen002.Text := WrapText(fatVenda.strMen002, 45);

  If Pos('-', objFiscal.strCepEntCli) = 0 Then  objFiscal.strCepEntCli := FormatMaskText('99999-999;0;_', objFiscal.strCepEntCli);

  strCGCCPF := fFormataCpfCgc(objFiscal.strCgcCpf, fSetaPais);
  strIESCli := objFiscal.strIesCli;
  strRG_Cli := objFiscal.strRG_Cli;

  If Pos('/', strCGCCPF) > 0 Then
  Begin
    strCGCCPF := 'CNPJ: ' + strCGCCPF;
    strIESCli := 'IES.: ' + strIESCli;
  End
  Else
  Begin
    strCGCCPF := 'CPF: ' + strCGCCPF;
    strIESCli := 'RG.: ' + strRG_Cli;
  End;

  VS_objFiscal.fRelatorioGerencial(fPadR('', 48, '-'));

  If fCfgSis('IMPCAC', varBoolean) Then
    VS_objFiscal.fRelatorioGerencial(fPadC('Cupom Fiscal: ' + objFiscal.strNumDoc + '-IF' ,48))
  Else
    VS_objFiscal.fRelatorioGerencial(fPadC('COO Cupom Fiscal: ' + strNumCOO, 48));
  
  VS_objFiscal.fRelatorioGerencial(fPadC('DADOS DO CLIENTE',48));
  VS_objFiscal.fRelatorioGerencial(fPadR( LeftStr( objFiscal.strNomCli, 31 ) + '-' + objFiscal.strCodCli, 48 ));
  VS_objFiscal.fRelatorioGerencial(fPadR(  objFiscal.strEndCli + ' - ' + objFiscal.strBaiCli, 48 ));
  VS_objFiscal.fRelatorioGerencial(fPadR('CEP: ' +  objFiscal.strCepCli + ' - ' + objFiscal.strCidCli + '-' + objFiscal.strEstCli, 48 ));
  VS_objFiscal.fRelatorioGerencial(fPadR( strCGCCPF + ' - ' + strIESCli, 48 ));

  VS_objFiscal.fRelatorioGerencial(fPadR('', 48, '-'));
  VS_objFiscal.fRelatorioGerencial(fPadC('ENDERECO DE ENTREGA',48));

  If fEmptyStr(objFiscal.strEndEntCli) Then
  Begin
    VS_objFiscal.fRelatorioGerencial(fPadR( objFiscal.strEndCli + ' - ' + objFiscal.strBaiCli, 48 ));
    VS_objFiscal.fRelatorioGerencial(fPadR('CEP: ' + objFiscal.strCepCli + ' - ' + objFiscal.strCidCli + '-' + objFiscal.strEstCli, 48 ));
  End Else
  Begin
    VS_objFiscal.fRelatorioGerencial(fPadR( objFiscal.strEndEntCli + ' - ' + objFiscal.strBaiEntCli, 48 ));
    VS_objFiscal.fRelatorioGerencial(fPadR('CEP: ' + objFiscal.strCepEntCli + ' - ' + objFiscal.strCidEntCli + '-' + objFiscal.strEstEntCli, 48 ));
  End;

  If fCfgSis('IMPDCE', varBoolean) Then
  Begin
    VS_objFiscal.fRelatorioGerencial(fPadR('', 48, '-'));
    VS_objFiscal.fRelatorioGerencial(fPadC('ITENS DO CUPOM',48));
    VS_objFiscal.fRelatorioGerencial(fPadR('ITEM CÓDIGO DESCRIÇÃO QTD.UN.UNIT(R$)  TOTAL(R$)', 48));
    VS_objFiscal.fRelatorioGerencial(fPadR('', 48, '-'));

    fltDesEsp:=0;
    fltTotPro:=0;
    intContador:=0;

    qryItens.First;
    While Not qryItens.Eof Do
    Begin

      strLinItem := '';
      strLinItem := strLinItem + fStrZero(intContador+1, 3) + ' ';
      strLinItem := strLinItem +  qryItens.FieldByName('DET_CODITE').AsString + ' ';
      strLinItem := strLinItem + fPadR(qryItens.FieldByName('DET_DESCRI').AsString, 38);

      VS_objFiscal.fRelatorioGerencial(fPadR( strLinItem, 48 ));

      strLinItem := fPadR('', 5);
      strLinItem := strLinItem + fPadL(fFloatToStrVirgula(qryItens.FieldByName('DET_QTDITE').AsFloat, 6, 2), 08);
      strLinItem := strLinItem + fRetSiglaUnidadeIF(qryItens.FieldByName('DET_UNIDAD').AsString) + ' x ';
      strLinItem := strLinItem + fPadR(fFloatToStrVirgula(qryItens.FieldByName('DET_UNITAR').AsFloat, 7, 3), 12);
      strLinItem := strLinItem + fPadL(fFloatToStrVirgula(qryItens.FieldByName('DET_TOTITE').AsFloat, 8, 2), 15);

      VS_objFiscal.fRelatorioGerencial(fPadR( strLinItem, 48 ));

      fltDesEsp := fltDesEsp + qryItens.FieldByName('DET_DESESP').AsFloat;
      fltTotPro := fltTotPro + qryItens.FieldByName('DET_TOTITE').AsFloat;

      qryItens.Next;
      Inc(intContador);
    End;

    If fltDesEsp > 0 Then
    Begin
      VS_objFiscal.fRelatorioGerencial(fPadR( 'Subtotal R$' + fPadL(fFloatToStrVirgula(fltTotPro, 8, 2), 37), 48 ));
      VS_objFiscal.fRelatorioGerencial(fPadR( 'Desconto   ' + fPadL(fFloatToStrVirgula(-fltDesEsp, 8, 2), 37), 48 ));
    End;

    VS_objFiscal.fRelatorioGerencial(fPadR( 'Total R$   ' + fPadL(fFloatToStrVirgula(fltTotal, 8, 2), 37), 48 ));

    cdsModali.First;
    While Not cdsModali.Eof Do
    Begin

      strModali := cdsModali.FieldByName('ECF_CODMOD').AsString;
      strDescMo := Trim(cdsModali.FieldByName('DESMOD').AsString);
      fltModVal := 0.0;

      While (Not cdsModali.Eof) And (strModali = cdsModali.FieldByName('ECF_CODMOD').AsString) Do
      Begin
        fltModVal := fltModVal + cdsModali.FieldByName('VALOR').AsFloat;
        cdsModali.Next;
      End;

      strLinItem := fPadR(strDescMo, 30);
      strLinItem := strLinItem + fPadL(fFloatToStrVirgula(fltModVal, 8, 2), 18);

      VS_objFiscal.fRelatorioGerencial(fPadR( strLinItem, 48 ));

    End;
  End;

  VS_objFiscal.fRelatorioGerencial(fPadR('', 48, '-'));

  VS_objFiscal.fRelatorioGerencial(fPadC('CONDICAO DE PAGAMENTO',48));
  VS_objFiscal.fRelatorioGerencial(fPadR('VENCIMENTO VALOR DA PARCELA', 48 ));

  fDigDuplic(arrDuplicata, strConPag, 0, fltTotal, False, False, False, VS_Date, False);
  
  For intContador := 0 to 23 Do
    arrDuplicata[intContador].curValor := arrDuplicOri[intContador].curValor;

  For intContador := 0 to 23 Do
    With arrDuplicata[intContador] Do
    If curValor > 0 Then
      VS_objFiscal.fRelatorioGerencial(fPadR(dtaDtaVen + '  ' + FloatToStrF( curValor, ffFixed, 12, 2 ), 48 ))
    Else
      Break;

  If (fStatusCndPag(objFiscal.strFormaPgtoVinculado) <> A_VISTA) Then
    pMensagemVinculado(fCfgSisL('MPRAF8'))
  Else
    pMensagemVinculado(fCfgSisL('MVISF8'));

  If (stlMen001.Count > 0) Or (stlMen002.Count > 0) Then
  Begin
    VS_objFiscal.fRelatorioGerencial(fPadR( '', 48 ));

    For intContador := 0 To stlMen001.Count -1 Do
      VS_objFiscal.fRelatorioGerencial(fPadR( stlMen001[intContador], 48 ));

    For intContador := 0 To stlMen002.Count -1 Do
      VS_objFiscal.fRelatorioGerencial(fPadR( stlMen002[intContador], 48 ));
  End;

  VS_objFiscal.fRelatorioGerencial(fPadR( '', 48 ));
  VS_objFiscal.fRelatorioGerencial(fPadR( '', 48 ));
  VS_objFiscal.fRelatorioGerencial(fPadR( '', 48 ));
  VS_objFiscal.fRelatorioGerencial(fPadC( '____________________________________', 48 ));
  VS_objFiscal.fRelatorioGerencial(fPadC( 'Assinatura', 48 ));

  If Not VS_objFiscal.fFechaRelatorioGerencial Then
    Exit;
  
  Result := TRUE;
end;

procedure TfrmModalidades.pImprimeModalidadesSintetizadas(objFiscal: TFiscalBrd; arrParametros: Array Of TObject);
  var
    cdsModAux : TUniClientDataSet;
    strInfAdi : String;
begin

  cdsModAux := TUniClientDataSet.Create(Self);

  Try
    cdsModAux.Data := cdsModalidades.Data;
    cdsModAux.EmptyDataSet;
    cdsModAux.IndexFieldNames := 'ECF_CODMOD';

    cdsModalidades.First;
    While Not cdsModalidades.Eof do
    Begin

      If cdsModAux.FindKey([cdsModalidades.FieldByName('ECF_CODMOD').AsString]) Then
      Begin
        cdsModAux.Edit;
        cdsModAux.FieldByName('VALOR').AsFloat := cdsModAux.FieldByName('VALOR').AsFloat + cdsModalidades.FieldByName('VALOR').AsFloat;
      End
      Else
      Begin
        cdsModAux.Append;
        cdsModAux.FieldByName('ECF_CODMOD').AsString := cdsModalidades.FieldByName('ECF_CODMOD').AsString;
        cdsModAux.FieldByName('DESMOD').AsString     := cdsModalidades.FieldByName('DESMOD').AsString;
        cdsModAux.FieldByName('VALOR').AsFloat       := cdsModalidades.FieldByName('VALOR').AsFloat;
        cdsModAux.FieldByName('ECF_INFADI').AsString := cdsModalidades.FieldByName('ECF_INFADI').AsString;
      End;

      cdsModAux.Post;
    
      cdsModalidades.Next; 
    End;
    
    cdsModAux.First;
    While Not cdsModAux.Eof Do
    Begin

      strInfAdi := '';
      If cdsModAux.FieldByName('ECF_INFADI').AsString = 'S' Then
        strInfAdi := fRetVencimentos(strConPag, dtaDtaEnt);

      If (Not VS_objFiscal.fRegistraModalidades(cdsModAux.FieldByName('ECF_CODMOD').AsString,
                                                Trim(cdsModAux.FieldByName('DESMOD').AsString),
                                                cdsModAux.FieldByName('VALOR').AsFloat,
                                                strInfAdi)) Then
      Begin
        Abort;
      End;

      cdsModAux.Next;
    End;

  Finally
    FreeAndNil(cdsModAux);
  End;

end;

{************************************}
{* MONTA OS VENCIMENTOS             *}
{*********************************MA*}
function TfrmModalidades.fRetVencimentos( strConPag: String; dtaDtaEnt: TDateTime ): String;
Var
  intQtdPar: Integer;
  intQtdDia: Integer;
  intContador: Integer;
  strPar001 : String;
  strPar002 : String;
Begin

  Result := '';

  strPar001 := 'Vencimento: ';
  strPar002 := '   ';

  strConPag := Trim( strConPag );
  intQtdPar := StrToInt( LeftStr( strConPag, 2 ) );

  If intQtdPar > 7 Then    //Permite apenas 7 parcelas
    intQtdPar := 7;

  For intContador := 1 to intQtdPar Do
  Begin

    intQtdDia := StrToInt( Copy( strConPag, ( intContador * 3 ), 3 ) );

    If intQtdDia <= 0 Then
      Continue;

    If Length( strPar001 + FormatDateTime( 'dd/mm/yy', dtaDtaEnt + intQtdDia ) + ' ' ) > 48 Then
      strPar002 := strPar002 + FormatDateTime( 'dd/mm/yy', dtaDtaEnt + intQtdDia ) + ' '
    Else
      strPar001 := strPar001 + FormatDateTime( 'dd/mm/yy', dtaDtaEnt + intQtdDia ) + ' '

  End;

  Result := fPadr( strPar001, 48 ) + fPadr( strPar002, 32 );

  If Length( strPar001 ) = 12 Then
    Result := '';

End;

function TfrmModalidades.fSetaModalidade(strCodMod: String): Boolean;
  Var
    intContador: Integer;
begin

  Result := False;
  For intContador := 0 To stlModalidade.Count-1 Do
  Begin

    If stlModalidade[intContador] = strCodMod Then
    Begin
      Result := True;
      cbxModalidades.ItemIndex := intContador;
      cbxModalidadesExit(cbxModalidades);
      Break;
    End;

  End;

  If (strCodMod <> '1') And (Not Result) Then
  Begin
    Result := fSetaModalidade('1');
  End;

end;

procedure TfrmModalidades.pFechaCupom;
  Var
    Key: Word;
begin

  Key := VK_F10;
  FormKeyDown(Self, Key, []);

end;

procedure TfrmModalidades.pConfirma;
  Var
    fltTotFat : Double;
    strNomCli : String;
Begin

  If (fCfgSis('TEFEXC', varBoolean)) And (TLogTef.blnExcedeuTempoTEF) Then
  Begin
    fMensagem('ATENÇÃO!', MSG_TEF_EXCEDEU_TEMPO, ['&OK']);
    Exit;
  End;

  If (Not cdsModalidades.IsEmpty) Then
  Begin

    If (fFormataFloat(fltValPag, 2) >= fFormataFloat(fltTotal, 2)) And
       (fTemModalidadeFaturado(fltTotFat) Or (Not blnF10Automatico) Or (fMensagem('', 'Confirma Fechamento?', ['&Sim','&Não']) = 1)) Then
    Begin

      If (Assigned(VS_objFiscal)) Then
        strNomCli := VS_objFiscal.strNomCli
      Else
        strNomCli := '';

      If ((mskCgcCpf.Visible) And fEmptyStr(mskCgcCpf.Text)) And (Not fClienteConsumidor(strNomCli)) Then
      Begin
        pMensagemOk('Favor preencher CPF/CNPJ do cliente!');
        pSetFocus(mskCgcCpf);
        Exit;
      End;

      If (mskCgcCpf.Visible) And (Assigned(VS_objFiscal)) Then
      Begin
        VS_objFiscal.strCpfClie := mskCgcCpf.Text;
      End;

      If fImprimeCupom Then
        ModalResult := mrOk;

    End
    Else
    Begin
      cdsModalidades.First;
      pSetFocus(dbgModalidades);
    End;

  End;

End;

end.


