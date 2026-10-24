unit untFatDigServConsertoEquip;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, untConsertoEquipamento,
  Grids, DBGridCitel, DBGrids, EditFocus, DB, Uni, StrUtils, untFatManConsertoEquip,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatDigServConsertoEquip = class(TfrmPai)
    pnlFundo: TPanel;
    dbgServico: TDBGridCitel;
    pnlTotal: TPanel;
    btnConfirma: TBitBtnLocked;
    dtsServico: TDataSource;
    Label32: TLabel;
    edtTotSer: TEditFocus;
    pnlTopo: TPanel;
    Label1: TLabel;
    edtCodSe1: TEditFocus;
    edtDesSe1: TEditFocus;
    edtValSe1: TEditFocus;
    btnCancelaItem: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtCodTec: TEditFocus;
    edtDesTec: TEditFocus;
    procedure edtCodSe1KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtDesSe1Change(Sender: TObject);
    procedure edtDesSe1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgServicoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodTecKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    intGrava: Integer;
    blnConfServicos: Boolean;
    qryCadSer: TUniQuery;

    strCodSerOld: String;
    fltValSerOld: Double;

    FValOri: Double;

    function fCarregaServico(edtCodSer, edtDesSer: TEditFocus; blnBuscaPorChave: Boolean): Boolean;
    function fValidaValor(edtValor: TEdit): Boolean;
    function GetValOri: Double;
    procedure SetValOri(const Value: Double);
  protected
    procedure pInicializaIndices;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    frmPrincipal: TfrmFatManConsertoEquip;
    objConEqu: TConEqu;
    blnConfirma: Boolean;

    property fltValOri: Double read GetValOri write SetValOri;
  end;

var
  frmFatDigServConsertoEquip: TfrmFatDigServConsertoEquip;

implementation

uses untFuncoesSimples, untConsultas, untFuncFat, untTypesSistema;

{$R *.dfm}

function TfrmFatDigServConsertoEquip.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    edtTemp: TEditFocus;
    arrMenSag  : TStringArray;
    stlNumLib: TStringList;
    strOperador: String;
    strNTrava  : String;
    fltValAlt  : Double;
