unit untCadMixNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, DBCtrls, DBEditFocus, StrUtils, DB, AppEvnts, Uni,
  DBComboBoxFocus, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadMixNovasFormulas = class(TfrmPaiCad)
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
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
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
    Label5: TLabel;
    Label6: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    dbeQtdD01: TDBEditFocus;
    dbeQtdD02: TDBEditFocus;
    dbeQtdD03: TDBEditFocus;
    dbeQtdD04: TDBEditFocus;
    dbeQtdD05: TDBEditFocus;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    dbeQtdD06: TDBEditFocus;
    dbeQtdD07: TDBEditFocus;
    dbeQtdD08: TDBEditFocus;
    dbeQtdD09: TDBEditFocus;
    dbeQtdD10: TDBEditFocus;
    Label34: TLabel;
    dbeVolCon: TDBEditFocus;
    dbeVolDil: TDBEditFocus;
    Label35: TLabel;
    dbeMontad: TDBEditFocus;
    Label37: TLabel;
    dbeRefere: TDBComboBoxFocus;
    Label36: TLabel;
    Label38: TLabel;
    dbeAno: TDBEditFocus;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    dbeForm11: TDBEditFocus;
    dbeQtdC11: TDBEditFocus;
    dbeForm12: TDBEditFocus;
    dbeQtdC12: TDBEditFocus;
    dbeForm13: TDBEditFocus;
    dbeQtdC13: TDBEditFocus;
    dbeForm14: TDBEditFocus;
    dbeQtdC14: TDBEditFocus;
    dbeForm15: TDBEditFocus;
    dbeQtdC15: TDBEditFocus;
    dbeQtdD11: TDBEditFocus;
    dbeQtdD12: TDBEditFocus;
    dbeQtdD13: TDBEditFocus;
    dbeQtdD14: TDBEditFocus;
    dbeQtdD15: TDBEditFocus;
    dtsCadNfm: TDataSource;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    dbeForm16: TDBEditFocus;
    dbeQtdC16: TDBEditFocus;
    dbeForm17: TDBEditFocus;
    dbeQtdC17: TDBEditFocus;
    dbeForm18: TDBEditFocus;
    dbeQtdC18: TDBEditFocus;
    dbeForm19: TDBEditFocus;
    dbeQtdC19: TDBEditFocus;
    dbeForm20: TDBEditFocus;
    dbeQtdC20: TDBEditFocus;
    dbeQtdD16: TDBEditFocus;
    dbeQtdD17: TDBEditFocus;
    dbeQtdD18: TDBEditFocus;
    dbeQtdD19: TDBEditFocus;
    dbeQtdD20: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure dbeQtdC01Exit(Sender: TObject);
    procedure dtsCadNfmStateChange(Sender: TObject);
  private
    { Private declarations }
    function fFormataFloatLaz(fltValor: Double):Double;
    function fValidarBasePreenchida: Boolean;
    function fInformarDiluente: Boolean;
    function fValidarQntConcDiluida: Boolean;
    function fInformarConcentrada: Boolean;
    procedure pInserirMascara;
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;

  protected
    function fValidaColorante(strCodCol: String): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadMixNovasFormulas: TfrmCadMixNovasFormulas;

implementation

uses
   untModuloTinta, untPai, untLazzumixAutomotivaDinamica,
  untFuncoesSimples, untIConfTinta, untFuncTinta;

{$R *.dfm}

{ TfrmCadMixNovasForumulas }

