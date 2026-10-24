unit untCadWanProNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, DBCtrls, DBEditFocus, StrUtils, DB, AppEvnts, Uni,
  ComboBoxFocus, DBComboBoxFocus,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxDBEdit,
  cxLookAndFeels, cxLookAndFeelPainters, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmCadWanProNovasFormulas = class(TfrmPaiCad)
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    gpbColorantes: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label25: TLabel;
    dbeForm01: TDBEditFocus;
    dbeQtdC01: TDBEditFocus;
    dbeForm02: TDBEditFocus;
    dbeQtdC02: TDBEditFocus;
    dbeForm03: TDBEditFocus;
    dbeQtdC03: TDBEditFocus;
    dbeForm04: TDBEditFocus;
    dbeQtdC04: TDBEditFocus;
    dbeForm05: TDBEditFocus;
    dbeQtdC05: TDBEditFocus;
    dbeForm06: TDBEditFocus;
    dbeQtdC06: TDBEditFocus;
    dbeForm07: TDBEditFocus;
    dbeQtdC07: TDBEditFocus;
    dbeForm08: TDBEditFocus;
    dbeQtdC08: TDBEditFocus;
    dbeForm09: TDBEditFocus;
    dbeQtdC09: TDBEditFocus;
    dbeForm10: TDBEditFocus;
    dbeQtdC10: TDBEditFocus;
    Label2: TLabel;
    dbeDtaCad: TDBEditFocus;
    Label3: TLabel;
    dbeCodDil: TDBEditFocus;
    Label5: TLabel;
    dbeQtdDil: TDBEditFocus;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label28: TLabel;
    dbeQtdD01: TDBEditFocus;
    dbeQtdD02: TDBEditFocus;
    dbeQtdD03: TDBEditFocus;
    dbeQtdD04: TDBEditFocus;
    dbeQtdD05: TDBEditFocus;
    Label18: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    Label26: TLabel;
    dbeQtdD06: TDBEditFocus;
    dbeQtdD07: TDBEditFocus;
    dbeQtdD08: TDBEditFocus;
    dbeQtdD09: TDBEditFocus;
    dbeQtdD10: TDBEditFocus;
    dbeLinha_: TDBEditFocus;
    Label38: TLabel;
    Label40: TLabel;
    dbeAltern: TDBEditFocus;
    Label41: TLabel;
    dbeMontad: TDBEditFocus;
    Label6: TLabel;
    Label27: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    dbeQd4101: TDBEditFocus;
    dbeQd4102: TDBEditFocus;
    dbeQd4103: TDBEditFocus;
    dbeQd4104: TDBEditFocus;
    dbeQd4105: TDBEditFocus;
    dbeQd4106: TDBEditFocus;
    dbeQd4107: TDBEditFocus;
    dbeQd4108: TDBEditFocus;
    dbeQd4109: TDBEditFocus;
    dbeQd4110: TDBEditFocus;
    Label37: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    dbeQtdDi4: TDBEditFocus;
    Label39: TLabel;
    Label50: TLabel;
    dbeForm11: TDBEditFocus;
    Label51: TLabel;
    dbeQtdC11: TDBEditFocus;
    Label52: TLabel;
    dbeQtdD11: TDBEditFocus;
    Label53: TLabel;
    dbeQd4111: TDBEditFocus;
    Label54: TLabel;
    dbeForm12: TDBEditFocus;
    Label55: TLabel;
    dbeQtdC12: TDBEditFocus;
    Label56: TLabel;
    dbeQtdD12: TDBEditFocus;
    Label57: TLabel;
    dbeQd4112: TDBEditFocus;
    Label58: TLabel;
    dbeForm13: TDBEditFocus;
    Label59: TLabel;
    dbeQtdC13: TDBEditFocus;
    Label60: TLabel;
    dbeQtdD13: TDBEditFocus;
    Label61: TLabel;
    dbeQd4113: TDBEditFocus;
    Label62: TLabel;
    dbeForm14: TDBEditFocus;
    Label63: TLabel;
    dbeQtdC14: TDBEditFocus;
    Label64: TLabel;
    dbeQtdD14: TDBEditFocus;
    Label65: TLabel;
    dbeQd4114: TDBEditFocus;
    Label66: TLabel;
    dbeForm15: TDBEditFocus;
    Label67: TLabel;
    dbeQtdC15: TDBEditFocus;
    Label68: TLabel;
    dbeQtdD15: TDBEditFocus;
    Label69: TLabel;
    dbeQd4115: TDBEditFocus;
    dbeCamada: TDBEditFocus;
    lbCamada: TLabel;
    cbbLinha: TcxDBComboBox;
    Label70: TLabel;
    dbeAcrMob: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure cbbLinhaPropertiesChange(Sender: TObject);
    procedure cbbLinhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbeQtdC01Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);

  private
    { Private declarations }
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
    blnEdit: Boolean;
    function fRetCodLinha(strNomLin: String): String;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    procedure pInserirMascara;

    function fValidarQntConcDiluida : Boolean;
    function fInformarDiluente : Boolean;
    function fValidarBasePreenchida: Boolean;
    function fPreencherQntDiluente21 : Boolean;
    function fPreencherQntDiluente41 : Boolean;
    function fInformarBase: Boolean;
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
    procedure pDesabilitaDiluidos(strNomLin: String);
    function fAlterarLinha: Boolean;
  protected
    function fValidaColorante(strCodCol: String): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadWanProNovasFormulas: TfrmCadWanProNovasFormulas;

