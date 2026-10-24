unit untBloqueioProdutos;

interface

uses
  Windows, Classes, Controls, Forms, cxProgressBar, StdCtrls, Uni, ExtCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit;

type
  TfrmBloqueioProdutos = class(TForm)
    Panel1: TPanel;
    Shape1: TShape;
    lblInformacao: TLabel;
    pgbProgresso: TcxProgressBar;
    tmrClose: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tmrCloseTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

    qryProdutos  : TUniQuery;
    intPrimeira  : Integer;
    blnFecharForm: Boolean;

    procedure pBloqueiaProdutosNaoVendem;

  public
    { Public declarations }
  end;


implementation

uses SysUtils, untFuncoesSimples;

{$R *.dfm}

procedure TfrmBloqueioProdutos.FormCreate(Sender: TObject);
begin
  intPrimeira := -1;
  blnFecharForm := False;
end;

procedure TfrmBloqueioProdutos.FormActivate(Sender: TObject);
begin
  If InterlockedIncrement(intPrimeira) = 0 Then
  Begin

    Try
      qryProdutos := fCriaQuery(Self);

      With qryProdutos, SQL Do
      Begin
        Close;
        Clear;
        Add('SELECT SQL_NO_CACHE');
        Add('  ITE_CODITE,');
        Add('  ITE_MESGIR');
        Add('FROM');
        Add('  CADITE');
        Add('WHERE');
        Add('  IFNULL(ITE_ATICOM, "N") <> "N" AND');
        Add('  IFNULL(ITE_ITEATI, "N") <> "N" AND');
        Add('  ITE_MESGIR > 0');
        Open;

        pgbProgresso.Properties.Max := RecordCount;

        While Not Eof Do
        Begin
          Application.ProcessMessages;
          pgbProgresso.Position := RecNo;
          pBloqueiaProdutosNaoVendem;
          Next;
        End;

      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,  '[TfrmBloqueioProdutos.FormActivate]');
      End;
    End;

    FreeAndNil(qryProdutos);
    blnFecharForm := True;

  End;
end;

procedure TfrmBloqueioProdutos.pBloqueiaProdutosNaoVendem;
  var
    dtaUltVen: TDateTime;
begin

  With qryProdutos Do
  Begin
    {*********************************************}
    {* RETORNA A DATA DA ULTIMA VENDA DO PRODUTO *}
    {******************************************JC*}
    dtaUltVen := fDataUltimaVendaProduto(FieldByName('ITE_CODITE').AsString);

    {**********************************************}
    {* SE A O PRODUTO JA FOI VENDIDO ALGUMA VEZ E *}
    {* JA FAÇA MAIS DE XX MESES QUE NAO VENDE     *}
    {* ENTAO INATIVA O PRODUTO PARA COMPRAS       *}
    {*******************************************JC*}
    if (dtaUltVen > 0) And
       ((VS_Date - dtaUltVen) >= (FieldByName('ITE_MESGIR').AsInteger * 30)) Then
    Begin
      fExecutaSQL(' UPDATE ' +
                  '   CADITE ' +
                  ' SET ' +
                  '   ITE_ATICOM = "N" ' +
                  ' WHERE ' +
                  '   ITE_CODITE = ' + QuotedStr(FieldByName('ITE_CODITE').AsString));
    End;

  End;

end;

procedure TfrmBloqueioProdutos.tmrCloseTimer(Sender: TObject);
begin
  inherited;
  If blnFecharForm Then
    Close;
end;

procedure TfrmBloqueioProdutos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If Not blnFecharForm Then
    Action := caNone;
end;

end.
