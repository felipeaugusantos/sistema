{***************************}
{* qryConPor -> CADPOR     *}
{************************JB*}

unit untDigPortador;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, Windows, Messages, untFrameCentroCustoEditFocus;

type
  TfrmDigPortador = class(TfrmPaiSimples)
    lblPor: TLabel;
    edtPorBai: TEditFocus;
    edtCodPorBai: TEditFocus;
    pnlFundo: TPanel;
    lbl1: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlHistorico: TPanel;
    edtHist01: TEditFocus;
    lblHist1: TLabel;
    pnlCentroCusto: TPanel;
    fraCentroCusto: TfraCentroCustoEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure edtPorBaiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    qryConPor: TUniQuery;
    qryConOpe: TUniQuery;
    dtaValidaPortador : TDateTime;
    procedure SetMostraVendedor(const Value: Boolean);

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodPor  : String;
    strCodVen  : String;
    strEvento  : String;
    LHistorico01 : String;
    blnConfirma: Boolean;
    blnTraVazio: Boolean;
    blnConfInfo: Boolean;
    blnValidarPDD: Boolean;
    FValidaPermissaoEstornoReceber: Boolean;
    blnVeioAgrupCTP : Boolean;
    strCodEveSugAgrup : String;

    procedure pCarregaPortador;
    procedure pCarregaVendedor;
    procedure pCarregaEvento;
    procedure setDataPortador(dtaDtaPor:TDateTime);
    property bolMostraVendedor: Boolean write SetMostraVendedor;
  end;


implementation

uses untfuncoesSimples, untPesqAux, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmDigPortador }

function TfrmDigPortador.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strCodOpeBus : String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtHist01)Then
    Begin
      LHistorico01 := edtHist01.Text;
    End Else
    If (Sender = edtPorBai) And (edtPorBai.Enabled) Then
    Begin
      If fEmptyStr(edtPorBai.Text) Then
      Begin
        If blnTraVazio Then
        Begin
          fMensagem('ATENÇÃO!', 'O portador deve ser preenchido!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        pCarregaPortador;
        If qryConPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If Not fEmpresaTemAcessoPortador(edtPorBai.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If FValidaPermissaoEstornoReceber And
                qryConPor.FieldByName('POR_ESTCTR').AsString.Equals('N') Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador sem permissão para realização de estorno!' + #13#10 + 'Verifique o Cadastro de Portadores.', ['&Ok']);
          Result := False;

        End
        Else If blnValidarPDD and fRetGeraTituloPDDPortador(edtPorBai.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador definido como PDD. Verifique o Cadastro de Portadores - Gera Títulos PDD".', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          strCodPor := edtPorBai.Text;
          if dtaValidaPortador > 0 then
            if fRetDataPortador(strCodPor) > dtaValidaPortador then
            begin
              fMensagem('Atenção', 'Data de início do portador selecionado é superior a data do documento.' + #13 +
                                   ' Selecione um novo portador.',['&OK']);
              pSetFocus(Sender);
              Result := False;
              Exit;
            end;

          Result    := (Not blnConfInfo) Or fPergunta('Confirma a operação para o Portador ' +
                                        edtPorBai.Text + ' - ' + edtCodPorBai.Text + '?');
        End;

        If Result Then
        Begin
          If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtPorBai.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Você não possui permissão para utilizar este portador!', ['&OK']);
              Result := False;
            End;
          End;
        End;

      End;
    End

    Else If (Sender = edtCodVen) And edtCodVen.Enabled Then
    Begin
      If fEmptyStr(edtCodVen.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O vendedor deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If (Length(edtCodVen.Text) <= 3) Then
          edtCodVen.Text := fStrZero(edtCodVen.Text, 3)
        Else
        Begin
          strCodOpeBus := fCampoTabela('OPE_CODOPE', 'CADOPE', ['OPE_CODBAR'], [edtCodVen.Text]);
          If Not fEmptyStr(strCodOpeBus) Then
            edtCodVen.Text := strCodOpeBus;
        End;

        pCarregaVendedor;
        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          strCodVen   := edtCodVen.Text;
        End;
      End;
    End

    Else If (Sender = fraCentroCusto.edtCodEve) Then
    Begin
      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        If Not SameText(fraCentroCusto.edtCodEve.Text, '00000') Then
        Begin
          //SetLength(arrEvento, 0);
          strEvento := '';

          pCarregaEvento;
          If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text)='P') Then
          Begin
            fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a pagar!',['&OK']);
            Result := False;
          End
          Else
            strEvento := fraCentroCusto.edtCodEve.Text;

        End;
      End
      Else
      Begin
        If (fCfgSis('CTPOBE', varBoolean)) And blnVeioAgrupCTP Then
        Begin
          fMensagem('ATENÇÃO!', 'O evento deve ser preenchido!', ['&O k']);
          Result := False;
        End;
        fraCentroCusto.edtDesEve.Clear;
      End;

    End
    Else

    if (Sender = btnConfirmaDados) and (not fEmptyDate(DateToStr(dtaValidaPortador))) then
    begin
      Result  := fValidaCampos(edtPorBai, True);
      if Result then
        Result  := fValidaCampos(edtCodVen, True);
      if (Result And blnVeioAgrupCTP) then
        Result  := fValidaCampos(fraCentroCusto.edtCodEve, True);

      fValidaCampos(edtHist01);

      If Not Result Then
        Exit;
    end;

   End;

   If Not Result Then
   begin
     pSetFocus(Sender);
     if Sender is TEditFocus then
       (Sender as TEditFocus).SelectAll;
   end;
end;

procedure TfrmDigPortador.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  blnTraVazio := True;
  blnConfInfo := False;
  blnValidarPDD := False;
  FValidaPermissaoEstornoReceber := False;

  qryConPor   := fCriaQuery(Self);
  qryConOpe   := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
end;

procedure TfrmDigPortador.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  //
end;

procedure TfrmDigPortador.FormShow(Sender: TObject);
 Var
     iTamCentroCusto : integer;
begin
  inherited;

  iTamCentroCusto := pnlCentroCusto.Height;

  If pnlCentroCusto.Visible Then
  Begin

     Self.Height := 166;

     Self.Height := IIF(pnlHistorico.Visible,166 + iTamCentroCusto,166);

     If Not FEmptyStr(strCodEveSugAgrup) Then
     Begin
       fraCentroCusto.edtCodEve.text := strCodEveSugAgrup;
       fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve);
     End;

  End
  Else
  Begin

     Self.Height := IIF(pnlHistorico.Visible,166,142);

  End;

end;

procedure TfrmDigPortador.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, edtPorBai.Text);
  With qryConPor Do
  Begin
    edtCodPorBai.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

