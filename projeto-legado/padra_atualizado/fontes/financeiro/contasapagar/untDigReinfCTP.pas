unit untDigReinfCTP;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, Windows, Messages, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus;

type
  TfrmDigReinfCTP = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlCentroCusto: TPanel;
    btnLimparDados: TBitBtnLocked;
    gbpREINF: TGroupBox;
    lblNatRend: TLabel;
    lblTipServ: TLabel;
    edtNatRend: TEditFocus;
    edtTipoServico: TEditFocus;
    edtCodNatRend: TEditFocus;
    edtCodTipServ: TEditFocus;
    procedure edtCodNatRendKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure EdtCodTipServKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnLimparDadosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure pCarregaDados(strNumDoc, strCodEmp, strCodFor, ASerie, AParcel : String; ASeqBai: Integer);
    function  fVerificaObrigatorio : Boolean;
    procedure CarregaNaturezaDoRendimento;
    procedure CarregaTipoDeServico;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strNumdup : String;
    strCodfor : String;
    strParcel : String;
    strSerie  : String;
    strCodEmp : String;
    intSeqBai : Integer;
    blnConfirma  : Boolean;
    bnlInserindo : Boolean;
    blnAlterado  : Boolean;
    strIns_CodNat  : String;
    strIns_CodServ : String;
    blnEntrouReinf : boolean;

    strCodNat_Alterado  : String;
    strCodServ_Alterado : String;
  end;

implementation

uses untfuncoesSimples, untPesqAux, untConsultas, untTypesSistema, untPai;

{$R *.dfm}

{ TfrmDigReinfCTP }

Function TfrmDigReinfCTP.FVerificaObrigatorio : Boolean;
Begin
   Result := False;
   If (Not fEmptyStr(edtCodNatRend.Text)) Or (Not fEmptyStr(edtCodTipServ.Text)) Then
      result := True;
End;

procedure TfrmDigReinfCTP.CarregaNaturezaDoRendimento;
begin
  If Not fEmptyStr(edtCodNatRend.Text) Then
    edtNatRend.Text := fRetReinfNaturezaDoRendimento(edtCodNatRend.Text)
  Else
    edtNatRend.Clear;
end;

procedure TfrmDigReinfCTP.CarregaTipoDeServico;
begin
  If Not fEmptyStr(edtCodTipServ.Text) Then
    edtTipoServico.Text := fRetReinfTipoDeServico(edtCodTipServ.Text)
  Else
    edtTipoServico.Clear;
end;