implementation

uses
  untModuloTinta, untPai, untWandaPro,
  untFuncTinta, untIConfTinta, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadWanProNovasForumulas }

function TfrmCadWanProNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNumCol: String;
begin

  Result := True;

  If (Sender = dbeCodigo) Then
  Begin
  End

  Else If (Sender = dbeDescri) Then
  Begin
    If (fEmptyStr(dbeDescri.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeLinha_) Then
  Begin
  End

  Else If (Sender = dbeForm01) Then
  Begin
    If (fEmptyStr(dbeForm01.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos 1 colorante!', ['&Ok']);
      Result := False;
    End
    Else If (Not fValidaColorante(dbeForm01.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base não está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeForm02) Or
          (Sender = dbeForm03) Or
          (Sender = dbeForm04) Or
          (Sender = dbeForm05) Or
          (Sender = dbeForm06) Or
          (Sender = dbeForm07) Or
          (Sender = dbeForm08) Or
          (Sender = dbeForm09) Or
          (Sender = dbeForm10) Or
          (Sender = dbeForm11) Or
          (Sender = dbeForm12) Or
          (Sender = dbeForm13) Or
          (Sender = dbeForm14) Or
          (Sender = dbeForm15) Then
  Begin
    If (fEmptyStr((TEdit(Sender).Text))) Then
    Begin
      pSetFocus(dbeQD4115)
    End
    Else If (Not fValidaColorante(TEdit(Sender).Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base não está cadastrada!', ['&Ok']);
      Result := False;
    End

    Else If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base já está cadastrada para essa fórmula!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeQtdC01) Or
          (Sender = dbeQtdC02) Or
          (Sender = dbeQtdC03) Or
          (Sender = dbeQtdC04) Or
          (Sender = dbeQtdC05) Or
          (Sender = dbeQtdC06) Or
          (Sender = dbeQtdC07) Or
          (Sender = dbeQtdC08) Or
          (Sender = dbeQtdC09) Or
          (Sender = dbeQtdC09) Or
          (Sender = dbeQtdC10) Or
          (Sender = dbeQtdC11) Or
          (Sender = dbeQtdC12) Or
          (Sender = dbeQtdC13) Or
          (Sender = dbeQtdC14) Or
          (Sender = dbeQtdC15) Then
 Begin
    strNumCol := RightStr(Sender.Name, 2);
    If (Not fEmptyStr(TEdit(fComponentByName(gpbColorantes, 'dbeForm' + strNumCol)).Text)) Then
    Begin
      {If (fEmptyStr(TEdit(Sender).Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar a quantidade da base!', ['&Ok']);
        Result := False;
      End}
    End;
  End

  Else If (Sender = dbeQtdD01) Or
          (Sender = dbeQtdD02) Or
          (Sender = dbeQtdD03) Or
          (Sender = dbeQtdD04) Or
          (Sender = dbeQtdD05) Or
          (Sender = dbeQtdD06) Or
          (Sender = dbeQtdD07) Or
          (Sender = dbeQtdD08) Or
          (Sender = dbeQtdD09) Or
          (Sender = dbeQtdD10) Or
          (Sender = dbeQtdD11) Or
          (Sender = dbeQtdD12) Or
          (Sender = dbeQtdD13) Or
          (Sender = dbeQtdD14) Or
          (Sender = dbeQtdD15) Or

          (Sender = dbeQD4101) Or
          (Sender = dbeQD4102) Or
          (Sender = dbeQD4103) Or
          (Sender = dbeQD4104) Or
          (Sender = dbeQD4105) Or
          (Sender = dbeQD4106) Or
          (Sender = dbeQD4107) Or
          (Sender = dbeQD4108) Or
          (Sender = dbeQD4109) Or
          (Sender = dbeQD4110) Or
          (Sender = dbeQD4111) Or
          (Sender = dbeQD4112) Or
          (Sender = dbeQD4113) Or
          (Sender = dbeQD4114) Or
          (Sender = dbeQD4115) Then
  Begin
    {If (Not fEmptyStr(TEdit(fComponentByName(gpbColorantes, 'dbeForm' + strNumCol)).Text)) Then
    Begin
      If (fEmptyStr(TEdit(Sender).Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar a quantidade da base!', ['&Ok']);
        Result := False;
      End;
    End;}
  End


  Else If (Sender = dbeCodDil) Then
  Begin
    If (Not fEmptyStr((TEdit(Sender).Text))) Then
    Begin
      If (Not fValidaColorante(TEdit(Sender).Text)) Then
      Begin
        Result := False;
      End;
    End;
  End

  Else If (Sender = dbeQtdDi4) Then
  Begin
    If (Not fEmptyStr(dbeCodDil.Text)) Then
    Begin

      If (fEmptyStr(dbeQtdDi4.Text)) Then
        dbeQtdDi4.Text := '0,00';

    End;
  End

  Else If (Sender = dbeAcrMob) Then
  Begin
    If fEmptyStr(dbeAcrMob.Text) Then
    Begin
      dbeAcrMob.Field.AsFloat := 0.00;
    End
    Else If Not fEmptyStr(dbeAcrMob.Text) Then
    Begin
      If (fStrToFloat(dbeAcrMob.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO', 'O Acréscimo de Mão de Obra deve ser maior ou igual a zero', ['OK']);
        Result := False;
      End;
    End;
  End;


  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmCadWanProNovasFormulas.fValidaColorante(
  strCodCol: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  WANPRO_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_LINHA_ = :LINHA_ AND ';
  strSQL := strSQL + '  BAS_CODBAS = :CODBAS ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('LINHA_').AsString := dbeLinha_.Text;
    ParamByName('CODBAS').AsString := strCodCol;
    Open;
    Result := (FieldByName('QTD').AsInteger > 0);
    Close;
  End;
end;

function TfrmCadWanProNovasFormulas.fValidarQntConcDiluida: Boolean;
begin
  result  := false;

  if (dbeForm01.text <> '') and (dbeQtdC01.text = '0,000') and (dbeQtdD01.text = '0,000') and (dbeQd4101.text = '0,000') then result  := true;
  if (dbeForm02.text <> '') and (dbeQtdC02.text = '0,000') and (dbeQtdD02.text = '0,000') and (dbeQd4102.text = '0,000') then result  := true;
  if (dbeForm03.text <> '') and (dbeQtdC03.text = '0,000') and (dbeQtdD03.text = '0,000') and (dbeQd4103.text = '0,000') then result  := true;
  if (dbeForm04.text <> '') and (dbeQtdC04.text = '0,000') and (dbeQtdD04.text = '0,000') and (dbeQd4104.text = '0,000') then result  := true;
  if (dbeForm05.text <> '') and (dbeQtdC05.text = '0,000') and (dbeQtdD05.text = '0,000') and (dbeQd4105.text = '0,000') then result  := true;
  if (dbeForm06.text <> '') and (dbeQtdC06.text = '0,000') and (dbeQtdD06.text = '0,000') and (dbeQd4106.text = '0,000') then result  := true;
  if (dbeForm07.text <> '') and (dbeQtdC07.text = '0,000') and (dbeQtdD07.text = '0,000') and (dbeQd4107.text = '0,000') then result  := true;
  if (dbeForm08.text <> '') and (dbeQtdC08.text = '0,000') and (dbeQtdD08.text = '0,000') and (dbeQd4108.text = '0,000') then result  := true;
  if (dbeForm09.text <> '') and (dbeQtdC09.text = '0,000') and (dbeQtdD09.text = '0,000') and (dbeQd4109.text = '0,000') then result  := true;
  if (dbeForm10.text <> '') and (dbeQtdC10.text = '0,000') and (dbeQtdD10.text = '0,000') and (dbeQd4110.text = '0,000') then result  := true;
  if (dbeForm11.text <> '') and (dbeQtdC11.text = '0,000') and (dbeQtdD11.text = '0,000') and (dbeQd4111.text = '0,000') then result  := true;
  if (dbeForm12.text <> '') and (dbeQtdC12.text = '0,000') and (dbeQtdD12.text = '0,000') and (dbeQd4112.text = '0,000') then result  := true;
  if (dbeForm13.text <> '') and (dbeQtdC13.text = '0,000') and (dbeQtdD13.text = '0,000') and (dbeQd4113.text = '0,000') then result  := true;
  if (dbeForm14.text <> '') and (dbeQtdC14.text = '0,000') and (dbeQtdD14.text = '0,000') and (dbeQd4114.text = '0,000') then result  := true;
  if (dbeForm15.text <> '') and (dbeQtdC15.text = '0,000') and (dbeQtdD15.text = '0,000') and (dbeQd4115.text = '0,000') then result  := true;
end;

function TfrmCadWanProNovasFormulas.fValidarBasePreenchida: Boolean;
begin
  result  := false;

  if (dbeForm01.text = '') and ((dbeQtdC01.text <> '0,000') or (dbeQtdD01.text <> '0,000') or (dbeQd4101.text <> '0,000')) then result  := true;
  if (dbeForm02.text = '') and ((dbeQtdC02.text <> '0,000') or (dbeQtdD02.text <> '0,000') or (dbeQd4102.text <> '0,000')) then result  := true;
  if (dbeForm03.text = '') and ((dbeQtdC03.text <> '0,000') or (dbeQtdD03.text <> '0,000') or (dbeQd4103.text <> '0,000')) then result  := true;
  if (dbeForm04.text = '') and ((dbeQtdC04.text <> '0,000') or (dbeQtdD04.text <> '0,000') or (dbeQd4104.text <> '0,000')) then result  := true;
  if (dbeForm05.text = '') and ((dbeQtdC05.text <> '0,000') or (dbeQtdD05.text <> '0,000') or (dbeQd4105.text <> '0,000')) then result  := true;
  if (dbeForm06.text = '') and ((dbeQtdC06.text <> '0,000') or (dbeQtdD06.text <> '0,000') or (dbeQd4106.text <> '0,000')) then result  := true;
  if (dbeForm07.text = '') and ((dbeQtdC07.text <> '0,000') or (dbeQtdD07.text <> '0,000') or (dbeQd4107.text <> '0,000')) then result  := true;
  if (dbeForm08.text = '') and ((dbeQtdC08.text <> '0,000') or (dbeQtdD08.text <> '0,000') or (dbeQd4108.text <> '0,000')) then result  := true;
  if (dbeForm09.text = '') and ((dbeQtdC09.text <> '0,000') or (dbeQtdD09.text <> '0,000') or (dbeQd4109.text <> '0,000')) then result  := true;
  if (dbeForm10.text = '') and ((dbeQtdC10.text <> '0,000') or (dbeQtdD10.text <> '0,000') or (dbeQd4110.text <> '0,000')) then result  := true;
  if (dbeForm11.text = '') and ((dbeQtdC11.text <> '0,000') or (dbeQtdD11.text <> '0,000') or (dbeQd4111.text <> '0,000')) then result  := true;
  if (dbeForm12.text = '') and ((dbeQtdC12.text <> '0,000') or (dbeQtdD12.text <> '0,000') or (dbeQd4112.text <> '0,000')) then result  := true;
  if (dbeForm13.text = '') and ((dbeQtdC13.text <> '0,000') or (dbeQtdD13.text <> '0,000') or (dbeQd4113.text <> '0,000')) then result  := true;
  if (dbeForm14.text = '') and ((dbeQtdC14.text <> '0,000') or (dbeQtdD14.text <> '0,000') or (dbeQd4114.text <> '0,000')) then result  := true;
  if (dbeForm15.text = '') and ((dbeQtdC15.text <> '0,000') or (dbeQtdD15.text <> '0,000') or (dbeQd4115.text <> '0,000')) then result  := true;
end;

procedure TfrmCadWanProNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODNFM');
  stlCamInd.Add('NFM_DESCRI');
  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadWanProNovasFormulas.pInserirMascara;
var
  intContador : Integer;
begin
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin
    If Self.Components[intContador] Is TDBEditFocus Then
    Begin
      If (LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 4) = 'dbeQ')
      And (TDBEditFocus(Self.Components[intContador]).Text = '') Then
          TDBEditFocus(Self.Components[intContador]).Field.AsFloat := 0.000;

      If (TDBEditFocus(Self.Components[intContador]).Name = 'dbeAcrMob')
      And (TDBEditFocus(Self.Components[intContador]).Text = '') Then
          TDBEditFocus(Self.Components[intContador]).Field.AsFloat := 0.00
    End;
  End;
end;

procedure TfrmCadWanProNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadNfm;
  strNomeTabela := 'WANPRO_CADNFM';
  strNomeCampo := 'NFM_CODNFM';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadWanProNovasFormulas.FormShow(Sender: TObject);
begin
  inherited;
  cbbLinha.Enabled := False;
  blnEdit := False;
end;

procedure TfrmCadWanProNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pInserirMascara;
  blnUsaProCodigo := False;

  dbeCodigo.Enabled := False;
  pSetFocus(dbeDescri);
  dbeDtaCad.Field.AsDateTime := Date;

  cbbLinha.Enabled := True;

  pDesabilitaDiluidos(cbbLinha.Text);
end;

procedure TfrmCadWanProNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqFormulaTinta(Self, conWandaPro, Nil, qryTabela, key, arrSel) Then
  begin
    { Formata os Campos }
    pSetFocus(btnAlterar);
  end;
end;

procedure TfrmCadWanProNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  if (qryTabela.State = dsEdit) then
    pInserirMascara;

  dbeCodigo.Enabled := False;
  If (dbeDescri.Enabled) Then
    pSetFocus(dbeDescri);

  If blnAlterou Then
    cbbLinha.Enabled := True;

  blnEdit := True;
  pDesabilitaDiluidos(cbbLinha.Text);
end;

procedure TfrmCadWanProNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    conf: IConfTinta;
begin

  if not (fInformarBase) then
  begin
    fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos uma base!', ['&Ok']);
    pSetFocus(dbeForm01);
    Exit;
  end;

  if fValidarQntConcDiluida then
  begin
    fMensagem('ATENÇÃO!', 'Existe base preenchida sem quantidade informada!', ['&Ok']);
    Exit;
  end;

  if fValidarBasePreenchida then
  begin
    fMensagem('ATENÇÃO!', 'Alguma quantidade "concentrada" ou "diluída" foi preenchida sem que a "base" fosse informada!', ['&Ok']);
    Exit;
  end;

  if (dbeCodDil.Text <> '') and not(fInformarDiluente) then
  begin
    fMensagem('ATENÇÃO!', 'Ao informar o "diluente", é necessário que alguma quantidade diluída seja preenchida!', ['&Ok']);
    Exit;
  end;

  if (dbeCodDil.Text = '') and (fInformarDiluente) then
  begin
    fMensagem('ATENÇÃO!', 'Ao informar uma quantidade diluída, é necessário que o diluente seja preenchido!', ['&Ok']);
    pSetFocus(dbeCodDil);
    Exit;
  end;

  if (fPreencherQntDiluente21) and  (fStrToFloat(dbeQtdDil.text) <= 0 ) then
  begin
    fMensagem('ATENÇÃO!', 'A Quantidade (2:1) deve ser maior que Zero!', ['&Ok']);
    pSetFocus(dbeQtdDil);
    Exit;
  end;

  if (fPreencherQntDiluente41) and (fStrToFloat(dbeQtdDi4.text) <= 0 ) then
  begin
    fMensagem('ATENÇÃO!', 'A Quantidade (4:1) deve ser maior que Zero!', ['&Ok']);
    pSetFocus(dbeQtdDi4);
    Exit;
  end;

  if not(fPreencherQntDiluente21) and  (fStrToFloat(dbeQtdDil.text) > 0 ) then
  begin
    fMensagem('ATENÇÃO!', 'A Quantidade diluída deve ser preenchida ao informar a "Quantidade (2:1)"!', ['&Ok']);
    Exit;
  end;

  if not(fPreencherQntDiluente41) and (fStrToFloat(dbeQtdDi4.text) > 0 ) then
  begin
    fMensagem('ATENÇÃO!', 'A Quantidade diluída deve ser preenchida ao informar a "Quantidade (4:1)" !', ['&Ok']);
    Exit;
  end;

  conf   := fGetConfTinta('WCP');
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfmBri := conf.fGet('NFMPRO'); //fArqIniTinta(0, 'COLOR PRO', 'NFMPRO', '1');
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP' + VS_strCodEmp + fStrZero(strNfmBri, 5);
  End;
                                        
  fStartTransaction;
  inherited;

  Try
    If (blnGravou) Then
    Begin
      cbbLinha.Enabled := False;

      Screen.Cursor := crHourGlass;

      If (fGeraNovasFormulas(qryTabela)) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('NFMPRO', fStrZero(StrToInt(strNfmBri) + 1, 5)); //fArqIniTinta(1, 'COLOR PRO', 'NFMPRO', fStrZero(StrToInt(strNfmBri) + 1, 5));
        End;

        fCommit;
      End
      Else
        fRollBack;

      Screen.Cursor := crDefault;
      blnGravou := False;
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
end;

procedure TfrmCadWanProNovasFormulas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  cbbLinha.Enabled := False;
  pDesabilitaDiluidos(cbbLinha.Text);
end;

procedure TfrmCadWanProNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strCodigo: String;
begin
  strCodigo := qryTabela.FieldByName('NFM_CODNFM').AsString;

  fStartTransaction;

  inherited;

  Try
    If (blnExcluiu) Then
    Begin
      pDeletaNovaFormula(strCodigo);
      blnExcluiu := False;
      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnExcluirClick]');
    End;
  End;
end;

procedure TfrmCadWanProNovasFormulas.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If fPesqBaseTinta(Self, conWandaPro, TDBEditFocus(Sender), nil, nil, key, arrSel, True, ' AND BAS_LINHA_ = "' + dbeLinha_.Text + '"') Then
  Begin
    If (fValidaCampos(TDBEditFocus(Sender))) Then
       Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadWanProNovasFormulas.dbeQtdC01Exit(Sender: TObject);
begin
  inherited;
  if fEmptyStr((Sender as TDBEditFocus).Text) Then
    (Sender as TDBEditFocus).Text := '0,000';
end;

function TfrmCadWanProNovasFormulas.fInformarDiluente: Boolean;
begin
  Result := false;

  if (dbeQtdD01.text <> '0,000') or (dbeQd4101.text <> '0,000') then result := true;
  if (dbeQtdD02.text <> '0,000') or (dbeQd4102.text <> '0,000') then result := true;
  if (dbeQtdD03.text <> '0,000') or (dbeQd4103.text <> '0,000') then result := true;
  if (dbeQtdD04.text <> '0,000') or (dbeQd4104.text <> '0,000') then result := true;
  if (dbeQtdD05.text <> '0,000') or (dbeQd4105.text <> '0,000') then result := true;
  if (dbeQtdD06.text <> '0,000') or (dbeQd4106.text <> '0,000') then result := true;
  if (dbeQtdD07.text <> '0,000') or (dbeQd4107.text <> '0,000') then result := true;
  if (dbeQtdD08.text <> '0,000') or (dbeQd4108.text <> '0,000') then result := true;
  if (dbeQtdD09.text <> '0,000') or (dbeQd4109.text <> '0,000') then result := true;
  if (dbeQtdD10.text <> '0,000') or (dbeQd4110.text <> '0,000') then result := true;
  if (dbeQtdD11.text <> '0,000') or (dbeQd4111.text <> '0,000') then result := true;
  if (dbeQtdD12.text <> '0,000') or (dbeQd4112.text <> '0,000') then result := true;
  if (dbeQtdD13.text <> '0,000') or (dbeQd4113.text <> '0,000') then result := true;
  if (dbeQtdD14.text <> '0,000') or (dbeQd4114.text <> '0,000') then result := true;
  if (dbeQtdD15.text <> '0,000') or (dbeQd4115.text <> '0,000') then result := true;

end;

function TfrmCadWanProNovasFormulas.fJaExisteEssaBaseNaFormulacao(
  strCodBas: String; dbeForm: TObject): Boolean;
var
  intCont: Integer;
begin
  Result := False;

  For intCont := 1 To 15 Do
  Begin
    If (RightStr(TDBEditFocus(dbeForm).Name, 2) <> fStrZero(intCont,2)) And
       (Not fEmptyStr(TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont,2))).Text)) Then
    Begin
      If TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont,2))).Text = strCodBas Then
        Result := True;
    End;
  End;
end;

function TfrmCadWanProNovasFormulas.fPreencherQntDiluente21: Boolean;
begin
  Result := false;

  if (dbeQtdD01.text <> '0,000') or (dbeQtdD02.text <> '0,000') then Result := true;
  if (dbeQtdD03.text <> '0,000') or (dbeQtdD04.text <> '0,000') then Result := true;
  if (dbeQtdD05.text <> '0,000') or (dbeQtdD06.text <> '0,000') then Result := true;
  if (dbeQtdD07.text <> '0,000') or (dbeQtdD08.text <> '0,000') then Result := true;
  if (dbeQtdD09.text <> '0,000') or (dbeQtdD10.text <> '0,000') then Result := true;
  if (dbeQtdD11.text <> '0,000') or (dbeQtdD12.text <> '0,000') then Result := true;
  if (dbeQtdD13.text <> '0,000') or (dbeQtdD14.text <> '0,000') then Result := true;
  if (dbeQtdD15.text <> '0,000') then Result := true;
end;

function TfrmCadWanProNovasFormulas.fPreencherQntDiluente41: Boolean;
begin
  Result := false;

  if (dbeQd4101.text <> '0,000') or (dbeQd4102.text <> '0,000') then Result := true;
  if (dbeQd4103.text <> '0,000') or (dbeQd4104.text <> '0,000') then Result := true;
  if (dbeQd4105.text <> '0,000') or (dbeQd4106.text <> '0,000') then Result := true;
  if (dbeQd4107.text <> '0,000') or (dbeQd4108.text <> '0,000') then Result := true;
  if (dbeQd4109.text <> '0,000') or (dbeQd4110.text <> '0,000') then Result := true;
  if (dbeQd4111.text <> '0,000') or (dbeQd4112.text <> '0,000') then Result := true;
  if (dbeQd4113.text <> '0,000') or (dbeQd4114.text <> '0,000') then Result := true;
  if (dbeQd4115.text <> '0,000') then Result := true;
end;

function TfrmCadWanProNovasFormulas.fRetCodLinha(strNomLin: String): String;
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

  Else If strNomLin = AnsiLowerCase('Autocoat BT90') Then
    Result := '59'

  Else If strNomLin = AnsiLowerCase('Autocoat BT110') Then
    Result := '15'

  Else If strNomLin = AnsiLowerCase('Autocoat BT130') Then
    Result := '17'

  Else If strNomLin = AnsiLowerCase('Autobase Plus Baseline 100:50') Then
    Result := '19'

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

procedure TfrmCadWanProNovasFormulas.pCriaDataSets;
var
  intCont: Integer;
begin
  qryCadNfm := fCriarQuery('SELECT * FROM WANPRO_CADNFM', Self);

  qryCadNfm.FieldByName('NFM_CODNFM').DisplayLabel := 'Código';
  qryCadNfm.FieldbyName('NFM_DESCRI').DisplayLabel := 'Descrição';
  qryCadNfm.FieldbyName('NFM_DTACAD').DisplayLabel := 'Data Cadastro';
  qryCadNfm.FieldbyName('NFM_LINHA_').DisplayLabel := 'Linha';
  qryCadNfm.FieldbyName('NFM_NOMLIN').DisplayLabel := 'Nome Linha';
  qryCadNfm.FieldbyName('NFM_ALTERN').DisplayLabel := 'Alternativa';
  qryCadNfm.FieldbyName('NFM_MONTAD').DisplayLabel := 'Montadora';
  qryCadNfm.FieldbyName('WAN_CAMADA').DisplayLabel := 'Camada';
  qryCadNfm.FieldbyName('NFM_ACRMOB').DisplayLabel := 'Acréscimo mão de obra';


  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 15 Do
  Begin
    TFloatField(qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
    TFloatField(qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
    TFloatField(qryCadNfm.FieldByName('NFM_QTDD' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
    TFloatField(qryCadNfm.FieldByName('NFM_QD41' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
  End;

  TFloatField(qryCadNfm.FieldByName('NFM_QTDDIL')).DisplayFormat := '0.000';
  TFloatField(qryCadNfm.FieldByName('NFM_QTDDI4')).DisplayFormat := '0.000';
  TFloatField(qryCadNfm.FieldByName('NFM_ACRMOB')).DisplayFormat := '0.00';

  dtsCadNfm := fCriaDataSource(qryCadNfm);
end;

procedure TfrmCadWanProNovasFormulas.pDesabilitaDiluidos(strNomLin: String);
var
  intContador : Integer;
  blnLinDil: Boolean;
begin
  If (qryTabela.State In [dsEdit,dsInsert]) Then
  Begin
    strNomLin := Trim(AnsiLowerCase(strNomLin));

    blnLinDil := MatchStr(strNomLin, [AnsiLowerCase('Wanda PU HS'), AnsiLowerCase('Autocoat BT100'),
                                      AnsiLowerCase('Wanda PU MS'), AnsiLowerCase('Autocoat BT90')]);

    For intContador := 0 To Self.ComponentCount -1 Do
    Begin
      If Self.Components[intContador] Is TDBEditFocus Then
      Begin
        If (LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 7) = 'dbeForm') Or
           (LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 9) = 'dbeCodDil') Then
        Begin
          If (Not blnEdit) Then
            TDBEditFocus(Self.Components[intContador]).Field.AsString := '';
          If (LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 9) = 'dbeCodDil') Then
            TDBEditFocus(Self.Components[intContador]).Enabled := blnLinDil;
        End;

        If  (LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 7) = 'dbeQtdC') Or
            (LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 7) = 'dbeQtdD') Or
            (LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 7) = 'dbeQd41') Or
            (LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 9) = 'dbeQtdDil') Or
            (LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 9) = 'dbeQtdDi4') Then
        Begin
          If (Not blnEdit) Then
            TDBEditFocus(Self.Components[intContador]).Field.AsFloat := 0.000;
          If (LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 7) <> 'dbeQtdC') Then
            TDBEditFocus(Self.Components[intContador]).Enabled := blnLinDil;
        End;

        If MatchStr(fRetCodLinha(strNomLin), ['8','13']) Then
        Begin
          TDBEditFocus(Self.Components[intContador]).Enabled := blnLinDil;
        End
        Else If MatchStr(fRetCodLinha(strNomLin), ['58','59']) Then
        Begin
          If ((LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 7) = 'dbeQtdD') Or
              (LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 9) = 'dbeQtdDil')) And
              (LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 9) <> 'dbeQtdDi4') Then
            TDBEditFocus(Self.Components[intContador]).Enabled := False
          Else
            TDBEditFocus(Self.Components[intContador]).Enabled := blnLinDil;
        End;

        If MatchStr(fRetCodLinha(strNomLin), ['1','4','14','16','27']) Then
        Begin
          If (LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 7) = 'dbeQtdD') And
             (LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 9) <> 'dbeQtdDil') And
             (LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 9) <> 'dbeQtdDi4') Then
            TDBEditFocus(Self.Components[intContador]).Enabled := True;

          If ((LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 9) = 'dbeQtdDil') Or
              (LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 9) = 'dbeCodDil')) Then
            TDBEditFocus(Self.Components[intContador]).Enabled := True;
        End;
      End;
    End;

    If blnEdit Then
      blnEdit := False;
  End;