{******************************************************************}
{* PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{***************************************************************JU*}
procedure TfrmDigPortador.edtPorBaiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;

begin
  inherited;
  If fEntraCons(Key) Then
    fPesqPortador(conSimples, Self, edtPorBai, edtCodPorBai, qryConPor, Key, arrSel);
end;

procedure TfrmDigPortador.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  inherited;
  case Msg.Message of
    WM_KEYDOWN:
    begin
      if (Msg.wParam = VK_TAB) then
        Msg.wParam :=  VK_RETURN
    end;
  end;

end;

procedure TfrmDigPortador.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  Close;
end;

procedure TfrmDigPortador.btnConfirmaDadosClick(Sender: TObject);
begin
  if fValidaCampos(btnConfirmaDados, true) then
  begin
    blnConfirma := True;
    Close;
  end else
    modalResult := mrNone;
end;

procedure TfrmDigPortador.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
    fPesqOperador(Self, edtCodVen, edtNomVen, qryConOpe, Key, arrSel, True, True);

end;

procedure TfrmDigPortador.pCarregaVendedor;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodVen.Text, False, True);
  With qryConOpe Do
  Begin
    edtNomVen.Text := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmDigPortador.pCarregaEvento;
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmDigPortador.setDataPortador(dtaDtaPor: TDateTime);
begin
  dtaValidaPortador := dtaDtaPor;
end;

procedure TfrmDigPortador.SetMostraVendedor(const Value: Boolean);
begin
  lbl1.Visible := Value;
  edtCodVen.Visible := Value;
  edtNomVen.Visible := Value;
  edtCodVen.Enabled := Value;
  if not Value then
    Height := 113;
end;

end.

