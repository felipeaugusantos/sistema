unit untCfgModeloSMS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Uni, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGridCitel, cxGridLevel,
  cxGrid, UniClientDataSet, Clipbrd, ActiveX, Vcl.OleCtrls, EditFocus, strUtils,
  Vcl.DBCtrls, JPeg, MemoFocus,
  cxDataControllerConditionalFormattingRulesManagerDialog;

Type
  TCamDis = record
    strCamDis: String;
    strValDis: String;
End;

type
  TfrmCfgModeloSMS = class(TfrmPaiConfirma)
    pnlEditor: TPanel;
    pnlCamDis: TPanel;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    dtsCamDis: TDataSource;
    cxGrid1DBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxGrid1DBBandedTableViewCitel1Column1: TcxGridDBBandedColumn;
    cxStyle2: TcxStyle;
    pnlFundo: TPanel;
    mmoMensagem: TMemoFocus;
    btnRegraSMS: TBitBtnLocked;
    pnlContagem: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxGrid1DBBandedTableViewCitel1CellDblClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGrid1DBBandedTableViewCitel1KeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure btnRegraSMSClick(Sender: TObject);
    procedure mmoMensagemChange(Sender: TObject);
  private
    qryModelo: TUniQuery;
    cdsCamDis: TUniClientDataSet;

    FLinkBoleto: Boolean;

    procedure pCarregaModelo;
    procedure pCarregaCamposDisponiveis;
    procedure pCriaClientCamposDisponiveis;
    procedure pGravar;
    procedure pApagaModelo;
    procedure pGravaModelo;

    function CarregaDadosDeModeloPadrao(ACodigoModelo: String): String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    strSeqGer: String;
    strEspDoc: String;
    strCodGru: String;
  end;

var
  frmCfgModeloSMS: TfrmCfgModeloSMS;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConstantes;

{ TfrmCfgModeloSMS }

procedure TfrmCfgModeloSMS.btnConfirmaClick(Sender: TObject);
begin
  If (fVerificaCampos) Then
  Begin
    pGravar;
    ModalResult := mrOk;
    inherited;
  End
  Else
    ModalResult := mrNone;
end;

procedure TfrmCfgModeloSMS.btnRegraSMSClick(Sender: TObject);
  var
    AMensagem: String;
begin
  inherited;
  AMensagem := 'Essa funcionalidade só será atiavada quando:           ' + #13#10 +
               ' - As duplicatas possuírem boletos gerados.            ' + #13#10 +
               ' - A funcionalidade de envio de email estiver ativada. ' + #13#10 +
               ' - As duplicatas estiverem em aberto.                  ' + #13#10 +
               ' - A data de vencimento estiver dentro do período.     ' + #13#10 + #13#10;

  AMensagem := AMensagem +
               'Para mensagens maiores de 150 caracteres, é necessário ' + #13#10 +
               'entrar em contato com o Zenvia, para ativar essa       ' + #13#10 +
               'funcionalidade.                                        ';

  fMensagem('Regras de Envio de SMS', AMensagem, ['&Ok'], 1, False, 2, 0, False, 0, False, False, False, 250);
end;

function TfrmCfgModeloSMS.CarregaDadosDeModeloPadrao(
  ACodigoModelo: String): String;
  Var
    LTexto: String;
begin
  Result := EmptyStr;

  LTexto := ' que vencerá em <<DIASVEN>> dia(s)';
  If ACodigoModelo.Equals('024') Then
    LTexto := ' que venceu em <<DIASVEN>> dia(s)';

  Result := Result + 'Esse é um aviso que existe uma cobrança ' + LTexto + '.';
  Result := Result + '<<csq>>Dados da Cobrança:<<csq>>';
  Result := Result + 'Duplicata: <<NROVEN>> <<csq>>Data Vencimento:<<DTAVEN>> <<csq>>Valor: <<VALDUP>>';
  Result := Result + '<<csq>><<csq>>';
  Result := Result + '*** Caso a liquidação da duplicata já tenha sido efetuada, desconsidere esse aviso. ***';

  fMensagem('AVISO',
            'O modelo de e-mail carregado está com o texto padrão. ' + #13 +
                'Poderá ser alterado conforme sua necessidade, limitado aos campos disponíveis.',
            ['&Ok']);
