unit untSelItensCodBar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, untFuncoesSimples, Uni;

type
  TfrmSelItensCodBar = class(TfrmPaiConfirma)
    pnlFundo: TPanel;
    lblCodBar: TLabel;
    edtCodBar: TEditFocus;
    lblQntd: TLabel;
    edtQntd: TEditFocus;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Function fVericaCodigoBarras: Boolean;
  public
    { Public declarations }
    strCodBar,
    strCodIte: String;
    intEtiQtd: Integer;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

implementation

{$R *.dfm}

procedure TfrmSelItensCodBar.FormCreate(Sender: TObject);
begin
  inherited;
  strCodBar := '';
  strCodIte := '';
  intEtiQtd := 0;

  If fCfgSis('TIPBAR', varString) = '2' Then
   edtCodbar.MaxLength := 43;
end;

function TfrmSelItensCodBar.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodBar) Then
  Begin
    If fEmptyStr(edtCodBar.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo de Código de barras precisa ser preenchido!',['&OK']);
      Result := False;
    End
    Else If Not fVericaCodigoBarras Then
      Result := False;
  End

  Else If (Sender = edtQntd) Then
  Begin
    If fEmptyStr(edtQntd.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo de Quantidade precisa ser preenchido!',['&OK']);
      Result := False;
    End
    Else If (StrToIntDef(edtQntd.Text, 0) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Quantidade precisa ser igual ou maior que zero!',['&OK']);
      Result := False;
    End
    Else
      intEtiQtd := StrToIntDef(edtQntd.Text, 0);
  End;

  If Not (Result) Then
    pSetFocus(Sender);
end;

function TfrmSelItensCodBar.fVericaCodigoBarras: Boolean;
Var
  qryCodBar: TUniQuery;
begin
  inherited;
  Result := False;
  strCodBar := '';

  Try
    qryCodBar := fCriaQuery(Nil);

    qryCodBar.SQL.Clear;
    qryCodBar.SQL.Add(' SELECT BAR_CODBAR, BAR_CODITE FROM ITEBAR ');
    qryCodBar.SQL.Add(' WHERE BAR_CODBAR = :CODBAR ');
    qryCodBar.ParamByName('CODBAR').AsString := edtCodBar.Text;
    qryCodBar.Open;

    If qryCodBar.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO!', 'Código de barras não encontrado!', ['&O k']);
      pSetFocus(edtCodBar);
      Exit;
    End
    Else
    Begin
      strCodBar := edtCodBar.Text;
      strCodIte := qryCodBar.FieldByName('BAR_CODITE').AsString;
      Result := True;
    End;

  Finally
    pFreeAndNil(qryCodBar);
  End;
end;

end.
