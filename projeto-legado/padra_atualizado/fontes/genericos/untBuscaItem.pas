unit untBuscaItem;

interface

uses
  Windows, Controls, Forms, untPaiSimples, StdCtrls, EditFocus, ComCtrls, ExtCtrls,
  AppEvnts, Menus, Buttons, BitBtnLockedIncrem, Classes, frxClass,
  frxExportCSVTestabilidade;

type
  TTipoBusca = (busCodIte, busCodFab, busProAca);

  TfrmBuscaItem = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    Label2: TLabel;
    rllItem: TLabel;
    Label3: TLabel;
    edtDesIte: TEditFocus;
    edtCodIte: TEditFocus;
    edtRefere: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    blnConfirma: Boolean;
    intCodIte: Integer;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
    strValorFiltro: String;
    strCampoFiltro: String;

    busTipBus : TTipoBusca;

  end;


implementation

uses untFuncoesSimples;

{$R *.dfm}

function TfrmBuscaItem.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtRefere) Then
    Begin
      {*****************************************}
      {* VALIDA O NOSSO NUMERO                 *}
      {**************************************JB*}
      If Not fEmptyStr(edtCodIte.Text) Then
      Begin

        Case busTipBus Of
          busCodIte: Begin
                       strCampoFiltro := 'ENT_CODITE';
                       strValorFiltro :=  fPadL(edtCodIte.Text, intCodIte, '0');
                     End;
          busCodFab: Begin
                       strCampoFiltro := 'ENT_CODFAB';
                       strValorFiltro :=  edtCodIte.Text;
                     End;
          busProAca: Begin
                       strCampoFiltro := 'ENT_CODACA';
                       strValorFiltro :=  fPadL(edtCodIte.Text, intCodIte, '0');
                     End;
        End;



      End

      Else If Not fEmptyStr(edtDesIte.Text) Then
      Begin
        strCampoFiltro := 'ENT_DESITE';
        strValorFiltro := edtDesIte.Text;
      End

      Else If Not fEmptyStr(edtRefere.Text) Then
      Begin
        strCampoFiltro := 'ENT_REFERE';
        strValorFiltro := edtRefere.Text;

      End

      Else
      Begin
        strValorFiltro := '';
        strCampoFiltro := '';

      End;

      blnConfirma := True;
      Close;

    End;

  End;

end;

procedure TfrmBuscaItem.FormCreate(Sender: TObject);
begin
  inherited;

  blnConfirma := False;

  busTipBus := busCodIte;

  intCodIte := fTamCodIte;
  pSetaCodIte(edtCodIte);
end;

procedure TfrmBuscaItem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If Not blnConfirma Then
  Begin
    strValorFiltro := '';
    strCampoFiltro := '';
  End;

end;

procedure TfrmBuscaItem.FormShow(Sender: TObject);
begin
  inherited;

  Case busTipBus Of
    busCodIte: Begin
                 rllItem.Caption := 'Código do Item';
                 edtCodIte.MaxLength := intCodIte;
               End;
    busCodFab: Begin
                 rllItem.Caption := 'Códido Fábrica';
                 edtCodIte.MaxLength := 25;
               End;
    busProAca: Begin
                 rllItem.Caption := 'Produto Acabado';
                 edtCodIte.MaxLength := intCodIte;
               End;
  End;

  pSetFocus(edtCodIte);

end;

end.

