unit untDadosFechamentoVendaTotaisFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, EditFocus,
  Vcl.ExtCtrls;

type
  TfraDadosFechamentoVendaTotaisFrame = class(TFrame)
    pnlDados: TPanel;
    lblBaseICMS: TLabel;
    lblBasIpi: TLabel;
    lblBaseST: TLabel;
    lblVlrICMS: TLabel;
    lblValIpi: TLabel;
    lblVlrST: TLabel;
    lblBasIss: TLabel;
    lblValIss: TLabel;
    lblAlqIcm: TLabel;
    lblCodSit: TLabel;
    lblBaseFCPST: TLabel;
    lblVlrFCPST: TLabel;
    lblAlqFCPST: TLabel;
    lblPerFCP: TLabel;
    lblVlrFCP: TLabel;
    edtBasIcm: TEditFocus;
    edtBasIpi: TEditFocus;
    edtBasRet: TEditFocus;
    edtValIcm: TEditFocus;
    edtValIpi: TEditFocus;
    edtValRet: TEditFocus;
    edtBasIss: TEditFocus;
    edtValIss: TEditFocus;
    edtAlqIcm: TEditFocus;
    edtCodSit: TEditFocus;
    edtBasFCPST: TEditFocus;
    edtValFCPST: TEditFocus;
    edtAlqFCPST: TEditFocus;
    edtPerFCP: TEditFocus;
    edtVlrFCP: TEditFocus;
    pnlPisCofinsDif: TPanel;
    lblCstIpi: TLabel;
    lblCstPis: TLabel;
    lblCstCof: TLabel;
    lblPerDif: TLabel;
    lblValDif: TLabel;
    edtCstIpi: TEditFocus;
    edtCstPis: TEditFocus;
    edtCstCof: TEditFocus;
    edtPerDif: TEditFocus;
    edtValDif: TEditFocus;
    pnlImpostosReforma: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtBaseCBS: TEditFocus;
    edtValorCBS: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    edtBaseIBS: TEditFocus;
    edtValorIBS: TEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    edtBaseIS: TEditFocus;
    edtValorIS: TEditFocus;
  private
    { Private declarations }
    function fTemControleVisivel(const pnlPainel: TPanel): Boolean;
  public
    { Public declarations }
    function fAjustarVisibilidade(const blnExibirImpostosReforma: Boolean): Integer;
  end;

implementation

{$R *.dfm}

function TfraDadosFechamentoVendaTotaisFrame.fTemControleVisivel(const pnlPainel: TPanel): Boolean;
  Var
    intControle: Integer;
begin
  Result := False;

  For intControle := 0 To pnlPainel.ControlCount - 1 Do
    If pnlPainel.Controls[intControle].Visible Then
    Begin
      Result := True;
      Break;
    End;
end;

function TfraDadosFechamentoVendaTotaisFrame.fAjustarVisibilidade(const blnExibirImpostosReforma: Boolean): Integer;
  Var
    intVariacao: Integer;

  procedure pAplicarVisibilidade(const pnlPainel: TPanel; const blnVisivel: Boolean);
  begin
    If (pnlPainel.Visible = blnVisivel) Then
      Exit;

    pnlPainel.Visible := blnVisivel;

    If blnVisivel Then
      intVariacao := intVariacao + pnlPainel.Height
    Else
      intVariacao := intVariacao - pnlPainel.Height;
  end;

begin
  If (pnlDados.Align <> alClient) Then
    pnlDados.Align := alClient;

  intVariacao := 0;

  pAplicarVisibilidade(pnlImpostosReforma, blnExibirImpostosReforma);
  pAplicarVisibilidade(pnlPisCofinsDif, fTemControleVisivel(pnlPisCofinsDif));

  Result := intVariacao;
end;

end.