function TfrmDigReinfCTP.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

      If (Sender = edtCodNatRend) Then
      Begin

        If fVerificaObrigatorio Then
        Begin
          CarregaNaturezaDoRendimento;
          If fEmptyStr(edtCodNatRend.Text) Then
          begin
            fMensagem('ATENÇÃO!', 'Informe a Natureza do Rendimento (REINF)!', ['&Ok']);
            Result := False;
          End
          Else
          Begin
            If fEmptyStr(edtNatRend.Text) Then
            Begin
              fMensagem('ATENÇÃO!', 'Natureza do Rendimento inválida (REINF)!', ['&Ok']);
              Result := False;
            End;
          End;
        End;

      End
      Else

      If (Sender = edtCodTipServ) Then
      Begin

        If fVerificaObrigatorio Then
        Begin
          CarregaTipoDeServico;
          If fEmptyStr(edtCodTipServ.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Informe o Tipo de Serviço (REINF)!', ['&Ok']);
            Result := False;
          End
          Else
          Begin
            If fEmptyStr(edtTipoServico.Text) Then
            Begin
              fMensagem('ATENÇÃO!', 'Tipo do Serviço inválido (REINF)!', ['&Ok']);
              Result := False;
            End;
          End;
        End;

      End
      Else

      If (Sender = btnConfirmaDados) Then
      Begin
        If (fValidaCampos(edtCodNatRend, True) = False) And (fValidaCampos(edtCodTipServ, True) = False) Then
           Result := True
        Else
        If (fValidaCampos(edtCodNatRend, True) = true) And (fValidaCampos(edtCodTipServ, True) = true) Then
           Result := True
        Else
           Result := False;

        If Not Result Then
          Exit;
      End;

  End;

  If Not Result Then
  Begin
     pSetFocus(Sender);
     If Sender is TEditFocus Then
       (Sender as TEditFocus).SelectAll;
  End;

end;

procedure TfrmDigReinfCTP.edtCodNatRendKeyPress(Sender: TObject;
  var Key: Char);
  Var
  arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
     fPesqReinfNaturezaDoRendimento(self, edtCodNatRend, edtNatRend, nil, Key, arrSel);
  CarregaNaturezaDoRendimento;
end;

procedure TfrmDigReinfCTP.EdtCodTipServKeyPress(Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
     fPesqReinfTipoDoServico(self, edtCodTipServ, edtTipoServico, nil, Key, arrSel);
  CarregaTipoDeServico;
end;

procedure TfrmDigReinfCTP.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F2: btnLimparDados.Click;
  End;
end;

procedure TfrmDigReinfCTP.FormShow(Sender: TObject);
begin
  inherited;
  If BnlInserindo Then
  Begin
     edtCodNatRend.Text := strIns_CodNat;
     edtCodTipServ.Text := strIns_CodServ;
     CarregaNaturezaDoRendimento;
     CarregaTipoDeServico;
  End
  Else
  Begin
    pCarregaDados(strNumdup, strCodEmp, strCodfor, strSerie, strParcel, intSeqBai);

    If blnAlterado Then
    Begin
      If ((strCodNat_Alterado <> edtCodNatRend.Text) Or (strCodServ_Alterado <> edtCodTipServ.Text)) Then
      Begin
        edtCodNatRend.Text := strCodNat_Alterado;
        edtCodTipServ.Text := strCodServ_Alterado;
        CarregaNaturezaDoRendimento;
        CarregaTipoDeServico;
      End;
    End;

  End;

  pSetFocus(edtCodNatRend);
end;

procedure TfrmDigReinfCTP.ApplicationEventsMessage(var Msg: tagMSG;
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

procedure TfrmDigReinfCTP.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  Close;
end;

procedure TfrmDigReinfCTP.btnConfirmaDadosClick(Sender: TObject);
begin
  if fValidaCampos(btnConfirmaDados, true) then
  begin
    blnConfirma := True;
    blnEntrouReinf := True;
    Close;
  end else
    modalResult := mrNone;
end;

procedure TfrmDigReinfCTP.btnLimparDadosClick(Sender: TObject);
begin
  inherited;

  If fMensagem('ATENÇÃO!', 'Deseja limpar os dados informados?', ['&Sim', '&Não'],2) = 1 Then
  Begin
    edtCodNatRend.Text  := '';
    edtNatRend.Text     := '';
    edtCodTipServ.Text  := '';
    edtTipoServico.Text := '';
  End;

end;

procedure TfrmDigReinfCTP.pCarregaDados(strNumDoc, strCodEmp, strCodFor, ASerie, AParcel : String; ASeqBai: Integer);
  Var
    LConsulta: TUniQuery;
begin

  edtCodNatRend.Text := '';
  edtNatRend.Text    := '';
  edtCodTipServ.Text := '';
  edtTipoServico.Text := '';

  If (Not fEmptystr(strNumDoc)) and (Not fEmptystr(strNumDoc)) and (Not fEmptystr(strCodFor)) Then
  Begin

    Try
      LConsulta := fCriaQuery;

      LConsulta.SQL.Text := ' SELECT           '+
                            '  R.CTP_CODFOR,   '+
                            '  R.CTP_NUMDUP,   '+
                            '  R.CTP_PARCEL,   '+
                            '  R.CTP_CODEMP,   '+
                            '  R.CTP_SEQBAI,   '+
                            '  R.CTP_SERIE_,   '+
                            '  NAT.NAT_CODIGO, '+
                            '  SER.CLA_CODIGO, '+
                            '  NAT.NAT_DESCRI, '+
                            '  SER.CLA_DESCRI  '+
                            '  FROM            '+
                            '        RNFCTP R  '+
                            ' INNER JOIN REINF_TABE01 NAT '+
                            '    ON NAT.NAT_CODIGO = R.NAT_CODIGO '+
                            ' INNER JOIN REINF_TABE06 SER '+
                            '    ON SER.CLA_CODIGO = R.CLA_CODIGO '+
                            ' WHERE '+
                            '       CTP_CODFOR = :CODFOR '+
                            '   AND CTP_NUMDUP = :NUMDUP '+
                            '   AND CTP_PARCEL = :PARCEL '+
                            '   AND CTP_CODEMP = :CODEMP '+
                            '   AND CTP_SEQBAI = :SEQBAI '+
                            '   AND CTP_SERIE_ = :SERIE_ ';

      LConsulta.ParamByName('NUMDUP').AsString := strNumDoc;
      LConsulta.ParamByName('CODFOR').AsString := strCodFor;
      LConsulta.ParamByName('PARCEL').AsString := AParcel;
      LConsulta.ParamByName('SEQBAI').AsInteger := ASeqBai;
      LConsulta.ParamByName('SERIE_').AsString := ASerie;
      LConsulta.ParamByName('CODEMP').AsString := strCodEmp;

      LConsulta.Open;

      If Not LConsulta.IsEmpty Then
      Begin

        edtCodNatRend.Text  := LConsulta.FieldByName('NAT_CODIGO').AsString;
        edtNatRend.Text     := LConsulta.FieldByName('NAT_DESCRI').AsString;
        edtCodTipServ.Text  := LConsulta.FieldByName('CLA_CODIGO').AsString;
        edtTipoServico.Text := LConsulta.FieldByName('CLA_DESCRI').AsString;

      End;

    Finally
      FreeAndNil(LConsulta);
    End;

  End;

End;

end.

