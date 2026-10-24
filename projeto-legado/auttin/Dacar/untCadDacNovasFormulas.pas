unit untCadDacNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, DBCtrls, DBEditFocus, StrUtils, DB, AppEvnts, Uni,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadDacNovasFormulas = class(TfrmPaiCad) 
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dbeCodNfm: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    gpbColorantes: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    dbeForm01: TDBEditFocus;
    dbeForm02: TDBEditFocus;
    dbeForm03: TDBEditFocus;
    dbeForm04: TDBEditFocus;
    dbeForm05: TDBEditFocus;
    dbeForm06: TDBEditFocus;
    dbeForm07: TDBEditFocus;
    dbeForm08: TDBEditFocus;
    dbeForm09: TDBEditFocus;
    dbeForm10: TDBEditFocus;
    dbeCodPro: TDBEditFocus;
    Label2: TLabel;
    dbeBase: TDBEditFocus;
    Label6: TLabel;
    dbeUnidad: TDBEditFocus;
    Label5: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    dbeForm11: TDBEditFocus;
    dbeForm12: TDBEditFocus;
    dbeForm13: TDBEditFocus;
    dbeForm14: TDBEditFocus;
    dbeForm15: TDBEditFocus;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    rgbOpcao: TDBRadioGroup;
    dbeQtdC01: TEditFocus;
    dbeQtdC02: TEditFocus;
    dbeQtdC03: TEditFocus;
    dbeQtdC04: TEditFocus;
    dbeQtdC05: TEditFocus;
    dbeQtdC06: TEditFocus;
    dbeQtdC07: TEditFocus;
    dbeQtdC08: TEditFocus;
    dbeQtdC09: TEditFocus;
    dbeQtdC10: TEditFocus;
    dbeQtdC11: TEditFocus;
    dbeQtdC12: TEditFocus;
    dbeQtdC13: TEditFocus;
    dbeQtdC14: TEditFocus;
    dbeQtdC15: TEditFocus;
    dtsDacCadNfm: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodProKeyPress(Sender: TObject; var Key: Char);
    procedure dbeQtdC01KeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeQtdC01Exit(Sender: TObject);
    procedure rgbOpcaoChange(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure dbeQtdC15Exit(Sender: TObject);
  private
    { Private declarations }
    procedure pCarregarDados;
    function fFormataOnca(strValor: String): String;
    function fMlParaOnca(strValor: String): String;
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;

    procedure pMudarParaOnca;
    procedure pMudarParaML;
    procedure pGravar;
    procedure pLimparTodos;
  protected
    function fValidaColorante(strCodCol: String): Boolean;
    function fBaseCadastrada(strCodFml: String; strBase: String = ''; strUnidad: String = ''): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    procedure pMudarStatus;
  public
    { Public declarations }
  end;
  

var
  frmCadDacNovasFormulas: TfrmCadDacNovasFormulas;

implementation

uses untModuloTinta, untPai, untConstantes, untDacarImobiliaria,
     untIConfTinta, untFuncTinta, untFuncoesSimples, untDacar, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmCadDacNovasForumulas }

function TfrmCadDacNovasFormulas.fBaseCadastrada(strCodFml: String; strBase: String = ''; strUnidad: String = ''): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BAS_DESCRI ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  DAC_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_CODFML = :CODFML ';
  If (Not fEmptyStr(strBase)) Then
    strSQL := strSQL + '  AND BAS_BASE__ = :BASE ';

  If (Not fEmptyStr(strUnidad)) Then
    strSQL := strSQL + '  AND BAS_UNIDAD = :UNIDAD ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODFML').AsString  := strCodFml;

    If (Not fEmptyStr(strBase)) Then
      ParamByName('BASE').AsString := strBase;

    If (Not fEmptyStr(strUnidad)) Then
      ParamByName('UNIDAD').AsString := strUnidad;

    Open;
    Result := (Not IsEmpty);
    If (fEmptyStr(dbeDescri.Field.AsString)) And
       (qryTabela.State <> dsBrowse)         And
       (Not fEmptyStr(strBase))              Then
    Begin
      dbeDescri.Field.AsString := FieldByName('BAS_DESCRI').AsString;
    End;
    Close;
  End;
end;

function TfrmCadDacNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNumCol: String;
begin

  Result := True;

  If (Sender = dbeCodNfm) Then
  Begin
  End

  Else If (Sender = dbeCodPro) Then
  Begin
    If (fEmptyStr(dbeCodPro.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A base deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Not fBaseCadastrada(dbeCodPro.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base nao está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeBase) Then
  Begin
    If (fEmptyStr(dbeBase.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A base deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Not fBaseCadastrada(dbeCodPro.Text, dbeBase.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base nao está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End

  {*****************************************}
  {* VALIDA A UNIDADE                      *}
  {**************************************MV*}
  Else If (Sender = dbeUnidad) Then
  Begin

    If (fEmptyStr(dbeUnidad.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['&O k']);
      Result := False;
    End

    Else If fEmptyStr(fRetNomUnidade(dbeUnidad.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa unidade não está cadastrada!', ['&O k']);
      Result := False;
    End

    Else If (Pos(dbeUnidad.Text, UNIDADES_BASE) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa não é uma unidade válida (' + AnsiReplaceStr(UNIDADES_BASE, '_', ' ') + ')', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeDescri) Then
  Begin
    If (fEmptyStr(dbeDescri.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
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
      pSetFocus(dbeQtdC15);
    End

    Else If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base já está cadastrada para essa fórmula!', ['&Ok']);
      Result := False;
    End

    Else If (Not fValidaColorante(TEdit(Sender).Text)) Then
    Begin
      Result := False;
    End;
  End

  Else If (Sender = dbeQtdC01) Or
          (Sender = dbeQtdC02) Or
          (Sender = dbeQtdC02) Or
          (Sender = dbeQtdC03) Or
          (Sender = dbeQtdC04) Or
          (Sender = dbeQtdC05) Or
          (Sender = dbeQtdC06) Or
          (Sender = dbeQtdC07) Or
          (Sender = dbeQtdC08) Or
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
      If (fEmptyStr(TEdit(Sender).Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar a quantidade do colorante!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        Try
          If fOncasParaMl(TEdit(Sender).Text) <= 0.0 Then
          Begin
            fMensagem('ATENÇÃO!', 'A quantidade do colorante deve ser maior que Zero!', ['&Ok']);
            Result := False;
          End;
        Except
          If fStrToFloat(TEdit(Sender).Text) <= 0.0 Then
          Begin
            fMensagem('ATENÇÃO!', 'A quantidade do colorante deve ser maior que Zero!', ['&Ok']);
            Result := False;
          End;
        End;

      End;

    End;
  End
end;

function TfrmCadDacNovasFormulas.fValidaColorante(
  strCodCol: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  DAC_CADCOL ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  COL_CODCOL = :CODCOL ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCOL').AsString := strCodCol;
    Open;
    Result := (FieldByName('QTD').AsInteger > 0);
    Close;
  End;
end;

procedure TfrmCadDacNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('NFM_CODPRO');
  stlCampos.Add('NFM_BASE__');
  stlCampos.Add('NFM_UNIDAD');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODNFM');
  stlCamInd.Add('NFM_DESCRI');
  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadDacNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'DAC_CADNFM';
  strNomeCampo  := 'NFM_CODNFM';
  qryTabela     := frmModuloTinta.qryDac_CadNfm;

  dtsDacCadNfm.DataSet := frmModuloTinta.qryDac_CadNfm;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodNfm;

end;

procedure TfrmCadDacNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  qryTabela.FieldByName('NFM_UNIDAD').AsString := 'LT';
  rgbOpcao.ItemIndex := 0;
  
  dbeCodNfm.Enabled := False;
  pSetFocus(dbeCodPro);
  pMudarStatus;
  pLimparTodos;
end;

procedure TfrmCadDacNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  pLimparTodos;
  pCarregarDados;
  inherited;
  dbeCodNfm.Enabled := False;
  dbeCodPro.Enabled := False;
  dbeBase.Enabled   := False;
  If (dbeDescri.Enabled) Then
    pSetFocus(dbeDescri);

  pMudarStatus;
end;

procedure TfrmCadDacNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    conf: IConfTinta;
begin
  conf   := fGetConfTinta('DAC');
  rgbOpcao.ItemIndex := 0;
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfmBri := conf.fGet('NXTDAC'); //fArqIniTinta(0, 'DACAR', 'NXTDAC', '0');
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + fStrZero(strNfmBri, 5);
  End;

  pGravar;

  fStartTransaction;
  inherited;

  Try
    If (blnGravou) Then
    Begin
      Screen.Cursor := crHourGlass;
      If (fGeraNovasFormulas(qryTabela)) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('NXTDAC', fStrZero(StrToInt(strNfmBri) + 1, 5)); //fArqIniTinta(1, 'DACAR', 'NXTDAC', fStrZero(StrToInt(strNfmBri) + 1, 5));
        End;
        fCommit;

        fFecharTabela(frmModuloTinta.qryDac_CadDac);
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

  pMudarStatus;
end;

procedure TfrmCadDacNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strCodNfm: String;
    strBase: String;
    strCodPro: String;
begin
  pLimparTodos;
  strCodNfm := dbeCodNfm.Text;
  strBase   := dbeBase.Text;
  strCodPro := dbeCodPro.Text;

  fStartTransaction;
  inherited;

  Try
    If (blnExcluiu) Then
    Begin
      pDeletaNovaFormula(strCodNfm,
                         strBase,
                         strCodPro);
      fCommit;
      blnExcluiu := False;
    End
    Else
      fRollBack;

    pMudarStatus;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnExcluirClick]');
    End;
  End;
end;

procedure TfrmCadDacNovasFormulas.btnCancelaClick(Sender: TObject);
begin
  pLimparTodos;
  inherited;
//  fBaseCadastrada(dbeCodBas.Text);
  pCarregarDados;
  pMudarStatus;
end;

procedure TfrmCadDacNovasFormulas.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqColorantes(Self, conDac, TEdit(Sender), nil, nil, key, arrSel) Then
    If fValidaCampos(TEdit(Sender), True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadDacNovasFormulas.dbeCodProKeyPress(Sender: TObject; var Key: Char);
  Var
    qryConsulta: TUniQuery;
    arrSel: TConsultasArray;
begin
  qryConsulta := fCriaQuery;
  Try
    If fPesqBaseTinta(Self, conDacGroupFML, Nil, Nil, qryConsulta, key, arrSel) Then
    Begin
      TEdit(Sender).Text := qryConsulta.FieldByName('BAS_CODFML').AsString;
      qryTabela.FieldByName('NFM_BASE__').AsString := qryConsulta.FieldByName('BAS_BASE__').AsString;
      If fValidaCampos(TEdit(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmCadDacNovasFormulas.dbeQtdC01KeyPress(Sender: TObject;
  var Key: Char);
  Const
    arrChars: String = 'Y,1234567890'#8;
  Var
    intPos: Integer;
    strTexto: string;
begin
  Key := UpCase(Key);
  intPos := TDBEdit(Sender).SelStart;
  strTexto := TDBEdit(Sender).Text;

  if rgbOpcao.ItemIndex = 1 then
  begin
    if (Pos(Key, arrChars) > 0) then
    begin
      if (Key = 'Y') then
      begin
        if (Length(strTexto) <= 0)
          Or (Pos('Y', strTexto) > 0)
          Or (Pos(',', Copy(strTexto, 0, intPos)) > 0) then
        begin
          Key := #0;
        end;
      end
      else if (Key = ',') then
      begin
        if (Length(strTexto) <= 0)
          Or (Pos(',', strTexto) > 0)
          Or (Pos('Y', Copy(strTexto, intPos, intPos)) > 0)
          Or (Pos('Y', strTexto) <= 0) then
        begin
          Key := #0;
        end;
      end;
    end
    else
    begin
      Key := #0;
    end;
  end
  else if (rgbOpcao.ItemIndex = 0)then
  begin
    if (Pos(Key, arrChars) > 0) then
    begin
      if (Key = ',') then
      begin
        if (Length(strTexto) <= 0)
          Or (Pos(',', strTexto) > 0)
          Or (Pos('Y', Copy(strTexto, intPos, intPos)) > 0)  then
        begin
          Key := #0;
        end;
      end;
    end
    else
    begin
      Key := #0;
    end;
  end;
end;

procedure TfrmCadDacNovasFormulas.dbeQtdC15Exit(Sender: TObject);
begin
  inherited;
  If rgbOpcao.ItemIndex = 0 Then
  Begin
    Try
      If (Not fEmptyStr(dbeForm15.Text)) Then
        TEdit(Sender).Text := FormatFloat('0.000', fStrToFloat(TEdit(Sender).Text));
    Except
    End;
  End
  Else If rgbOpcao.ItemIndex = 1 Then
  Begin
   Try
     If (Not fEmptyStr(dbeForm15.Text)) Then
       TEdit(sender).Text := fFormataOnca(TEdit(sender).Text);
   Except
     TEdit(sender).Text := '0Y00';
   End;
  End;
end;

procedure TfrmCadDacNovasFormulas.pCarregarDados;
  Var
    intCont: Integer;
begin
  For intCont := 1 To 15 Do
  Begin
    If Pos('Y', qryTabela.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsString) > 0 Then
      TEdit(FindComponent('dbeQtdC' + fStrZero(intCont, 2))).Text := qryTabela.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsString
    Else
      TEdit(FindComponent('dbeQtdC' + fStrZero(intCont, 2))).Text := FormatFloat('0.000', fStrToFloat(AnsiReplaceStr(qryTabela.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsString, '.', ',')));
  End;
end;

procedure TfrmCadDacNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  pLimparTodos;
  key := '/';
  If fPesqFormulaTinta(Self, conDac, Nil, qryTabela, key, arrSel) Then
  Begin
    pCarregarDados;
    pMudarStatus;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadDacNovasFormulas.dbeQtdC01Exit(Sender: TObject);
begin
  inherited;

  If rgbOpcao.ItemIndex = 0 Then
  Begin
    Try
      TEdit(Sender).Text := FormatFloat('0.000', fStrToFloat(TEdit(Sender).Text));
    Except
    End;
  End
  Else If rgbOpcao.ItemIndex = 1 Then
  Begin
   Try
     TEdit(sender).Text := fFormataOnca(TEdit(sender).Text);
   Except
     TEdit(sender).Text := '0Y00';
   End;
  End;
end;

function TfrmCadDacNovasFormulas.fFormataOnca(strValor: String): String;
  Var
    intPosY: Integer;
    strInteiro: String;
    strFracao: String;

    intInteiro: Integer;
    fltFracao: Double;

    procedure processaFracao;
    begin
      intInteiro := intInteiro + (Trunc(fltFracao) div 48);
      fltFracao := fltFracao - ((Trunc(fltFracao) div 48) * 48);
    end;

begin
  Result := '';
  intPosY := Pos('Y', strValor);

  If intPosY > 0 Then
  Begin
    intInteiro := StrToIntDef(Copy(strValor, 1, intPosY - 1), 0);
    fltFracao := fStrToFloat(Copy(strValor, intPosY + 1, Length(strValor)));

    processaFracao;
    strInteiro := FormatFloat('00', intInteiro);
    strFracao := FormatFloat('00.000', fltFracao);
  End
  Else
  Begin
    intInteiro := Trunc(fStrToFloat(strValor));
    fltFracao := Frac(fStrToFloat(strValor)) * 48;

    strInteiro := IntToStr(intInteiro);
    strFracao := FormatFloat('00.000', fltFracao);
  End;

  Result := strInteiro + 'Y' + strFracao;
end;

function TfrmCadDacNovasFormulas.fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
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

function TfrmCadDacNovasFormulas.fMlParaOnca(strValor: String): String;
  Var
    fltValor: Double;
    intInteiro: Integer;
    fltInteiro: Double;
    fltFracao: Double;
begin
  fltValor := fStrToFloat(strValor);
  fltInteiro := fltValor / 29.5735295625;
  intInteiro := Trunc(fltInteiro);
  fltFracao := fltInteiro - intInteiro;
  fltFracao := fltFracao * 48;
  Result := FormatFloat('00', intInteiro) + 'Y' + FormatFloat('00.000', fltFracao);
end;

procedure TfrmCadDacNovasFormulas.pMudarParaML;
  Var
    intCont: Integer;
begin
  For intCont := 1 To 15 Do
  Begin
    TEdit(FindComponent('dbeQtdC' + fStrZero(intCont, 2))).Text :=
      FormatFloat('0.000', fOncasParaMl(TEdit(FindComponent('dbeQtdC' + fStrZero(intCont, 2))).Text));
  End;
end;

procedure TfrmCadDacNovasFormulas.pMudarParaOnca;
  Var
    intCont: Integer;
begin
  For intCont := 1 To 15 Do
  Begin
    TEdit(FindComponent('dbeQtdC' + fStrZero(intCont, 2))).Text :=
      fMlParaOnca(TEdit(FindComponent('dbeQtdC' + fStrZero(intCont, 2))).Text);
  End;
end;

procedure TfrmCadDacNovasFormulas.rgbOpcaoChange(Sender: TObject);
begin
  inherited;
  If rgbOpcao.ItemIndex = 0 Then
  Begin
    If (Not fEmptyStr(dbeQtdC01.Text)) And (Pos('Y', dbeQtdC01.Text) > 0) Then
    Begin
      pMudarParaML;
    End;
  End
  Else If rgbOpcao.ItemIndex = 1 Then
  Begin
    If (Not fEmptyStr(dbeQtdC01.Text)) Then
    Begin
      pMudarParaOnca;
    End;
  End;
end;

procedure TfrmCadDacNovasFormulas.pMudarStatus;
begin
  rgbOpcao.Enabled := qryTabela.State <> dsBrowse;
end;

procedure TfrmCadDacNovasFormulas.btnSairClick(Sender: TObject);
begin
  inherited;
  pMudarStatus;
end;

procedure TfrmCadDacNovasFormulas.pGravar;
  Var
    intCont: Integer;
begin
  For intCont := 1 to 15 Do
  Begin
    qryTabela.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsString :=
      TEdit(FindComponent('dbeQtdC' + fStrZero(intCont, 2))).Text;
  End;
end;

procedure TfrmCadDacNovasFormulas.pLimparTodos;
  Var
    intCont: Integer;
begin
  For intCont := 1 To 15 Do
  Begin
    TEdit(FindComponent('dbeQtdC' + fStrZero(intCont, 2))).Text := '';
  End;
end;
initialization
  RegisterClass(TfrmCadDacNovasFormulas);
finalization
  UnRegisterClass(TfrmCadDacNovasFormulas);

end.