begin

  Result := True;

  If (Sender = edtCodSe1) Then
  Begin
    If Not fEmptyStr(edtCodSe1.Text) Then
    Begin
      edtTemp := TEditFocus(fComponentByName(pnlTopo, 'edtDesSe' + RightStr(Sender.Name, 1)));
      Result := fCarregaServico(TEditFocus(Sender), edtTemp, blnBuscaPorChave);
    End
    Else
    Begin
      blnMudarFoco := False;
      pSetFocus(btnConfirma);
    End;

  End

  Else If (Sender = edtValSe1) Then
  Begin
    If Not fEmptyStr(edtValSe1.Text) Then
    Begin
      edtTemp := TEditFocus(fComponentByName(pnlTopo, 'edtValSe' + RightStr(Sender.Name, 1)));
      If (edtTemp.Enabled) Then
        Result := fValidaValor(edtTemp);

      If Not fCfgSis('ALTSER', varBoolean) Then
      Begin
        fltValAlt := fFormataFloat(fStrToFloat(edtValSe1.Text), 2);

        If (Result) And (fFormataFloat(fltValSerOld, 2) <> fFormataFloat(fltValAlt, 2)) And (fFormataFloat(fltValOri, 2) <> fFormataFloat(fltValAlt, 2)) Then
        Begin
          stlNumLib := TStringList.Create;

          pAddDados(arrMenSag, 'Alteração de Valor do Serviço.');
          pAddDados(arrMenSag, 'Cliente.......: ' + objConEqu.strCodCli + '-' + fRetNomCliente(objConEqu.strCodCli));
          pAddDados(arrMenSag, 'Equipamento...: ' + AnsiReplaceStr(objConEqu.strDescri, #13#10, ' '));
          pAddDados(arrMenSag, 'Serviço.......: ' + edtCodSe1.Text + '-' + edtDesSe1.Text);
          pAddDados(arrMenSag, 'Valor Original: ' + FormatFloat('#,##0.00', fltValOri));
          pAddDados(arrMenSag, 'Valor Alterado: ' + FormatFloat('#,##0.00', fltValAlt)) ;

          Result := fDigSenVar(arrMenSag,
                               'SENSER',
                               True,
                               fCfgSis('SENSER'),
                               'Digitação de Serviço',
                               False,
                               strLoginUsuarioLogado,
                               strLoginUsuarioLogado,
                               strNTrava,
                               strOperador,
                               stlNumLib);

          If Result Then
            fltValSerOld := fltValAlt;

          FreeAndNil(stlNumLib);
        End
        Else
          fltValSerOld := fltValAlt;
      End;
    End;
  End

  Else If Sender = edtCodTec Then
  Begin
    If fEmptyStr(edtCodTec.Text) Then
    Begin
      fMensagem('', 'O Técnico deve ser preenchido!' , ['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtDesTec.Text := fRetNomeOperador(edtCodTec.Text);
      If fEmptyStr(edtDesTec.Text) Then
      Begin
        fMensagem('AVISO', 'Técnico não encontrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmFatDigServConsertoEquip.fCarregaServico(edtCodSer, edtDesSer: TEditFocus;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strSQL         : String;
    edtValSer      : TEdit;
    intContador    : Integer;
    blnConfirmaServ: Boolean;
    qryGenSer      : TUniQuery;
begin
  qryGenSer := fCriaQuery(Self);

  blnConfServicos := False;
  blnConfirmaServ := True;

  If (RightStr(edtCodSer.Name, 1) = '1') Then
  Begin

    If (fEmptyStr(edtCodSer.Text)) Then
    Begin
      blnConfirmaServ := True;
      For intContador := 2 To 6 Do
      Begin
        edtValSer := TEdit(fComponentByName(pnlTopo, 'edtValSe' + IntToStr(intContador)));
        If (Not fEmptyStr(edtValSer.Text)) And (fStrToFloat(edtValSer.Text) > 0)Then
        Begin
          blnConfirmaServ := False;
          Break;
        End;
      End;
    End;

  End;

  If (Not blnConfirmaServ) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário digitar o primeiro serviço!', ['&Ok']);
    Result := False;
    Exit;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SER_DESSER, ';
  strSQL := strSQL + '  SER_VALSER ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADSER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  SER_CODSER = :CODSER ';

  With qryGenSer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODSER').AsString := edtCodSer.Text;
    Open;

    edtValSer := TEdit(fComponentByName(pnlTopo, 'edtValSe' + RightStr(edtCodSer.Name, 1)));

    edtDesSer.Enabled     := False;
    edtDesSer.TabStop     := False;
    edtDesSer.ReadOnly    := True;
    edtDesSer.NormalColor := $00FFDFB8;

    If (Not IsEmpty) Then
    Begin

      If (fCfgSis('EDISER') = 'S') Then
      Begin
        edtDesSer.Enabled     := True;
        edtDesSer.TabStop     := True;
        edtDesSer.ReadOnly    := False;
        edtDesSer.NormalColor := clWindow;
      End;

      edtValSer.Enabled := True;

      If strCodSerOld <> edtCodSer.Text Then
      Begin
        edtValSer.Text  := FloatToStrF(FieldByName('SER_VALSER').AsFloat, ffFixed, 12, 2);
        fltValOri       := FieldByName('SER_VALSER').AsFloat;
      End;

      If (fEmptyStr(edtDesSer.Text)) Or (Not edtDesSer.Enabled)Then
        edtDesSer.Text  := FieldByName('SER_DESSER').AsString;

      Result := True;
    End
    Else
    Begin
      edtDesSer.Clear;
      edtValSer.Enabled := False;
      edtValSer.Text    := '0,00';

      If (fEmptyStr(edtCodSer.Text)) Then
      Begin
        blnMudarFoco := False;

        If (edtCodSer = edtCodSe1) Then
        Begin
          blnConfServicos := True;
          btnSair.Click;
          Result := False;
        End
        Else
          Result := True;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Esse serviço não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;

    Close;
  End;

  strCodSerOld := edtCodSer.Text;
  fltValSerOld := fStrToFloat(edtValSer.Text);
  
  FreeAndNil(qryGenSer);
end;

function TfrmFatDigServConsertoEquip.fValidaValor(edtValor: TEdit): Boolean;
begin
  Result := True;

  If (fEmptyStr(edtValor.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'O valor deve ser preenchido!', ['&Ok']);
    Result := False;
  End

  Else If (fStrToFloat(edtValor.Text) <= 0.0) Then
  Begin
    fMensagem('ATENÇÃO!', 'O valor deve ser maior que Zero!', ['&Ok']);
    Result := False;
  End;
end;

function TfrmFatDigServConsertoEquip.GetValOri: Double;
begin
  Result := FValOri;
end;

procedure TfrmFatDigServConsertoEquip.edtCodSe1KeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;
  
  If fPesqServicos(Self, edtCodSe1, edtDesSe1, nil, Key, arrSel) Then  
  Begin
    if fValidaCampos(edtCodSe1, True) then
      SelectNext(ActiveControl, True, True);
  End;
  
end;

procedure TfrmFatDigServConsertoEquip.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('SER_CODSER');
  stlCampos.Add('SER_DESSER');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('SER_DESSER');
  stlCamInd.Add('SER_CODSER');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');

end;

procedure TfrmFatDigServConsertoEquip.SetValOri(const Value: Double);
begin
  FValOri := Value;
end;

procedure TfrmFatDigServConsertoEquip.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodSe1);
end;

procedure TfrmFatDigServConsertoEquip.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(stlCampos);
  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);
end;

procedure TfrmFatDigServConsertoEquip.btnSairClick(Sender: TObject);
begin
//  inherited;
  blnConfirma := False;
  Close;
  If (blnConfServicos) Then
    ModalResult := mrOk;
end;

procedure TfrmFatDigServConsertoEquip.FormShow(Sender: TObject);
  var
    strSQL: String;
begin
  inherited;
  strSQL                := 'SELECT * FROM CADSER';
  qryCadSer             := fCriarQuery(strSQL, Self);

  dtsServico.DataSet    := objConEqu.cdsSerEqu;
  dbgServico.DataSource := dtsServico;

  pInicializaIndices;
  blnConfirma := False;
  pSetFocus(edtCodSe1);
end;

procedure TfrmFatDigServConsertoEquip.edtDesSe1Change(Sender: TObject);
begin
  inherited;
  edtDesSe1.Text := fTiraCaracEspeciais(edtDesSe1.Text);
end;

procedure TfrmFatDigServConsertoEquip.edtDesSe1KeyPress(Sender: TObject;
  var Key: Char);
  Var
    strTmp: String;
begin
  inherited;
  strTmp := String(Key);

  strTmp := fTiraCaracNota(strTmp);
  If (strTmp = '') Then
    Key := #0
  Else
    Key := strTmp[1];

  If (Key = 'Ç') Or (Key = 'ç') Then
    Key := 'C';
end;

procedure TfrmFatDigServConsertoEquip.FormCreate(Sender: TObject);
begin
  inherited;
  intGrava := -1;
  strCodSerOld := '';
  fltValSerOld := 0.0;
end;

procedure TfrmFatDigServConsertoEquip.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  edtValSe1.Text := '0,00';
  edtDesSe1.Clear;
  edtCodSe1.Clear;
  edtCodTec.Clear;
  edtDesTec.Clear;
  pSetFocus(edtCodSe1);
end;

procedure TfrmFatDigServConsertoEquip.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodSe1.Text) Then
    Exit;

  If Not fValidaCampos(edtValSe1) Then
    Exit;

  If Not fVerificaCampos Then
    Exit;

  If InterlockedIncrement(intGrava) = 0 Then
  Begin

    Try

      If objConEqu.cdsSerEqu.RecordCount < fCfgSis('LINSER', varInteger) Then
      Begin
        objConEqu.strCodSer := edtCodSe1.Text;
        objConEqu.strDesSer := edtDesSe1.Text;
        objConEqu.fltValSer := fStrToFloat(edtValSe1.text);
        objConEqu.strTecSer := edtCodTec.Text;        

        objConEqu.cdsSerEqu.DisableControls;
        objConEqu.pIncluiServicoGrid;
        objConEqu.cdsSerEqu.EnableControls;
        strCodSerOld := '';

        objConEqu.fltVlrSer := objConEqu.fltVlrSer + fStrToFloat(edtValSe1.text);
        objConEqu.fltVlrCon := objConEqu.fltVlrCon + fStrToFloat(edtValSe1.text);

        objConEqu.strCodSer := EmptyStr;
        objConEqu.strDesSer := EmptyStr;
        objConEqu.fltValSer := 0;

        edtTotSer.Text := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), objConEqu.fltVlrSer);

        dbgServico.Enabled := True;
        dbgServico.Refresh;

        btnCancelaItem.Click;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Número máximo de itens de serviço excedido!', ['&O k']);
      End;

      InterlockedDecrement(intGrava);
    Except
      On e:exception do
      Begin
        InterlockedDecrement(intGrava);
        pMensagensErro(E.Message, 'btnAdicionarClick - untFatDigSerConsertoEquip');
      End;
    End;

  End
  Else
    InterlockedDecrement(intGrava);

  frmPrincipal.edtTotGer.Text := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), objConEqu.fltVlrCon);
  frmPrincipal.edtTotGerIte.Text := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), objConEqu.fltVlrPro);
  frmPrincipal.edtTotGerSer.Text := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), objConEqu.fltVlrSer);
  Application.ProcessMessages;