end;

procedure TfrmCfgModeloSMS.cxGrid1DBBandedTableViewCitel1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  mmoMensagem.Text := mmoMensagem.Text + cdsCamDis.FieldByName('VALCAM').AsString;
  pSetFocus(mmoMensagem);

  SendMessage(mmoMensagem.Handle, WM_VSCROLL, SB_BOTTOM, 0);
  SendMessage(mmoMensagem.Handle, WM_HSCROLL, SB_RIGHT, 0);
  mmoMensagem.SelStart := Length(mmoMensagem.Text);
end;

procedure TfrmCfgModeloSMS.cxGrid1DBBandedTableViewCitel1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
    SelectNext((ActiveControl), True, True);
end;

procedure TfrmCfgModeloSMS.FormActivate(Sender: TObject);
begin
  inherited;

  Self.WindowState := wsMaximized;
end;

procedure TfrmCfgModeloSMS.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(qryModelo);
  FreeAndNil(cdsCamDis);
end;

procedure TfrmCfgModeloSMS.FormCreate(Sender: TObject);
begin
  inherited;

  qryModelo := fCriaQuery(Self);

  FLinkBoleto := VarToString(fCfgSis('LNKBOL')).Trim <> '';
end;

procedure TfrmCfgModeloSMS.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_RETURN) And ((ActiveControl) = mmoMensagem) Then
  Begin
    blnMudarFoco := False;
  End
  Else
    inherited;
end;

procedure TfrmCfgModeloSMS.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaModelo;
  pCarregaCamposDisponiveis;
  pSetFocus(mmoMensagem);

  btnRegraSMS.Visible := strCodGru = '009';

  mmoMensagem.OnChange(mmoMensagem);
end;

