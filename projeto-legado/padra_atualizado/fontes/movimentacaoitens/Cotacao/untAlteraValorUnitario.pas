unit untAlteraValorUnitario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untFuncoesSimples, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, untCotacaoTypesAndConst;

type
  TfrmAlteraValorUnitario = class(TfrmPaiConfirma)
    pnlFornecedor: TPanel;
    pnlPrecos: TPanel;
    dbeQtdIte: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    dbeValUni: TDBEditFocus;
    Label3: TLabel;
    dbeIPIENT: TDBEditFocus;
    Label4: TLabel;
    dbeSubsti: TDBEditFocus;
    Label5: TLabel;
    dbeValTot: TDBEditFocus;
    dtsItens: TDataSource;
    lblFornecedor: TLabel;
    Label6: TLabel;
    dbeUniTot: TDBEditFocus;
    Label7: TLabel;
    dbeFreEnt: TDBEditFocus;
    pnlReforma: TPanel;
    lblAlqCbs: TLabel;
    lblAlqIbs: TLabel;
    lblAlq_Is: TLabel;
    dbeAlqCbs: TDBEditFocus;
    dbeAlqIbs: TDBEditFocus;
    dbeAlq_Is: TDBEditFocus;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    FCalculaPrecoImp:   TCalculaPrecoImp;
    FCalculaReformaImp: TCalculaReformaImp;
    FblnSomaReforma:    Boolean;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses
  untImpostosReformaCompra;

{$R *.dfm}

procedure TfrmAlteraValorUnitario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (ModalResult = mrOk) And (Not fVerificaCampos) Then
    Action := caNone;
end;

procedure TfrmAlteraValorUnitario.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(dbeValUni);
end;

function TfrmAlteraValorUnitario.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeValUni) Then
    Begin

      If fEmptyStr(dbeValUni.Text) Then
        dbeValUni.Field.Value := 0;

      If fStrToFloat(dbeValUni.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor unitário deve ser maior ou igual a zero!', ['&O k']);
        Result := False;
      End

    End

    Else If (Sender = dbeIpiEnt) Then
    Begin

      If fEmptyStr(dbeIpiEnt.Text) Then
        dbeIpiEnt.Field.Value := 0;

      If fStrToFloat(dbeIpiEnt.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de IPI deve ser maior ou igual a zero!', ['&O k']);
        Result := False;
      End

    End

    Else If (Sender = dbeSubsti) Then
    Begin

      If fEmptyStr(dbeSubsti.Text) Then
        dbeSubsti.Field.Value := 0;

      If fStrToFloat(dbeSubsti.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de Substituição deve ser maior ou igual a zero!', ['&O k']);
        Result := False;
      End

    End

    Else If (Sender = dbeAlqCbs) Or (Sender = dbeAlqIbs) Or (Sender = dbeAlq_Is) Then
    Begin

      If fEmptyStr(TDBEditFocus(Sender).Text) Then
        TDBEditFocus(Sender).Field.Value := 0;

      If Not TAliquotasReforma.fAliquotaValida(fStrToFloat(TDBEditFocus(Sender).Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A alíquota de CBS, IBS e IS deve estar entre 0 e 100!', ['&O k']);
        Result := False;
      End

    End;

    If Result Then
    Begin
      If Assigned(FCalculaPrecoImp) Then
        dbeUniTot.Field.Value := FCalculaPrecoImp(fStrToFloat(dbeValUni.Text),
                                                  fStrToFloat(dbeIpiEnt.Text),
                                                  fStrToFloat(dbeSubsti.Text),
                                                  fStrToFloat(dbeFreEnt.Text))
      Else
        dbeUniTot.Field.Value := fStrToFloat(dbeValUni.Text) *
           (1 + ((fStrToFloat(dbeIpiEnt.Text) +
                  fStrToFloat(dbeSubsti.Text) +
                  fStrToFloat(dbeFreEnt.Text))/100));

      dbeValTot.Field.Value := fStrToFloat(dbeQtdIte.Text) *  fStrToFloat(dbeUniTot.Field.Text);

      // CBS/IBS/IS somam no valor total, nao no unitario com impostos
      If FblnSomaReforma And Assigned(FCalculaReformaImp) Then
        dbeValTot.Field.Value := dbeValTot.Field.AsFloat +
                                 fStrToFloat(dbeQtdIte.Text) *
                                 FCalculaReformaImp(fStrToFloat(dbeValUni.Text),
                                                    fStrToFloat(dbeIpiEnt.Text),
                                                    fStrToFloat(dbeSubsti.Text),
                                                    fStrToFloat(dbeFreEnt.Text),
                                                    TAliquotasReforma.fCriar(fStrToFloat(dbeAlqCbs.Text),
                                                                             fStrToFloat(dbeAlqIbs.Text),
                                                                             fStrToFloat(dbeAlq_Is.Text))).fTotal;
    End;

  End;

  If (Not Result) Then
  Begin
    pSetFocus(Sender);
  End;

end;

end.