end;

procedure TfrmFatDigServConsertoEquip.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If InterlockedIncrement(intGrava) = 0 Then
  Begin
    Try
      objConEqu.fltVlrSer := fStrToFloat(edtTotSer.Text);
      blnConfirma := True;
      Close;
    Except
      On E : Exception do
      Begin
        InterlockedDecrement(intGrava);
        pMensagensErro(E.Message, 'btnConfirmaClick - untFatDigSerConsertoEquip');
      End;
    End;
  End
  Else
    InterlockedDecrement(intGrava);
end;

procedure TfrmFatDigServConsertoEquip.dbgServicoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_DELETE : If btnConfirma.Enabled Then
                Begin
                  If (objConEqu.fPodeExcluirItensServicosDefeitos) And
                     (Not objConEqu.cdsSerEqu.IsEmpty)    And
                     (fMensagem('AVISO', 'Confirma a exclusão do serviço?', ['&Sim', '&Não']) = 1) Then
                  Begin
                    objConEqu.fltVlrCon := objConEqu.fltVlrCon - objConEqu.cdsSerEqu.fieldbyname('VALSER').AsFloat;
                    objConEqu.fltVlrSer := objConEqu.fltVlrSer - objConEqu.cdsSerEqu.fieldbyname('VALSER').AsFloat;
                    objConEqu.cdsSerEqu.Delete;
                    edtTotSer.Text := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), objConEqu.fltVlrSer);

                    frmPrincipal.edtTotGer.Text := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), objConEqu.fltVlrCon);
                    frmPrincipal.edtTotGerIte.Text := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), objConEqu.fltVlrPro);
                    frmPrincipal.edtTotGerSer.Text := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), objConEqu.fltVlrSer);
                    Application.ProcessMessages;
                  End;
                End;
    VK_ESCAPE : btnSair.Click;
    VK_RETURN : If btnConfirma.Enabled Then pSetFocus(btnConfirma);
  End;

end;

procedure TfrmFatDigServConsertoEquip.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
//  inherited;
  Case Key Of
    VK_ESCAPE : btnSair.Click;
    VK_F10: Begin
              Key := 0;
              If btnConfirma.Enabled Then btnConfirma.Click;
            End;
  End;

end;

procedure TfrmFatDigServConsertoEquip.edtCodTecKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryCons: TUniQuery;
    arrSel : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    qryCons := fCriaQuery(Nil);

    if fPesqOperador(Self, edtCodTec, edtDesTec, qryCons, Key, arrSel) then
    Begin
      If (fValidaCampos(edtCodTec, True)) Then
        Self.SelectNext(ActiveControl, True, True);
    End;

    FreeAndNil(qryCons);
  End;

end;

end.