function TfrmCfgModeloSMS.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mmoMensagem) Then
    Begin
      If (fEmptyStr(mmoMensagem.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A mensagem deve ser preenchida!', ['&OK']);
        Result := False;
      End;
    End;

    If (Not Result) Then
      pSetFocus(Sender);
  End;

end;

procedure TfrmCfgModeloSMS.mmoMensagemChange(Sender: TObject);
begin
  inherited;
  pnlContagem.Caption := 'A mensagem terá ' + Length(mmoMensagem.Text).ToString + ' caracteres aproximadamente';
end;

procedure TfrmCfgModeloSMS.pApagaModelo;
Var
  strSQL: String;
begin

  Try

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM MODSMS WHERE MOD_SEQGER = :SEQGER ';

    With qryModelo Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQGER').AsString := strSeqGer;
      ExecSQL;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmCfgModeloSMS.pApagaModelo]');
  End;

end;

procedure TfrmCfgModeloSMS.pCarregaCamposDisponiveis;
Var
  intContador: Integer;
begin
  pCriaClientCamposDisponiveis;

  For intContador := 0 To Length(arrVarEma) -1 Do
  Begin
    If arrVarEma[intContador][0] = '<<TABDUPPX>>' Then
      Continue;

    If (arrVarEma[intContador][2] = 'TODAS') Or (Pos(strEspDoc, arrVarEma[intContador][2]) > 0) Then
    Begin
      If arrVarEma[intContador][0] = '<<LNKBOL>>' Then
      Begin
        If Not FLinkBoleto Then
          Continue;
      End;

      If strEspDoc = 'PX' Then
      Begin
        If arrVarEma[intContador][0] = '<<NUMEOS>>' Then
          Continue;
      End;

      If strEspDoc = 'TE' Then
      Begin
        If (Pos(fCfgSis('OPCROM', varString), '1_5_') > 0) and (Pos(arrVarEma[intContador][0], '<<DOCVEN>>_<<EMPVEN>>_<<NROVEN>>_<<ESPVEN>>_') > 0) then
          Continue
        Else If (Pos(fCfgSis('OPCROM', varString), '1_5_') <= 0) and (Pos(arrVarEma[intContador][0], '<<PEDVEN>>_') > 0) then
          Continue;
      End;

      If (strEspDoc = 'BO') and (MatchStr(arrVarEma[intContador][0], ['<<CGCEMP>>', '<<CGCCLI>>', '<<SERIE_>>', '<<ACESSO>>', '<<HOREMI>>', '<<ENDEMP>>', '<<ENDCLI>>'])) Then
        Continue;

      cdsCamDis.Insert;
      cdsCamDis.FieldByName('CAMDIS').AsString := arrVarEma[intContador][1];
      cdsCamDis.FieldByName('VALCAM').AsString := arrVarEma[intContador][0];
      cdsCamDis.Post;
    End;
  End;

  cdsCamDis.Open;
  dtsCamDis.DataSet := cdsCamDis;
end;

procedure TfrmCfgModeloSMS.pCarregaModelo;
  Var
    strSQL: String;

    LCodigoModelo: String;
begin
  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  MOD_MODELO AS MODELO  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  MODSMS ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  MOD_SEQGER = :SEQGER ';

    qryModelo.Close;
    qryModelo.SQL.Text := strSQL;
    qryModelo.ParamByName('SEQGER').AsString := strSeqGer;
    qryModelo.Open;

    If (Not qryModelo.IsEmpty)Then
    Begin
      mmoMensagem.Text := AnsiReplaceStr(qryModelo.FieldByName('MODELO').Value, STRING_QUEBRA, STRING_ENTER);

      Exit;
    End;

    If Not strEspDoc.Equals('AC') Then
      Exit;

    LCodigoModelo := fCampoTabela('SMS_CODIGO', 'SMSSAI', ['AUTOINCREM'], [strSeqGer]);

    If MatchStr(LCodigoModelo, ['023', '024']) Then
      mmoMensagem.Text := CarregaDadosDeModeloPadrao(LCodigoModelo).Replace(STRING_QUEBRA, STRING_ENTER);
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmCfgModeloSMS.pCarregaModelo]');
  End;

end;

procedure TfrmCfgModeloSMS.pCriaClientCamposDisponiveis;
begin

  cdsCamDis := TUniClientDataSet.Create(Self);
  {***********************************}
  {* DEFINIÇÃO DOS CAMPOS            *}
  {********************************PZ*}
  With cdsCamDis.FieldDefs.AddFieldDef Do Begin Name := 'CAMDIS'; DataType := ftString; Size := 050; Required := False; End;
  With cdsCamDis.FieldDefs.AddFieldDef Do Begin Name := 'VALCAM'; DataType := ftString; Size := 050; Required := False; End;

  cdsCamDis.CreateDataSet;
end;

procedure TfrmCfgModeloSMS.pGravaModelo;
Var
  strSQL   : String;
  strAutInc: String;
begin

  Try

    fStartTransaction;

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO ';
    strSQL := strSQL + '  MODSMS(AUTOINCREM,  ';
    strSQL := strSQL + '         MOD_SEQGER,  ';
    strSQL := strSQL + '         MOD_MODELO)  ';
    strSQL := strSQL + '  VALUES(:AUTINC,     ';
    strSQL := strSQL + '         :SEQGER,     ';
    strSQL := strSQL + '         :MODELO)     ';

    With qryModelo Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      strAutInc := fRetAutoIncrem('MODSMS', VS_strCodEmp);

      ParamByName('AUTINC').AsString := strAutInc;
      ParamByName('SEQGER').AsString := strSeqGer;
      ParamByName('MODELO').Value    := AnsiReplaceStr(mmoMensagem.Text, STRING_ENTER, STRING_QUEBRA);
      ExecSQL;
    End;

    fCommit;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(e.Message, '[TfrmCfgModeloSMS.pGravaModelo]');
    End;
  End;

end;

procedure TfrmCfgModeloSMS.pGravar;
begin
  pApagaModelo;
  pGravaModelo;
end;

end.
