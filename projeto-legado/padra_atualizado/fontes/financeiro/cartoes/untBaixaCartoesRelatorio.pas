unit untBaixaCartoesRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxExportText, frxClass, frxDBSet,
  frxExportPDF, frxExportXLS, frxExportCSVTestabilidade, UniClientDataSet;

type
  TfrmBaixaCartoesRelatorio = class(TForm)
    frxPagina: TfrxReport;
    frxCSVExportTestabilidade: TfrxCSVExportTestabilidade;
    frxExportaXLS: TfrxXLSExport;
    frxExportaPDF: TfrxPDFExport;
    frxRelatorio: TfrxDBDataset;
    frxSemRed: TfrxDBDataset;
    frxListArq: TfrxDBDataset;
    frxTotBan: TfrxDBDataset;
    frxSimpleTextExport1: TfrxSimpleTextExport;
    frxDBCartoesPendenteConciliacao: TfrxDBDataset;
    frxCartoesPendenteConciliacao: TfrxReport;
    frxTotalFinal: TfrxDBDataset;
    function frxPaginaUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure FormCreate(Sender: TObject);
  private
    FNomeConciliacao: String;

    function fFiltraCancelamentos: Boolean;
    function FiltraTransferencias: Boolean;
    function fTotBan(strEstabe: String; intConcil: Integer; intTipo: Integer = 0): Boolean;

    function RetornaFiltroPrincipal: String;
    function VoltaFiltros(AFiltroAnterior: String):Boolean;

    function RetornaNomeConciliacao: String;

    function FiltraNegociacoesRecebiveis: Boolean;
    { Private declarations }
  public
    property NomeConciliacao: String read FNomeConciliacao write FNomeConciliacao;
    { Public declarations }
  end;

implementation
Uses untFuncoesSimples;
{$R *.dfm}

function TfrmBaixaCartoesRelatorio.fFiltraCancelamentos: Boolean;
begin
  Result := True;
  frxRelatorio.DataSet.Filter := 'DESCRI=' + QuotedStr('Cancelamentos/Ajustes');
  If FNomeConciliacao.ToUpper = 'KONCILI' Then
    frxRelatorio.DataSet.Filter :=   frxRelatorio.DataSet.Filter + ' OR DESCRI=' + QuotedStr('Devoluções');

  If FNomeConciliacao.ToUpper = 'MERCADOLIVRE' Then
    frxRelatorio.DataSet.Filter := frxRelatorio.DataSet.Filter + ' OR DESCRI=' + QuotedStr('Pedidos em disputa/bloqueados');
  frxRelatorio.DataSet.Filtered := True;
end;

function TfrmBaixaCartoesRelatorio.FiltraNegociacoesRecebiveis: Boolean;
begin
  frxRelatorio.DataSet.Filter := 'DESCRI=' + QuotedStr('NEGOCIAÇÃO DE RECEBÍVEIS');
  frxRelatorio.DataSet.Filtered := True;

  Result := Not frxRelatorio.DataSet.IsEmpty;
end;

function TfrmBaixaCartoesRelatorio.FiltraTransferencias: Boolean;
begin
  frxRelatorio.DataSet.Filter := 'DESCRI=''TRANSFERÊNCIAS'' ';
  frxRelatorio.DataSet.Filtered := True;

  Result := Not frxRelatorio.DataSet.IsEmpty;
end;

procedure TfrmBaixaCartoesRelatorio.FormCreate(Sender: TObject);
begin
  FNomeConciliacao := '';

  frxPagina.AddFunction('function fStrToFloat(strValorUnico: String): Double');
  frxPagina.AddFunction('function fFiltraCancelamentos: Boolean');
  frxPagina.AddFunction('function fTotBan(strEstabe: String; intConcil: Integer; intTipo: Integer = 0): Boolean');
  frxPagina.AddFunction('function FiltraTransferencias: Boolean');
  frxPagina.AddFunction('function RetornaFiltroPrincipal: String');
  frxPagina.AddFunction('function VoltaFiltros(AFiltroAnterior: String): Boolean');
  frxPagina.AddFunction('function RetornaNomeConciliacao: String');
  frxPagina.AddFunction('function FiltraNegociacoesRecebiveis: Boolean');

  TfrxMemoView(frxPagina.FindObject('rllCodigoConciliacao')).Visible := False;

  TfrxPageHeader(frxPagina.FindObject('PageHeader1')).Height := TfrxPageHeader(frxPagina.FindObject('PageHeader1')).Height -
                                                                TfrxMemoView(frxPagina.FindObject('rllCodigoConciliacao')).Height;
end;

function TfrmBaixaCartoesRelatorio.frxPaginaUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If MethodName = 'FSTRTOFLOAT' Then
    Result := fStrToFloat(Params[0]);
  If MethodName = 'FFILTRACANCELAMENTOS' Then
    Result := fFiltraCancelamentos;
  If MethodName = 'FTOTBAN' Then
    Result := fTotBan(Params[0], Params[1], Params[2]);
  If MethodName = 'FILTRATRANSFERENCIAS' Then
    Result := FiltraTransferencias;
  If MethodName = 'RETORNAFILTROPRINCIPAL' Then
    Result := RetornaFiltroPrincipal;
  If MethodName = 'VOLTAFILTROS' Then
    Result := VoltaFiltros(Params[0]);
  If MethodName = 'RETORNANOMECONCILIACAO' Then
    Result := RetornaNomeConciliacao;
  If MethodName = 'FILTRANEGOCIACOESRECEBIVEIS' Then
    Result := FiltraNegociacoesRecebiveis;
end;

function TfrmBaixaCartoesRelatorio.fTotBan(strEstabe: String; intConcil,
  intTipo: Integer): Boolean;
begin
  Result := True;
  If fEmptyStr(strEstabe) Then
  Begin
    frxTotBan.DataSet.Filter   := IIF(intConcil > 1, '', 'CONCIL=' + InttoStr(intConcil));
    frxTotBan.DataSet.Filtered := IIF(intConcil > 1, False, True);
  End
  Else
  Begin
    frxTotBan.DataSet.Filter   := 'ESTABE=' + QuotedStr(strEstabe) +
                                  IIF(intConcil > 1, '', ' AND CONCIL=' + InttoStr(intConcil));
    frxTotBan.DataSet.Filtered := True;
  End;

  If intTipo = 0 Then
    TUniClientDataSet(frxTotBan.DataSet).IndexFieldNames := 'ESTABE;CONCIL;NOMBAN'
  Else If intTipo = 1 Then
    TUniClientDataSet(frxTotBan.DataSet).IndexFieldNames := 'CONCIL;ESTABE'
  Else
    TUniClientDataSet(frxTotBan.DataSet).IndexFieldNames := 'CONCIL;NOMBAN';
end;

function TfrmBaixaCartoesRelatorio.RetornaNomeConciliacao: String;
begin
  Result := FNomeConciliacao.ToUpperInvariant;
end;

function TfrmBaixaCartoesRelatorio.RetornaFiltroPrincipal: String;
begin
  Result := frxRelatorio.DataSet.Filter;
end;

function TfrmBaixaCartoesRelatorio.VoltaFiltros(AFiltroAnterior: String): Boolean;
begin
  frxRelatorio.DataSet.Filter := AFiltroAnterior;
  frxRelatorio.DataSet.Filtered := True;

  Result := True;
end;

end.