end;

function TfrmCadWanProNovasFormulas.fAlterarLinha: Boolean;
begin
  Result :=  fMensagem('ATENÇÃO','A Nova Fórmula foi cadastrada com a linha ' + dbeLinha_.Text + ',' + #13#10 +
                                 'com a alteração da linha será necessário' + #13#10 +
                                 'informar as bases e quantidades da Nova Fórmula novamente.' + #13#10 +
                                 'Deseja Continuar ?',['&Sim','&Não']) = 1;

  If Not Result Then
    btnCancela.Click;
end;

function TfrmCadWanProNovasFormulas.fInformarBase: Boolean;
var
  intContador : Integer;
begin
  Result := false;
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin
    If Self.Components[intContador] Is TDBEditFocus Then
    Begin
      if(LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 7) = 'dbeForm')
      and (TDBEditFocus(Self.Components[intContador]).Text <> '') then
        Result := true;
    End;
  End;
end;

procedure TfrmCadWanProNovasFormulas.pLigaDataSets;
var
  intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadNfm;
    End;
  End;

  cbbLinha.DataBinding.DataSource := dtsCadNfm;

  dbeCodigo.DataField := 'NFM_CODNFM';
  dbeDtaCad.DataField := 'NFM_DTACAD';
  dbeDescri.DataField := 'NFM_DESCRI';
  dbeLinha_.DataField := 'NFM_LINHA_';
  dbeAltern.DataField := 'NFM_ALTERN';
  dbeMontad.DataField := 'NFM_MONTAD';
  dbeCamada.DataField := 'WAN_CAMADA';
  cbbLinha.DataBinding.DataField := 'NFM_NOMLIN';
  dbeAcrMob.DataField := 'NFM_ACRMOB';

  For intCont := 1 To 15 Do
  Begin
    TDBEdit(FindComponent('dbeForm' + fStrZero(intCont, 2))).DataField := 'NFM_CODB' + fStrZero(intCont, 2);
    TDBEdit(FindComponent('dbeQtdC' + fStrZero(intCont, 2))).DataField := 'NFM_QTDC' + fStrZero(intCont, 2);
    TDBEdit(FindComponent('dbeQtdD' + fStrZero(intCont, 2))).DataField := 'NFM_QTDD' + fStrZero(intCont, 2);
    TDBEdit(FindComponent('dbeQd41' + fStrZero(intCont, 2))).DataField := 'NFM_QD41' + fStrZero(intCont, 2);
  End;
end;

procedure TfrmCadWanProNovasFormulas.cbbLinhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_Return) Then
  Begin
    pProximoControle(Sender);
  End
  Else If (Key = VK_Escape) Then
  Begin
    pEscapePressed;
  End;
end;

procedure TfrmCadWanProNovasFormulas.cbbLinhaPropertiesChange(Sender: TObject);
begin

  If (qryTabela.State = dsInsert) Or ((qryTabela.State = dsEdit) And fAlterarLinha) Then
  Begin
    dbeLinha_.Text := fRetCodLinha(cbbLinha.Text);

    pDesabilitaDiluidos(cbbLinha.Text);
  End;

end;


initialization
  RegisterClass(TfrmCadWanProNovasFormulas);
finalization
  UnRegisterClass(TfrmCadWanProNovasFormulas);
end.