function TfrmCadMixNovasFormulas.fValidaCampos(Sender: TWinControl;
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
  Else If (Sender = dbeRefere) Then
  Begin
    If (fEmptyStr(dbeRefere.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A referência deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeForm01) Then
  Begin
    If (fEmptyStr(dbeForm01.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos uma base!', ['&Ok']);
      Result := False;
    End
    Else If (Not fValidaColorante(dbeForm01.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Base não encontrada!', ['&Ok']);
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
          (Sender = dbeForm15) Or
          (Sender = dbeForm16) Or
          (Sender = dbeForm17) Or
          (Sender = dbeForm18) Or
          (Sender = dbeForm19) Or
          (Sender = dbeForm20) Then
  Begin
    If (fEmptyStr((TEdit(Sender).Text))) Then
    Begin
      pSetFocus(dbeQtdD20)
    End

    Else If (Not fValidaColorante(TEdit(Sender).Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Base não encontrada!', ['&Ok']);
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
          (Sender = dbeQtdC15) Or
          (Sender = dbeQtdC16) Or
          (Sender = dbeQtdC17) Or
          (Sender = dbeQtdC18) Or
          (Sender = dbeQtdC19) Or
          (Sender = dbeQtdC20) Or
          (Sender = dbeQtdD01) Or
          (Sender = dbeQtdD02) Or
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
          (Sender = dbeQtdD16) Or
          (Sender = dbeQtdD17) Or
          (Sender = dbeQtdD18) Or
          (Sender = dbeQtdD19) Or
          (Sender = dbeQtdD20) Then
  Begin
    strNumCol := RightStr(Sender.Name, 2);
    If (Not fEmptyStr(TEdit(fComponentByName(gpbColorantes, 'dbeForm' + strNumCol)).Text)) Then
    Begin
      TEdit(Sender).Text := FloatToStr(fFormataFloatLaz(fStrToFloat(TEdit(Sender).Text)));

      If (fEmptyStr(TEdit(Sender).Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar a quantidade da Base!', ['&Ok']);
        Result := False;
      End
    {  else if LeftStr(Sender.Name, 7) = 'dbeQtdC' then
      begin
        If (fStrToFloat(TEdit(Sender).Text) <= 0)
          and (fStrToFloat(TEdit(FindComponent('dbeQtdD' + strNumCol)).Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A quantidade deve ser maior que zero!', ['&Ok']);
          Result := False;
        End;
      end
      else if LeftStr(Sender.Name, 7) = 'dbeQtdD' then
      begin
        If (fStrToFloat(TEdit(Sender).Text) <= 0)
          and (fStrToFloat(TEdit(FindComponent('dbeQtdC' + strNumCol)).Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A quantidade deve ser maior que zero!', ['&Ok']);
          Result := False;
        End;
      end;
      }
    End;
  End;

{  Else If (Sender = dbeVolCon) Then
  Begin
    If fEmptyStr(dbeVolCon.Text) Then
    Begin
      dbeVolCon.Field.AsFloat := 0.0;
    End
    Else If Not fEmptyStr(dbeVolDil.Text) Then
    Begin
      If (fStrToFloat(dbeVolDil.Text) <= 0) And (fStrToFloat(dbeVolCon.Text) <= 0) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O Volume concentrado deve ser maior que zero', ['OK']) = -1;
      End;
    End;
  End

  Else If (Sender = dbeVolDil) Then
  Begin
    If fEmptyStr(dbeVolDil.Text) Then
    Begin
      dbeVolDil.Field.AsFloat := 0.0;
    End
    Else If Not fEmptyStr(dbeVolCon.Text) Then
    Begin
      If (fStrToFloat(dbeVolCon.Text) <= 0) And (fStrToFloat(dbeVolDil.Text) <= 0) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O Volume diluido deve ser maior que zero', ['OK']) = -1;
      End;
    End;
  End;
  }

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadMixNovasFormulas.fValidaColorante(
  strCodCol: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LAZ_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_CODBAS = :CODBAS ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBAS').AsString := strCodCol;
    Open;
    Result := (FieldByName('QTD').AsInteger > 0);
    Close;
  End;
end;

procedure TfrmCadMixNovasFormulas.pInserirMascara;
var
  intContador : Integer;
begin
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin
    If Self.Components[intContador] Is TDBEditFocus Then
    Begin
      if(LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 7) = 'dbeQtdC')
      and (TDBEditFocus(Self.Components[intContador]).Text = '') then
        TDBEditFocus(Self.Components[intContador]).Field.AsFloat := 0.0;

      if(LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 7) = 'dbeQtdD')
      and (TDBEditFocus(Self.Components[intContador]).Text = '') then
        TDBEditFocus(Self.Components[intContador]).Field.AsFloat := 0.0;
    End;
  End;
end;

procedure TfrmCadMixNovasFormulas.pInicializaIndices;
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

procedure TfrmCadMixNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'LAZ_CADNFM';
  strNomeCampo  := 'NFM_CODNFM';
  qryTabela     := frmModuloTinta.qryLaz_CadNfm;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  dtsCadNfm.DataSet := qryTabela;
end;

procedure TfrmCadMixNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;

  dbeCodigo.Enabled := False;
  pSetFocus(dbeDescri);
  dbeDtaCad.Field.AsDateTime := Date;

  pInserirMascara;
end;

procedure TfrmCadMixNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodigo.Enabled := False;
  If (dbeDescri.Enabled) Then
    pSetFocus(dbeDescri);

  if (qryTabela.State = dsEdit) then
    pInserirMascara;

end;

procedure TfrmCadMixNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    conf: IConfTinta;
begin

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

  if (fInformarDiluente) and ((fStrToFloat(dbeVolDil.text) = 0.0) or (dbeVolDil.text = ''))then
  begin
    fMensagem('ATENÇÃO!', 'Ao informar uma quantidade diluída, é necessário que o "volume diluído" seja preenchido!', ['&Ok']);
    pSetFocus(dbeVolDil);
    Exit;
  end;

  if (fInformarConcentrada) and ((fStrToFloat(dbeVolCon.text) = 0.0) or(dbeVolCon.text = '')) then
  begin
    fMensagem('ATENÇÃO!', 'Ao informar uma quantidade concentrada, é necessário que o "volume concentrado" seja preenchido!', ['&Ok']);
    pSetFocus(dbeVolCon);
    Exit;
  end;

  if not(fInformarConcentrada) and (fStrToFloat(dbeVolCon.text) > 0.0 ) then
  begin
    fMensagem('ATENÇÃO!', 'A "Quantidade Concentrada" deve ser preenchida ao informar o "Volume Concentrado"!', ['&Ok']);
    Exit;
  end;

  if not(fInformarDiluente) and (fStrToFloat(dbeVolDil.text) > 0.0 ) then
  begin
    fMensagem('ATENÇÃO!', 'A "Quantidade Diluída" deve ser preenchida ao informar o "Volume Diluído"!', ['&Ok']);
    Exit;
  end;

  blnInsert := (qryTabela.State = dsInsert);
  conf := fGetConfTinta('LAZ');
  If (blnInsert) Then
  Begin
    strNfmBri := conf.fGet('PRONFM');
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + VS_strCodEmp + fStrZero(strNfmBri, 5);
  End;

  inherited;
  If (blnGravou) Then
  Begin
    If (fGeraNovasFormulas(qryTabela)) Then
    Begin
      If (blnInsert) Then
      Begin
        conf.pSetInteger('PRONFM', StrToInt(strNfmBri) + 1);
      End;
    End;
    blnGravou := False;
  End;
end;

procedure TfrmCadMixNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strCodigo: String;
begin
  strCodigo := qryTabela.FieldByName('NFM_CODNFM').AsString;

  inherited;

  If (blnExcluiu) Then
  Begin
    pDeletaNovaFormula(strCodigo);
    blnExcluiu := False;
  End;

end;

procedure TfrmCadMixNovasFormulas.dbeForm01KeyPress(Sender: TObject;
  var Key: Char);
  Var
    strSQL: String;
    stlCamInd: TStringList;
    stlDesInd: TStringList;
    qryConsulta: TUniQuery;
begin

  If (fEntraCons(Key)) Then
  Begin

    Key := #0;

    qryConsulta := fCriaQuery;
    stlCamInd := TStringList.Create;
    stlDesInd := TStringList.Create;

    strSQL :=
      ' SELECT                                ' +
      '   BAS_CODBAS AS "Código"              ' +
      '   , BAS_DESBAS AS "Descrição"         ' +
      '   , BAS_EMBALA AS "Embalagem"         ' +
      '   , BAS_PESESP AS "P. Especifico"     ' +
      '   , ITE_CODITE AS "Cód. Item"         ' +
      '   , ITE_DESITE AS "Item"              ' +
      '   , B.AUTOINCREM AS "AUTOINCREM"      ' +
      ' FROM                                  ' +
      '   LAZ_CADBAS B                        ' +
      '   LEFT JOIN CADITE I                  ' +
      '     ON B.BAS_CODITE = I.ITE_CODITE    ' +
      ' WHERE TRUE                            ';

    stlCamInd.Add('BAS_CODBAS');
    stlCamInd.Add('BAS_DESBAS');
    stlCamInd.Add('ITE_CODITE');

    stlDesInd.Add('Código');
    stlDesInd.Add('Cód. Item');
    stlDesInd.Add('Descrição');

    If (pConsultaComp(Self, qryConsulta, 'LAZ_CADBAS', strSQL, stlCamInd, stlDesInd)) Then
    Begin
      TEdit(Sender).Text := qryConsulta.FieldByName('BAS_CODBAS').AsString;
      If fValidaCampos(TEdit(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;

    FreeAndNil(stlCamInd);
    FreeAndNil(stlDesInd);
    FreeAndNil(qryConsulta);

  End;

end;

procedure TfrmCadMixNovasFormulas.dbeQtdC01Exit(Sender: TObject);
begin
  inherited;
  if fEmptyStr((Sender as TDBEditFocus).Text) Then
    (Sender as TDBEditFocus).Text := '0,0';
end;

procedure TfrmCadMixNovasFormulas.dtsCadNfmStateChange(Sender: TObject);
begin
  inherited;
  dbeRefere.Enabled := (dtsCadNfm.DataSet.State in [dsInsert, dsEdit]);
end;

function TfrmCadMixNovasFormulas.fFormataFloatLaz(fltValor: Double): Double;
var
  strValor: String;
  strValor2: String;
begin
  Result   := fltValor;
  strValor := FloatToStr(fltValor);
  if Pos(',',strValor) > 0 then
    strValor2 := Copy(strValor,Pos(',',strValor) + 2,1)
  else
    strValor2 := '0';

  if strValor2 > '5' then
  begin
    strValor2 := Copy(strValor,1,Pos(',',strValor) + 2);
    strValor2 := FormatFloat('###,#0.0',fStrToFloat(strValor2));
    Result := fStrToFloat(strValor2);
  end
  else if strValor2 > '0' then
  begin
     strValor2 := Copy(strValor,1,Pos(',',strValor) + 1);
     Result := fStrToFloat(strValor2);
  end;
end;

function TfrmCadMixNovasFormulas.fInformarConcentrada: Boolean;
begin
  Result := False;

  if (fStrToFloat(dbeQtdC01.text) > 0.0) or (fStrToFloat(dbeQtdC02.text) > 0.0) then  Result := true;
  if (fStrToFloat(dbeQtdC03.text) > 0.0) or (fStrToFloat(dbeQtdC04.text) > 0.0) then  Result := true;
  if (fStrToFloat(dbeQtdC05.text) > 0.0) or (fStrToFloat(dbeQtdC06.text) > 0.0) then  Result := true;
  if (fStrToFloat(dbeQtdC07.text) > 0.0) or (fStrToFloat(dbeQtdC08.text) > 0.0) then  Result := true;
  if (fStrToFloat(dbeQtdC09.text) > 0.0) or (fStrToFloat(dbeQtdC10.text) > 0.0) then  Result := true;
  if (fStrToFloat(dbeQtdC11.text) > 0.0) or (fStrToFloat(dbeQtdC12.text) > 0.0) then  Result := true;
  if (fStrToFloat(dbeQtdC13.text) > 0.0) or (fStrToFloat(dbeQtdC14.text) > 0.0) then  Result := true;
  if (fStrToFloat(dbeQtdC15.text) > 0.0) or (fStrToFloat(dbeQtdC16.text) > 0.0) then  Result := true;
  if (fStrToFloat(dbeQtdC17.text) > 0.0) or (fStrToFloat(dbeQtdC18.text) > 0.0) then  Result := true;
  if (fStrToFloat(dbeQtdC19.text) > 0.0) or (fStrToFloat(dbeQtdC20.text) > 0.0) then  Result := true;
end;

function TfrmCadMixNovasFormulas.fInformarDiluente: Boolean;
begin
  Result := False;

  if (fStrToFloat(dbeQtdD01.text) > 0.0) or (fStrToFloat(dbeQtdD02.text) > 0.0) then  Result := true;
  if (fStrToFloat(dbeQtdD03.text) > 0.0) or (fStrToFloat(dbeQtdD04.text) > 0.0) then  Result := true;
  if (fStrToFloat(dbeQtdD05.text) > 0.0) or (fStrToFloat(dbeQtdD06.text) > 0.0) then  Result := true;
  if (fStrToFloat(dbeQtdD07.text) > 0.0) or (fStrToFloat(dbeQtdD08.text) > 0.0) then  Result := true;
  if (fStrToFloat(dbeQtdD09.text) > 0.0) or (fStrToFloat(dbeQtdD10.text) > 0.0) then  Result := true;
  if (fStrToFloat(dbeQtdD11.text) > 0.0) or (fStrToFloat(dbeQtdD12.text) > 0.0) then  Result := true;
  if (fStrToFloat(dbeQtdD13.text) > 0.0) or (fStrToFloat(dbeQtdD14.text) > 0.0) then  Result := true;
  if (fStrToFloat(dbeQtdD15.text) > 0.0) or (fStrToFloat(dbeQtdD16.text) > 0.0) then  Result := true;
  if (fStrToFloat(dbeQtdD17.text) > 0.0) or (fStrToFloat(dbeQtdD18.text) > 0.0) then  Result := true;
  if (fStrToFloat(dbeQtdD19.text) > 0.0) or (fStrToFloat(dbeQtdD20.text) > 0.0) then  Result := true;
end;

function TfrmCadMixNovasFormulas.fJaExisteEssaBaseNaFormulacao(
  strCodBas: String; dbeForm: TObject): Boolean;
var
  intCont: Integer;
begin
  Result := False;

  For intCont := 1 To 20 Do
  Begin
    If (RightStr(TDBEditFocus(dbeForm).Name, 2) <> fStrZero(intCont,2)) And
       (Not fEmptyStr(TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont,2))).Text)) Then
    Begin
      If TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont,2))).Text = strCodBas Then
        Result := True;
    End;
  End;
end;

function TfrmCadMixNovasFormulas.fValidarBasePreenchida: Boolean;
begin
  Result := false;

  if (dbeForm01.text = '') and ((dbeQtdC01.text <> '0,0') or (dbeQtdD01.text <> '0,0')) then result  := true;
  if (dbeForm02.text = '') and ((dbeQtdC02.text <> '0,0') or (dbeQtdD02.text <> '0,0')) then result  := true;
  if (dbeForm03.text = '') and ((dbeQtdC03.text <> '0,0') or (dbeQtdD03.text <> '0,0')) then result  := true;
  if (dbeForm04.text = '') and ((dbeQtdC04.text <> '0,0') or (dbeQtdD04.text <> '0,0')) then result  := true;
  if (dbeForm05.text = '') and ((dbeQtdC05.text <> '0,0') or (dbeQtdD05.text <> '0,0')) then result  := true;
  if (dbeForm06.text = '') and ((dbeQtdC06.text <> '0,0') or (dbeQtdD06.text <> '0,0')) then result  := true;
  if (dbeForm07.text = '') and ((dbeQtdC07.text <> '0,0') or (dbeQtdD07.text <> '0,0')) then result  := true;
  if (dbeForm08.text = '') and ((dbeQtdC08.text <> '0,0') or (dbeQtdD08.text <> '0,0')) then result  := true;
  if (dbeForm09.text = '') and ((dbeQtdC09.text <> '0,0') or (dbeQtdD09.text <> '0,0')) then result  := true;
  if (dbeForm10.text = '') and ((dbeQtdC10.text <> '0,0') or (dbeQtdD10.text <> '0,0')) then result  := true;
  if (dbeForm11.text = '') and ((dbeQtdC11.text <> '0,0') or (dbeQtdD11.text <> '0,0')) then result  := true;
  if (dbeForm12.text = '') and ((dbeQtdC12.text <> '0,0') or (dbeQtdD12.text <> '0,0')) then result  := true;
  if (dbeForm13.text = '') and ((dbeQtdC13.text <> '0,0') or (dbeQtdD13.text <> '0,0')) then result  := true;
  if (dbeForm14.text = '') and ((dbeQtdC14.text <> '0,0') or (dbeQtdD14.text <> '0,0')) then result  := true;
  if (dbeForm15.text = '') and ((dbeQtdC15.text <> '0,0') or (dbeQtdD15.text <> '0,0')) then result  := true;
  if (dbeForm16.text = '') and ((dbeQtdC16.text <> '0,0') or (dbeQtdD16.text <> '0,0')) then result  := true;
  if (dbeForm17.text = '') and ((dbeQtdC17.text <> '0,0') or (dbeQtdD17.text <> '0,0')) then result  := true;
  if (dbeForm18.text = '') and ((dbeQtdC18.text <> '0,0') or (dbeQtdD18.text <> '0,0')) then result  := true;
  if (dbeForm19.text = '') and ((dbeQtdC19.text <> '0,0') or (dbeQtdD18.text <> '0,0')) then result  := true;
  if (dbeForm20.text = '') and ((dbeQtdC20.text <> '0,0') or (dbeQtdD20.text <> '0,0')) then result  := true;
end;

function TfrmCadMixNovasFormulas.fValidarQntConcDiluida: Boolean;
begin
  result  := false;

  if (dbeForm01.text <> '') and (dbeQtdC01.text = '0,0') and (dbeQtdD01.text = '0,0')then result  := true;
  if (dbeForm02.text <> '') and (dbeQtdC02.text = '0,0') and (dbeQtdD02.text = '0,0')then result  := true;
  if (dbeForm03.text <> '') and (dbeQtdC03.text = '0,0') and (dbeQtdD03.text = '0,0')then result  := true;
  if (dbeForm04.text <> '') and (dbeQtdC04.text = '0,0') and (dbeQtdD04.text = '0,0')then result  := true;
  if (dbeForm05.text <> '') and (dbeQtdC05.text = '0,0') and (dbeQtdD05.text = '0,0')then result  := true;
  if (dbeForm06.text <> '') and (dbeQtdC06.text = '0,0') and (dbeQtdD06.text = '0,0')then result  := true;
  if (dbeForm07.text <> '') and (dbeQtdC07.text = '0,0') and (dbeQtdD07.text = '0,0')then result  := true;
  if (dbeForm08.text <> '') and (dbeQtdC08.text = '0,0') and (dbeQtdD08.text = '0,0')then result  := true;
  if (dbeForm09.text <> '') and (dbeQtdC09.text = '0,0') and (dbeQtdD09.text = '0,0')then result  := true;
  if (dbeForm10.text <> '') and (dbeQtdC10.text = '0,0') and (dbeQtdD10.text = '0,0')then result  := true;
  if (dbeForm11.text <> '') and (dbeQtdC11.text = '0,0') and (dbeQtdD11.text = '0,0')then result  := true;
  if (dbeForm12.text <> '') and (dbeQtdC12.text = '0,0') and (dbeQtdD12.text = '0,0')then result  := true;
  if (dbeForm13.text <> '') and (dbeQtdC13.text = '0,0') and (dbeQtdD13.text = '0,0')then result  := true;
  if (dbeForm14.text <> '') and (dbeQtdC14.text = '0,0') and (dbeQtdD14.text = '0,0')then result  := true;
  if (dbeForm15.text <> '') and (dbeQtdC15.text = '0,0') and (dbeQtdD15.text = '0,0')then result  := true;
  if (dbeForm16.text <> '') and (dbeQtdC16.text = '0,0') and (dbeQtdD16.text = '0,0')then result  := true;
  if (dbeForm17.text <> '') and (dbeQtdC17.text = '0,0') and (dbeQtdD17.text = '0,0')then result  := true;
  if (dbeForm18.text <> '') and (dbeQtdC18.text = '0,0') and (dbeQtdD18.text = '0,0')then result  := true;
  if (dbeForm19.text <> '') and (dbeQtdC19.text = '0,0') and (dbeQtdD18.text = '0,0')then result  := true;
  if (dbeForm20.text <> '') and (dbeQtdC20.text = '0,0') and (dbeQtdD20.text = '0,0')then result  := true;
end;

initialization
  RegisterClass(TfrmCadMixNovasFormulas);
finalization
  UnRegisterClass(TfrmCadMixNovasFormulas);

end.

