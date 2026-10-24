unit untLibDominioSistemasExportarArquivo;

{
  Exporta o conteúdo de um TcxGridCitel para arquivo .xls (HTML) ou .csv.

  Estratégia:
    1. Tenta gravar um HTML com extensão .xls.
       Excel e LibreOffice reconhecem e abrem como planilha.
    2. Se falhar, grava um CSV puro como fallback.

  Uso:
    TLibDominioSistemasExportarArquivo.fExportarGridParaArquivo(GridCitel);
}

interface

uses
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,
  Data.DB,
  Vcl.Dialogs,
  cxGridCustomTableView,
  cxGridDBTableView,
  cxGridCitel;

type
  TLibDominioSistemasExportarArquivo = class
  private
    { Retorna lista tipada das TcxGridDBColumn visíveis. Caller é dono da lista. }
    class function fColetarColunasVisiveis(AView: TcxGridDBTableViewCitel):
                     TList<TcxGridDBColumn>;

    { Escapa os cinco caracteres reservados do HTML: & < > " ' }
    class function fEscaparHTML(const AstrTexto: String): String;

    { Escapa um valor para CSV conforme RFC 4180. }
    class function fEscaparCSV(const AstrTexto, AstrSep: String): String;

    { Exibe SaveDialog e devolve o caminho escolhido. False se cancelado. }
    class function fSolicitarNomeArquivo(out AstrNomeArquivo: String): Boolean;

    { Gera arquivo HTML com extensão .xls. False se falhou. }
    class function fGerarArquivoHTML(AListaColunas: TList<TcxGridDBColumn>;
                                     ADataSet: TDataSet;
                                     const AstrNomeArquivo: String): Boolean;

    { Gera arquivo CSV separado por ponto-e-vírgula. False se falhou. }
    class function fGerarArquivoCSV(AListaColunas: TList<TcxGridDBColumn>;
                                    ADataSet: TDataSet;
                                    const AstrNomeArquivo: String): Boolean;

    { Retorna True se o arquivo existe e tem tamanho maior que zero. }
    class function fArquivoValido(const AstrNomeArquivo: String): Boolean;
  public
    { Ponto de entrada: valida a grid, solicita destino e gera o arquivo. }
    class function fExportarGridParaArquivo(AGridCitel: TcxGridCitel): Boolean;
  end;

implementation

const
  CstrEstiloHTML =
    'table { border-collapse: collapse; font-family: Arial; font-size: 11pt; }' + sLineBreak +
    'th, td { border: 1px solid #000; padding: 4px 8px; }'                     + sLineBreak +
    'th { background-color: #E0E0E0; font-weight: bold; text-align: center; }';

{ TLibDominioSistemasExportarArquivo }

// ---------------------------------------------------------------------------
// Helpers privados
// ---------------------------------------------------------------------------

class function TLibDominioSistemasExportarArquivo.fArquivoValido(
  const AstrNomeArquivo: String): Boolean;
var
  LSearchRec: TSearchRec;
begin
  Result := False;

  if FindFirst(AstrNomeArquivo, faAnyFile, LSearchRec) = 0 then
  begin
    try
      Result := LSearchRec.Size > 0;
    finally
      FindClose(LSearchRec);
    end;
  end;
end;

class function TLibDominioSistemasExportarArquivo.fColetarColunasVisiveis(
  AView: TcxGridDBTableViewCitel): TList<TcxGridDBColumn>;
var
  i: Integer;
begin
  Result := TList<TcxGridDBColumn>.Create;
  try
    for i := 0 to AView.ColumnCount - 1 do
      if (AView.Columns[i] is TcxGridDBColumn) and AView.Columns[i].Visible then
        Result.Add(TcxGridDBColumn(AView.Columns[i]));
  except
    FreeAndNil(Result);
    raise;
  end;
end;

class function TLibDominioSistemasExportarArquivo.fEscaparHTML(
  const AstrTexto: String): String;
begin
  Result := AstrTexto;
  Result := StringReplace(Result, '&',  '&amp;',  [rfReplaceAll]);
  Result := StringReplace(Result, '<',  '&lt;',   [rfReplaceAll]);
  Result := StringReplace(Result, '>',  '&gt;',   [rfReplaceAll]);
  Result := StringReplace(Result, '"',  '&quot;', [rfReplaceAll]);
  Result := StringReplace(Result, '''', '&#39;',  [rfReplaceAll]);
end;

class function TLibDominioSistemasExportarArquivo.fSolicitarNomeArquivo(
  out AstrNomeArquivo: String): Boolean;
var
  LDlgSalvar: TSaveDialog;
begin
  Result     := False;
  LDlgSalvar := TSaveDialog.Create(nil);
  try
    LDlgSalvar.Filter     := 'Arquivo Excel (*.xls)|*.xls';
    LDlgSalvar.DefaultExt := 'xls';

    if not LDlgSalvar.Execute then
      Exit;

    AstrNomeArquivo := ChangeFileExt(LDlgSalvar.FileName, '.xls');
    Result := True;
  finally
    FreeAndNil(LDlgSalvar);
  end;
end;

class function TLibDominioSistemasExportarArquivo.fGerarArquivoHTML(
  AListaColunas: TList<TcxGridDBColumn>; ADataSet: TDataSet;
  const AstrNomeArquivo: String): Boolean;
var
  LArquivo: TStringList;
  LstrLinha: String;
  LstrValor: String;
  i: Integer;
begin
  Result   := False;
  LArquivo := TStringList.Create;
  try
    LArquivo.Add('<!DOCTYPE html>');
    LArquivo.Add('<html><head><meta charset="UTF-8">');
    LArquivo.Add('<style>');
    LArquivo.Add(CstrEstiloHTML);
    LArquivo.Add('</style></head><body>');
    LArquivo.Add('<table>');

    // Linha de cabeçalho
    LstrLinha := '<tr>';
    for i := 0 to AListaColunas.Count - 1 do
      LstrLinha := LstrLinha + '<th>' + fEscaparHTML(AListaColunas[i].Caption) + '</th>';
    LArquivo.Add(LstrLinha + '</tr>');

    // Linhas de dados
    ADataSet.DisableControls;
    try
      ADataSet.First;
      while not ADataSet.Eof do
      begin
        LstrLinha := '<tr>';
        for i := 0 to AListaColunas.Count - 1 do
        begin
          LstrValor := ADataSet.FieldByName(
            AListaColunas[i].DataBinding.FieldName).DisplayText;
          LstrLinha := LstrLinha + '<td>' + fEscaparHTML(LstrValor) + '</td>';
        end;
        LArquivo.Add(LstrLinha + '</tr>');
        ADataSet.Next;
      end;
    finally
      ADataSet.EnableControls;
    end;

    LArquivo.Add('</table></body></html>');
    LArquivo.SaveToFile(AstrNomeArquivo, TEncoding.UTF8);

    Result := fArquivoValido(AstrNomeArquivo);
  finally
    FreeAndNil(LArquivo);
  end;
end;

class function TLibDominioSistemasExportarArquivo.fGerarArquivoCSV(
  AListaColunas: TList<TcxGridDBColumn>; ADataSet: TDataSet;
  const AstrNomeArquivo: String): Boolean;
const
  CstrSeparador = ';';
var
  LArquivo: TStringList;
  LstrLinha: String;
  LstrValor: String;
  i: Integer;
begin
  Result   := False;
  LArquivo := TStringList.Create;
  try
    // Cabeçalho
    LstrLinha := EmptyStr;
    for i := 0 to AListaColunas.Count - 1 do
    begin
      if i > 0 then
        LstrLinha := LstrLinha + CstrSeparador;

      LstrLinha := LstrLinha + fEscaparCSV(AListaColunas[i].Caption, CstrSeparador);
    end;

    LArquivo.Add(LstrLinha);

    // Dados
    ADataSet.DisableControls;
    try
      ADataSet.First;
      while not ADataSet.Eof do
      begin
        LstrLinha := EmptyStr;
        for i := 0 to AListaColunas.Count - 1 do
        begin
          if i > 0 then
            LstrLinha := LstrLinha + CstrSeparador;

          LstrValor := ADataSet.FieldByName(
            AListaColunas[i].DataBinding.FieldName).DisplayText;

          LstrLinha := LstrLinha + fEscaparCSV(LstrValor, CstrSeparador);
        end;
        LArquivo.Add(LstrLinha);
        ADataSet.Next;
      end;
    finally
      ADataSet.EnableControls;
    end;

    LArquivo.SaveToFile(AstrNomeArquivo, TEncoding.UTF8);

    Result := fArquivoValido(AstrNomeArquivo);
  finally
    FreeAndNil(LArquivo);
  end;
end;

class function TLibDominioSistemasExportarArquivo.fEscaparCSV(
  const AstrTexto: String; const AstrSep: String): String;
begin
  Result := AstrTexto;
  if (Pos(AstrSep, Result) > 0) or (Pos('"', Result) > 0)
     or (Pos(#13, Result) > 0) or (Pos(#10, Result) > 0) then
    Result := '"' + StringReplace(Result, '"', '""', [rfReplaceAll]) + '"';
end;

// ---------------------------------------------------------------------------
// Ponto de entrada público
// ---------------------------------------------------------------------------

class function TLibDominioSistemasExportarArquivo.fExportarGridParaArquivo(
  AGridCitel: TcxGridCitel): Boolean;
var
  LView: TcxGridDBTableViewCitel;
  LDataSet: TDataSet;
  LListaColunas: TList<TcxGridDBColumn>;
  LstrNomeArquivo: String;
begin
  Result := False;

  if not Assigned(AGridCitel) then
    raise Exception.Create('AGridCitel não pode ser nil.');

  if not (AGridCitel.ActiveView is TcxGridDBTableViewCitel) then
    raise Exception.Create('A view ativa não é uma TcxGridDBTableViewCitel.');

  LView := TcxGridDBTableViewCitel(AGridCitel.ActiveView);

  if LView.DataController.RecordCount = 0 then
  begin
    MessageDlg('A grid está vazia. Nada para exportar.', mtInformation, [mbOK], 0);
    Exit;
  end;

  // Finaliza edição pendente e expande grupos colapsados
  if LView.DataController.EditState <> [] then
    LView.DataController.Post;

  LDataSet := LView.DataController.DataSource.DataSet;
  if not Assigned(LDataSet) then
  begin
    MessageDlg('Nenhum DataSet vinculado à grid.', mtInformation, [mbOK], 0);
    Exit;
  end;

  LListaColunas := fColetarColunasVisiveis(LView);
  try
    if LListaColunas.Count = 0 then
    begin
      MessageDlg('Nenhuma coluna visível para exportar.', mtInformation, [mbOK], 0);
      Exit;
    end;

    // Solicita destino após todas as validações — não exibe o dialog à toa
    if not fSolicitarNomeArquivo(LstrNomeArquivo) then
      Exit;

    // Tenta HTML com extensão .xls
    Result := fGerarArquivoHTML(LListaColunas, LDataSet, LstrNomeArquivo);

    // Fallback: se HTML falhou, grava CSV trocando a extensão
    if not Result then
    begin
      LstrNomeArquivo := ChangeFileExt(LstrNomeArquivo, '.csv');
      Result := fGerarArquivoCSV(LListaColunas, LDataSet, LstrNomeArquivo);
    end;

    if Result then
    begin
      MessageDlg('Arquivo gerado: ' + LstrNomeArquivo, mtInformation, [mbOK], 0);
      Exit;
    end;

    MessageDlg('Falha ao gerar o arquivo.', mtError, [mbOK], 0);
  finally
    FreeAndNil(LListaColunas);
  end;
end;

end.
