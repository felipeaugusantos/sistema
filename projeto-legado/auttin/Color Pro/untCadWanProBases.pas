{*******************************************}
{* frmModuloCons.qryCon001 -> CADITE       *}
{****************************************MV*}

unit untCadWanProBases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, EditFocus, DB, AppEvnts, Uni, BitBtnLockedIncrem,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadWanProBases = class(TfrmPaiCad)
    pnlCentral: TPanel;
    Label1: TLabel;
    dbeLinha: TDBEditFocus;
    Label2: TLabel;
    dbeCodBas: TDBEditFocus;
    Label3: TLabel;
    dbeDescri: TDBEditFocus;
    Label8: TLabel;
    edtDesIte: TEditFocus;
    dbeCodIte: TDBEditFocus;
    Label4: TLabel;
    dbePesEsp: TDBEditFocus;
    dbeEmbala: TDBEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    dbePreVen: TDBEditFocus;
    dtsWanProCadBas: TDataSource;
    cbbLinha: TcxComboBox;
    procedure FormCreate(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbbLinhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbbLinhaPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    qryCadIte: TUniQuery;
    StrCodIteAnt : String;
    procedure pCarregaItem;
    function fRetCodLinha(strNomLin: String): String;
    procedure pCarregaLinha(strCodLin: String);
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pHabilitaBtn;
  public
    procedure pAtualizaFatorTintometrico;
    { Public declarations }
  end;

var
  frmCadWanProBases: TfrmCadWanProBases;

implementation

uses untPai,  untModuloTinta,
  untPesqAux, untFuncoesSimples, untFuncTinta,
  untConsultas, untTypesSistema, untValidarBaseItemAmarracao;

{$R *.dfm}

{ TfrmCadWanProColorantes }

function TfrmCadWanProBases.fRetCodLinha(strNomLin: String): String;
begin
  strNomLin := Trim(AnsiLowerCase(strNomLin));

  Result := '';
  If strNomLin = AnsiLowerCase('Autobase Plus 100:50') Then
    Result := '1'

  Else If strNomLin = AnsiLowerCase('Wandabase HS') Then
    Result := '4'

  Else If strNomLin = AnsiLowerCase('Wandalac') Then
    Result := '6'

  Else If strNomLin = AnsiLowerCase('Wanda PU HS') Then
    Result := '8'

  Else If strNomLin = AnsiLowerCase('Wandacar') Then
    Result := '9'

  Else If strNomLin = AnsiLowerCase('Single Stage Converter') Then
    Result := '11'


  Else If strNomLin = AnsiLowerCase('Autobase Plus Baseline 100:80') Then
    Result := '12'

  Else If strNomLin = AnsiLowerCase('Autocoat BT100') Then
    Result := '13'

  Else If strNomLin = AnsiLowerCase('Autobase Plus 100:80') Then
    Result := '14'

  Else If strNomLin = AnsiLowerCase('Wanda PU MS') Then
    Result := '58'

  Else If strNomLin = AnsiLowerCase('Autocoat BT120') Then
    Result := '16'

  Else If strNomLin = AnsiLowerCase('Autobase Plus Baseline 100:50') Then
    Result := '19'

  Else If strNomLin = AnsiLowerCase('Autocoat BT90') Then
    Result := '59'

  Else If strNomLin = AnsiLowerCase('Autocoat BT110') Then
    Result := '15'

  Else If strNomLin = AnsiLowerCase('Autocoat BT130') Then
    Result := '17'

  Else If strNomLin = AnsiLowerCase('Autowave MM') Then
    Result := '27'

  Else If strNomLin = AnsiLowerCase('Tech Fleet PU') Then
    Result := '72'

  Else If strNomLin = AnsiLowerCase('Tech Fleet Epoxy') Then
    Result := '74'

  Else If strNomLin = AnsiLowerCase('Tech Fleet Sintetico') Then
    Result := '75'

  Else If strNomLin = AnsiLowerCase('Tech Fleet Laca') Then
    Result := '76';

end;

function TfrmCadWanProBases.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeLinha) Then
  Begin

    If (fEmptyStr(dbeLinha.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A linha deve ser preenchida!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeCodBas) Then
  Begin

    If (fEmptyStr(dbeCodBas.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O código da base deve ser preechido!', ['&Ok']);
      Result := False;
    End
    Else If (blnBuscaPorChave) And (Not fBuscaPorCamposChave) Then
    Begin
      pLimparCampos;
    End;

  End

  Else If (Sender = dbeDescri) Then
  Begin
    If (fEmptyStr(dbeDescri.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição deve ser preechida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbePesEsp) Then
  Begin
    If (fEmptyStr(dbePesEsp.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Peso Esp. deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(dbePesEsp.Text) <= 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Peso Esp. deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeEmbala) Then
  Begin
    If (fEmptyStr(dbeEmbala.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Embalagem deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(dbeEmbala.Text) <= 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Embalagem deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End


  Else If (Sender = dbeCodIte) Then
  Begin
    If Not (fEmptyStr(dbeCodIte.Text)) Then
    Begin
      pCarregaItem;

      If (qryCadIte.FieldByName('ITE_CODITE').IsNull) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
        Result := False;
      End;
    End
    Else
      edtDesIte.Clear;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadWanProBases.pInicializaIndices;
begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('BAS_DESBAS+BAS_CODBAS+BAS_LINHA_');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Descrição/Base/Linha');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');
end;

procedure TfrmCadWanProBases.FormCreate(Sender: TObject);
  Var
    dbeCodEmp: TDBEdit;
begin
  inherited;
  strNomeTabela := 'WANPRO_CADBAS';
  strNomeCampo  := 'BAS_LINHA_';
  qryTabela     := frmModuloTinta.qryWanPro_CadBas;

  dtsWanProCadBas.DataSet := frmModuloTinta.qryWanPro_CadBas;

  {*****************************************}
  {* CRIA O CAMPO EMPRESA PARA SER USADO   *}
  {* NA FUNÇÃO DE BUSCA PARA ALTERAÇÃO     *}
  {**************************************MV*}
  dbeCodEmp            := TDBEdit.Create(Self);
  dbeCodEmp.DataField  := 'BAS_CODEMP';
  dbeCodEmp.DataSource := frmModuloTinta.dtsWanPro_CadBas;

  SetLength(arrCamposChave, 3);
  arrCamposChave[0] := dbeLinha;
  arrCamposChave[1] := dbeCodBas;
  arrCamposChave[2] := dbeCodEmp;

  qryCadIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

procedure TfrmCadWanProBases.FormShow(Sender: TObject);
begin
  inherited;
  cbbLinha.Enabled := False;
end;

procedure TfrmCadWanProBases.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadWanProBases.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;

  qryTabela.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
//  pSetFocus(dbeLinha);
  edtDesIte.Clear;
  pHabilitaBtn;

  cbbLinha.ItemIndex := -1;
  cbbLinha.Enabled   := True;
  cbbLinha.ItemIndex := 0;
  dbeLinha.Enabled   := False;

  pSetFocus(dbeCodBas);
end;

procedure TfrmCadWanProBases.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    key: Char;
begin
  key := '/';
  If fPesqBaseTinta(Self, conWandaPro, nil, nil, qryTabela, key, arrSel, True, '', '', False) Then
  Begin
    pCarregaItem;
    pCarregaLinha(qryTabela.FieldByName('BAS_LINHA_').AsString);
    pSetFocus(btnAlterar);
  End
  Else
  Begin
    If (fEmptyStr(qryTabela.FieldByName('BAS_CODBAS').AsString) And fEmptyStr(qryTabela.FieldByName('BAS_LINHA_').AsString)) Then
      pCarregaLinha(qryTabela.FieldByName('BAS_LINHA_').AsString);
  End;
end;

procedure TfrmCadWanProBases.cbbLinhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
  Begin
    pProximoControle(Sender);
  End
  Else If (Key = VK_Escape) Then
  Begin
    pEscapePressed;
  End;
end;

procedure TfrmCadWanProBases.cbbLinhaPropertiesChange(Sender: TObject);
begin
  inherited;
  dbeLinha.Text := fRetCodLinha(cbbLinha.Text);
end;

procedure TfrmCadWanProBases.btnExcluirClick(Sender: TObject);
begin
  strCodIteAnt := dbeCodIte.Text;
  inherited;

  if fEmptyStr(dbeCodIte.Text) Then
    pEnviarLogRep(strCodIteAnt, 'WANPRO');

  pCarregaItem;
end;

procedure TfrmCadWanProBases.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
  pCarregaLinha(qryTabela.FieldByName('BAS_LINHA_').AsString);
  cbbLinha.Enabled := False;
end;

procedure TfrmCadWanProBases.btnAlterarClick(Sender: TObject);
begin
  StrCodIteAnt := '';
  inherited;
  cbbLinha.Enabled := False;
  dbeLinha.Enabled := False;
  dbeCodBas.Enabled := False;

  pSetFocus(dbeDescri);
  pHabilitaBtn;
end;

procedure TfrmCadWanProBases.pCarregaItem;
begin
  pPesquisaCadIte(qryCadIte, qryCadIte, dbeCodIte.Text);
  With qryCadIte Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;
end;

procedure TfrmCadWanProBases.pCarregaLinha(strCodLin: String);
begin
  If fEmptyStr(strCodLin) Then
  Begin
    cbbLinha.ItemIndex := -1;
    Exit;
  End;

  If strCodLin = '1' Then
    cbbLinha.ItemIndex := cbbLinha.Properties.Items.IndexOf(AnsiLowerCase('Autobase Plus 100:50'))

  Else If strCodLin = '4' Then
    cbbLinha.ItemIndex := cbbLinha.Properties.Items.IndexOf(AnsiLowerCase('Wandabase HS'))

  Else If strCodLin = '6' Then
    cbbLinha.ItemIndex := cbbLinha.Properties.Items.IndexOf(AnsiLowerCase('Wandalac'))

  Else If strCodLin = '8' Then
    cbbLinha.ItemIndex := cbbLinha.Properties.Items.IndexOf(AnsiLowerCase('Wanda PU HS'))

  Else If strCodLin = '9' Then
    cbbLinha.ItemIndex := cbbLinha.Properties.Items.IndexOf(AnsiLowerCase('Wandacar'))

  Else If strCodLin = '11' Then
    cbbLinha.ItemIndex := cbbLinha.Properties.Items.IndexOf(AnsiLowerCase('Single Stage Converter'))

  Else If strCodLin = '13' Then
    cbbLinha.ItemIndex := cbbLinha.Properties.Items.IndexOf(AnsiLowerCase('Autocoat BT100'))

  Else If strCodLin = '14' Then
    cbbLinha.ItemIndex := cbbLinha.Properties.Items.IndexOf(AnsiLowerCase('Autobase Plus 100:80'))

  Else If strCodLin = '58' Then
    cbbLinha.ItemIndex := cbbLinha.Properties.Items.IndexOf(AnsiLowerCase('Wanda PU MS'))

  Else If strCodLin = '16' Then
    cbbLinha.ItemIndex := cbbLinha.Properties.Items.IndexOf(AnsiLowerCase('Autocoat BT120'))

  Else If strCodLin = '59' Then
    cbbLinha.ItemIndex := cbbLinha.Properties.Items.IndexOf(AnsiLowerCase('Autocoat BT90'))

  Else If strCodLin = '15' Then
    cbbLinha.ItemIndex := cbbLinha.Properties.Items.IndexOf(AnsiLowerCase('Autocoat BT110'))

  Else If strCodLin = '17' Then
    cbbLinha.ItemIndex := cbbLinha.Properties.Items.IndexOf(AnsiLowerCase('Autocoat BT130'))

  Else If strCodLin = '27' Then
    cbbLinha.ItemIndex := cbbLinha.Properties.Items.IndexOf(AnsiLowerCase('Autowave MM'))

  Else If strCodLin = '72' Then
    cbbLinha.ItemIndex := cbbLinha.Properties.Items.IndexOf(AnsiLowerCase('Tech Fleet PU'))

  Else If strCodLin = '74' Then
    cbbLinha.ItemIndex := cbbLinha.Properties.Items.IndexOf(AnsiLowerCase('Tech Fleet Epoxy'))

  Else If strCodLin = '75' Then
    cbbLinha.ItemIndex := cbbLinha.Properties.Items.IndexOf(AnsiLowerCase('Tech Fleet Sintetico'))

  Else If strCodLin = '76' Then
    cbbLinha.ItemIndex := cbbLinha.Properties.Items.IndexOf(AnsiLowerCase('Tech Fleet Laca'))

  Else If strCodLin = '19' Then
    cbbLinha.ItemIndex := cbbLinha.Properties.Items.IndexOf(AnsiLowerCase('Autobase Plus Baseline 100:50'))

  Else If strCodLin = '12' Then
    cbbLinha.ItemIndex := cbbLinha.Properties.Items.IndexOf(AnsiLowerCase('Autobase Plus Baseline 100:80'));


end;

procedure TfrmCadWanProBases.pHabilitaBtn;
begin
  dbePesEsp.ReadOnly := (qryTabela.State in [dsEdit]);
end;

procedure TfrmCadWanProBases.pAtualizaFatorTintometrico;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'UPDATE CADITE '+
                     ' INNER JOIN WANPRO_CADBAS '+
                     '    ON ITE_CODITE = BAS_CODITE '+
                     '   SET ITE_CNV_ML = (IFNULL(BAS_PESESP, 1) * IFNULL(BAS_EMBALA, 1));';
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

procedure TfrmCadWanProBases.btnGravarClick(Sender: TObject);
Var
  ObjValidarBaseItemAmarracao : TValidarBaseItemAmarracao;
  blnEdit : Boolean;
begin
  ObjValidarBaseItemAmarracao := TValidarBaseItemAmarracao.Create;

  blnEdit := (dtsWanProCadBas.DataSet.State in [DsEdit]);

  fStartTransaction;

  Try
    if ObjValidarBaseItemAmarracao.fValidarBaseItemAmarracao('WANPRO', dbeCodBas.text, dbeDescri.text, dbeCodIte.Text , StrCodIteAnt ,
         dtsWanProCadBas.DataSet.FieldByName('BAS_PESESP').AsFloat , strToFloat(dbeEmbala.Text)) Then
    begin
      inherited;
      cbbLinha.Enabled := False;
      pAtualizaFatorTintometrico;

      If (Not fEmptyStr(strCoditeAnt)) And (blnEdit) Then
      Begin
        If (strCoditeAnt <> dbeCodIte.Text) Then
          pEnviarLogRep(strCodIteAnt, 'WANPRO');
      End;

      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;

  If Assigned(ObjValidarBaseItemAmarracao)Then
    FreeAndNil(ObjValidarBaseItemAmarracao);

end;

end.

