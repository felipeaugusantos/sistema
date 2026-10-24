unit untExcelOfc;

interface

uses Classes, Dialogs, ComObj, Variants, SysUtils, untExcel, Windows, DateUtils;

type
  TExcelOfc = Class(TExcel)
  private
    function fIsDate(strData: String): Boolean;

  protected
    procedure SalvarPosicao; Override;
    procedure VoltarPosicao; Override;

    function getLinAtu: Integer; Override;
    function getColAtu: Integer; Override;

    procedure setLinAtu(Linha: Integer); Override;
    procedure setColAtu(Coluna: Integer); Override;

    function RetornaCor(Cor: TCorExcel): Integer; Override;
    function RetornaFonte(Fonte: TFonteExcel): String; Override;
    function fRetornaAlinhamento(Alinhamhento: TAlinhamentoExcel): Integer; Override;
    function fRetornaAlinhamentoVertical(Alinhamento: TAlinhamentoVertical): Integer; Override;

  public
    constructor Create(Owner: TComponent);Override;

    function ProximaLinha: Integer; Override;

    procedure ValidarCelulas(CelulaInicial, CelulaFinal, ValorMinimo, ValorMaximo: String); Override;
    procedure BloquearCelulas(CelulaInicial, CelulaFinal: String; Bloquear: Boolean = True); Override;
    procedure ProtegerPlanilha(Senha: String); Override;
    procedure DesprotegerPlanilha(Senha: String); Override;
    procedure DesprotegerEstrutura(Senha: String); Override;
    procedure ProtegerEstrutura(Senha: String); Override;
    procedure ExcluirPlanilha(Index: Integer); Override;

    function LocalizarCelula(Texto: String): Boolean; Override;

    function MaximodeLinhas: Integer; Override;

    function Ler_Celula(Celula: String): String; Override;

    procedure Escrever(linha, coluna: Integer; Valor: Variant); Override;
    procedure FormatoNumerico(Linha, Coluna: Integer; Formato: String = '#.##0,00');overload;Override;
    procedure FormatoNumerico(CelulaInicial, CelulaFinal: String; Formato: String = '#.##0,00');overload;Override;
    procedure Mesclar(CelulaInicial, CelulaFinal: String);Override;
    procedure Negrito(Linha, Coluna: Integer; blnNegrito: Boolean);overload;Override;
    procedure Negrito(CelulaInicial, CelulaFinal: String; blnNegrito: Boolean);overload;Override;
    procedure CorFundo(CelulaInicial, CelulaFinal: String; CorFundo: TCorExcel);overload;Override;
    procedure CorFundo(CelulaInicial, CelulaFinal: String; CorFundo: Cardinal);overload;Override;
    procedure CorFonte(CelulaInicial, CelulaFinal: String; CorFonte: TCorExcel);Override;
    procedure PintarTudo(CorFundo: TCorExcel);Override;
    procedure DefinirFonte(Fonte: TFonteExcel; Tamanho: Integer);overload;Override;
    procedure DefinirFonte(CelulaInicial, CelulaFinal: String; Fonte: TFonteExcel; Tamanho: Integer);overload;Override;
    procedure Alinhamento(CelulaInicial, CelulaFinal: String; Alinhamento: TAlinhamentoExcel);overload;Override;
    procedure Alinhamento(Linha, Coluna: Integer; Alinhamento: TAlinhamentoExcel);overload;Override;
    procedure AlinhamentoVertical(CelulaInicial, CelulaFinal: String; Alinhamento: TAlinhamentoVertical);overload;Override;
    procedure AlinhamentoVertical(Linha, Coluna: Integer; Alinhamento: TAlinhamentoVertical);overload;Override;
    procedure Bordas(CelulaInicial, CelulaFinal: String);overload;Override;
    procedure Bordas(CelulaInicial, CelulaFinal: String; Esquerda, Direita, Superior, Inferior: Boolean);overload;Override;
    procedure OrientacaoPagina(Orientacao: TOrientacao);Override;
    procedure CongelarPaines(Celula: String);Override;
    procedure AutoAjuste;Override;

    function AbrirArquivo(Nome_Arquivo: String): Boolean;Override;
    function CriarArquivo: Boolean; Overload;Override;
    function CriarArquivo(Nome_Arquivo: String): Boolean; Overload;Override;

    procedure SalvarArquivo;Override;
    procedure FecharArquivo;Override;
    
    procedure SetaNomePlanilha(intPlanilha: Integer; strNome: String); Override;
    procedure AdicionaPlanilha; Override;
    procedure setSheet(const Value: Integer); Override;

    procedure EscreveVarios(CelulaInicial, CelulaFinal: String); override;
  end;

implementation

Uses
  untFuncoes;

constructor TExcelOfc.Create(Owner: TComponent);
begin
  FSvdXls := TSaveDialog.Create(Nil);
  FSvdXls.Filter := 'Planilha do Excel|*.xlsx';
  FSvdXls.DefaultExt := 'xlsx';

  WorkBookIndex := 1;
  SheetIndex    := 1;

  FAbrirArquivoExistente := False;

  blnErroArq := False;
end;

function TExcelOfc.ProximaLinha: Integer;
begin
  SalvarPosicao;
  FExcel.WorkBooks[WorkBookIndex].WorkSheets[SheetIndex].Cells[LinhaAtual + 1, ColunaAtual].Select;
  Result := LinhaAtual;
end;

function TExcelOfc.Ler_Celula(Celula: String): String;
begin
  Result := FExcel.Range[Celula].Text;
end;

procedure TExcelOfc.Escrever(linha, coluna: Integer; Valor: Variant);
begin
  If blnEscreverArray Then
  Begin
    VarArrayPut(arrDados, Valor, [coluna]);
  End
  Else
  Begin

    If fIsDate(Valor) Then
      FExcel.WorkBooks[WorkBookIndex].WorkSheets[SheetIndex].Cells[linha,coluna] := FormatDateTime('dd/mm/yyyy', VarToDateTime(Valor))
    Else
      FExcel.WorkBooks[WorkBookIndex].WorkSheets[SheetIndex].Cells[linha,coluna] := Valor;
      
  End;
end;

procedure TExcelOfc.EscreveVarios(CelulaInicial, CelulaFinal: String);
begin
  FExcel.Range[CelulaInicial, CelulaFinal].Value := arrDados;
end;

procedure TExcelOfc.Mesclar(CelulaInicial, CelulaFinal: String);
begin
  FExcel.Range[CelulaInicial,CelulaFinal].Merge;
end;

procedure TExcelOfc.Negrito(Linha, Coluna: Integer; blnNegrito: Boolean);
begin
  FExcel.WorkBooks[WorkBookIndex].WorkSheets[SheetIndex].Cells[Linha, Coluna].Font.Bold := blnNegrito;
end;

procedure TExcelOfc.Negrito(CelulaInicial, CelulaFinal: String; blnNegrito: Boolean);
begin
  FExcel.Range[CelulaInicial, CelulaFinal].Font.Bold := blnNegrito;
end;

procedure TExcelOfc.CorFundo(CelulaInicial, CelulaFinal: String; CorFundo: TCorExcel);
begin
  FExcel.Range[CelulaInicial, CelulaFinal].Interior.ColorIndex := RetornaCor(CorFundo);
end;

procedure TExcelOfc.CorFonte(CelulaInicial, CelulaFinal: String; CorFonte: TCorExcel);
begin
  FExcel.Range[CelulaInicial, CelulaFinal].Font.ColorIndex := RetornaCor(CorFonte);
end;

procedure TExcelOfc.CorFundo(CelulaInicial, CelulaFinal: String;
  CorFundo: Cardinal);
begin
  FExcel.Range[CelulaInicial, CelulaFinal].Interior.Color := CorFundo;
end;

procedure TExcelOfc.AdicionaPlanilha;
begin
  FExcel.WorkBooks[WorkBookIndex].Sheets.Add;
end;

procedure TExcelOfc.Alinhamento(Linha, Coluna: Integer; Alinhamento: TAlinhamentoExcel);
begin
  FExcel.WorkBooks[WorkBookIndex].WorkSheets[SheetIndex].Cells[linha,coluna].HorizontalAlignment := fRetornaAlinhamento(Alinhamento);
end;

procedure TExcelOfc.Alinhamento(CelulaInicial, CelulaFinal: String; Alinhamento: TAlinhamentoExcel);
begin
  FExcel.Range[CelulaInicial, CelulaFinal].HorizontalAlignment := fRetornaAlinhamento(Alinhamento);
end;

procedure TExcelOfc.AlinhamentoVertical(Linha, Coluna: Integer; Alinhamento: TAlinhamentoVertical);
begin
  FExcel.WorkBooks[WorkBookIndex].WorkSheets[SheetIndex].Cells[linha,coluna].VerticalAlignment := fRetornaAlinhamentoVertical(Alinhamento);
end;

procedure TExcelOfc.AlinhamentoVertical(CelulaInicial, CelulaFinal: String; Alinhamento: TAlinhamentoVertical);
begin
  FExcel.Range[CelulaInicial, CelulaFinal].VerticalAlignment := fRetornaAlinhamentoVertical(Alinhamento);
end;

function TExcelOfc.CriarArquivo: Boolean;
begin
  If FSvdXls.Execute Then
  Begin

  If blnTestaArq And FileExists(FSvdXls.FileName) Then
    If Not DeleteFile(pChar(FSvdXls.FileName)) Then
    Begin
      blnErroArq := True;
      Result := False;
      Exit;
    End;

    CriarArquivo(FSvdXls.FileName);
    FNomArq := FSvdXls.FileName;
    Result := True;
  End
  Else
    Result := False;
end;

function TExcelOfc.CriarArquivo(Nome_Arquivo: String): Boolean;
begin
  If Nome_Arquivo = EmptyStr Then
    Result := CriarArquivo
  Else
  Begin
    FExcel := CreateOleObject('Excel.Application');
    FExcel.Visible      := False;
    Excel.DisplayAlerts := False;

    If FAbrirArquivoExistente Then
      AbrirArquivo(Nome_Arquivo)
    Else
      FExcel.Workbooks.Add;

    FExcel.WorkBooks[WorkBookIndex].WorkSheets[SheetIndex].Cells.Select;
    FExcel.Selection.NumberFormat := '@';

    FNomArq := Nome_Arquivo;
    Result := True;
  End;
end;

function TExcelOfc.AbrirArquivo(Nome_Arquivo: String): Boolean;
begin
  Result := False;
  If FileExists(Nome_Arquivo) Then
  Begin
    FExcel := CreateOleObject('Excel.Application');
    Excel.Visible       := False;
    Excel.DisplayAlerts := False;
    Excel.WorkBooks.Open(Filename := Nome_Arquivo);

    FNomArq := Nome_Arquivo;

    Result := True;
  End;
end;

procedure TExcelOfc.OrientacaoPagina(Orientacao: TOrientacao);
begin
  Try
    Case Orientacao Of
      Retrato : FExcel.ActiveSheet.PageSetup.Orientation := 1;
      Paisagem: FExcel.ActiveSheet.PageSetup.Orientation := 2;
    End;
  Except

  End;
end;

procedure TExcelOfc.AutoAjuste;
begin
  FExcel.Columns.AutoFit;
end;

procedure TExcelOfc.CongelarPaines(Celula: String);
begin
  SalvarPosicao;
  FExcel.Range[Celula].Select;
  FExcel.ActiveWindow.FreezePanes := True;
  VoltarPosicao;
end;

procedure TExcelOfc.SalvarArquivo;
begin
  If FileExists(FNomArq) Then
    DeleteFile(PChar(FNomArq));

  FExcel.WorkBooks[WorkBookIndex].Sheets[1].Select;
  FExcel.Range['A1'].Select;
  FExcel.WorkBooks[WorkBookIndex].SaveAs(FNomArq);
  FExcel.WorkBooks[WorkBookIndex].Sheets[1].Select;
end;

procedure TExcelOfc.SalvarPosicao;
begin
  FLinAnt := LinhaAtual;
  FColAnt := ColunaAtual
end;

procedure TExcelOfc.SetaNomePlanilha(intPlanilha: Integer; strNome: String);
begin
  FExcel.WorkBooks[WorkBookIndex].Sheets[intPlanilha].Name := strNome;
end;

procedure TExcelOfc.setColAtu(Coluna: Integer);
begin
  FExcel.WorkBooks[WorkBookIndex].WorkSheets[SheetIndex].Cells[LinhaAtual, Coluna].Select;
end;

procedure TExcelOfc.setLinAtu(Linha: Integer);
begin
  FExcel.WorkBooks[WorkBookIndex].WorkSheets[SheetIndex].Cells[Linha, ColunaAtual].Select;
end;

procedure TExcelOfc.setSheet(const Value: Integer);
begin
  inherited;
  If SheetIndex > 1 Then
    FExcel.WorkBooks[WorkBookIndex].WorkSheets[SheetIndex].Select;
end;

procedure TExcelOfc.VoltarPosicao;
begin
  LinhaAtual  := FLinAnt;
  ColunaAtual := FColAnt;
end;

procedure TExcelOfc.FecharArquivo;
begin
  FExcel.Quit;
end;

procedure TExcelOfc.Bordas(CelulaInicial, CelulaFinal: String; Esquerda, Direita, Superior, Inferior: Boolean);
begin
  If Esquerda Then FExcel.Range[CelulaInicial,CelulaFinal].Borders[07].LineStyle := 1;
  If Superior Then FExcel.Range[CelulaInicial,CelulaFinal].Borders[08].LineStyle := 1;
  If Inferior Then FExcel.Range[CelulaInicial,CelulaFinal].Borders[09].LineStyle := 1;
  If Direita  Then FExcel.Range[CelulaInicial,CelulaFinal].Borders[10].LineStyle := 1;
end;

procedure TExcelOfc.Bordas(CelulaInicial, CelulaFinal: String);
begin
  FExcel.Range[CelulaInicial,CelulaFinal].Borders.LineStyle := 1;
end;

function TExcelOfc.RetornaCor(Cor: TCorExcel): Integer;
begin
  Result := 0;
  Case Cor Of
    Preto        : Result := 01;
    Branco       : Result := 02;
    Cinza        : Result := 15;
    CinzaEscuro  : Result := 16;
    Amarelo      : Result := 06;
    Verde_Mar    : Result := 50;
    Verde        : Result := 10;
    Lima         : Result := 43;
    Azul         : Result := 05;
    Vermelho     : Result := 03;
  End;
end;

function TExcelOfc.RetornaFonte(Fonte: TFonteExcel): String;
begin
  Case Fonte Of
    Arial      : FExcel.Selection.Font.Name := 'Arial';
    Courier    : FExcel.Selection.Font.Name := 'Courier';
    CourierNew : FExcel.Selection.Font.Name := 'Courier New';
    Times      : FExcel.Selection.Font.Name := 'Times New Roman';
  End;
end;

function TExcelOfc.fRetornaAlinhamento(Alinhamhento: TAlinhamentoExcel): Integer;
begin
  Result := 0;
  Case Alinhamhento Of
    Esquerda: Result := -4131;
    Direita : Result := -4152;
    Centro  : Result := -4108;
  End;
end;

function TExcelOfc.fRetornaAlinhamentoVertical(Alinhamento: TAlinhamentoVertical): Integer;
begin
  Result := 0;
  Case Alinhamento Of
    xlsTop    : Result := -4160;
    xlsBottom : Result := -4107;
    xlsCenter : Result := -4108;
  End;
end;

function TExcelOfc.getColAtu: Integer;
begin
  Result := FExcel.ActiveCell.Column;
end;

function TExcelOfc.getLinAtu: Integer;
begin
  Result := FExcel.ActiveCell.Row;
end;

procedure TExcelOfc.PintarTudo(CorFundo: TCorExcel);
begin
  SalvarPosicao;
  FExcel.Cells.Select;
  FExcel.Selection.Interior.ColorIndex := RetornaCor(CorFundo);
  VoltarPosicao;
end;

procedure TExcelOfc.DefinirFonte(Fonte: TFonteExcel; Tamanho: Integer);
begin
  SalvarPosicao;
  FExcel.Cells.Select;
  FExcel.Selection.Font.Name := RetornaFonte(Fonte);
  FExcel.Selection.Font.Size := Tamanho;
  VoltarPosicao;
end;

procedure TExcelOfc.DefinirFonte(CelulaInicial, CelulaFinal: String; Fonte: TFonteExcel; Tamanho: Integer);
begin
  SalvarPosicao;
  FExcel.Range[CelulaInicial,CelulaFinal].Select;
  FExcel.Selection.Font.Name := RetornaFonte(Fonte);
  FExcel.Selection.Font.Size := Tamanho;
  VoltarPosicao;
end;

procedure TExcelOfc.FormatoNumerico(Linha, Coluna: Integer; Formato: String = '#.##0,00');
begin
  FExcel.WorkBooks[WorkBookIndex].WorkSheets[SheetIndex].Cells[Linha,Coluna].NumberFormat := Formato;
end;

procedure TExcelOfc.FormatoNumerico(CelulaInicial, CelulaFinal: String; Formato: String = '#.##0,00');
begin
  SalvarPosicao;
  FExcel.Range[CelulaInicial,CelulaFinal].Select;
  FExcel.Selection.NumberFormat := Formato;
  VoltarPosicao;
end;

procedure TExcelOfc.BloquearCelulas(CelulaInicial, CelulaFinal: String; Bloquear: Boolean = True);
begin
  SalvarPosicao;
  FExcel.Range[CelulaInicial,CelulaFinal].Select;
  FExcel.Selection.Locked := Bloquear;
  VoltarPosicao;
end;

procedure TExcelOfc.DesprotegerPlanilha(Senha: String);
begin
  FExcel.ActiveSheet.Unprotect(Password := Senha);
end;

procedure TExcelOfc.ProtegerPlanilha(Senha: String);
begin
  FExcel.ActiveSheet.Protect(Password := Senha);
end;

procedure TExcelOfc.DesprotegerEstrutura(Senha: String);
begin
  FExcel.ActiveWorkbook.Unprotect(Password := Senha);
end;

procedure TExcelOfc.ProtegerEstrutura(Senha: String);
begin
  FExcel.ActiveWorkbook.Protect(Password := Senha);
end;

procedure TExcelOfc.ExcluirPlanilha(Index: Integer);
begin
  FExcel.Sheets[Index].Delete;
end;

function TExcelOfc.LocalizarCelula(Texto: String): Boolean;
begin
  Try
    SalvarPosicao;
    FExcel.Cells.Find(Texto).Activate;
    Result := True;
  Except
    Result := False;
  End;
end;

function TExcelOfc.MaximodeLinhas: Integer;
begin
  SalvarPosicao;
  FExcel.Selection.SpecialCells(11).Select;
  Result := FExcel.ActiveCell.Row;
  VoltarPosicao;
end;

procedure TExcelOfc.ValidarCelulas(CelulaInicial, CelulaFinal, ValorMinimo, ValorMaximo: String);
  Const
    xlValidateDecimal = 2;
    xlValidAlertStop  = 1;
    xlBetween         = 1;
  var
    MsgErro: string;
begin

  MsgErro := 'Informe um valor entre ' + ValorMinimo + ' e ' + ValorMaximo;

  FExcel.Range[CelulaInicial,CelulaFinal].Select;

  FExcel.Selection.Validation.Delete;

  FExcel.Selection.Validation.Add(Type       := xlValidateDecimal,
                                  AlertStyle := xlValidAlertStop,
                                  Operator   := xlBetween,
                                  Formula1   := ValorMinimo,
                                  Formula2   := ValorMaximo);

  FExcel.Selection.Validation.IgnoreBlank    := True;
  FExcel.Selection.Validation.InCellDropdown := True;
  FExcel.Selection.Validation.InputTitle     := '';
  FExcel.Selection.Validation.InputMessage   := MsgErro;
  FExcel.Selection.Validation.ErrorTitle     := 'Valor Inválido';
  FExcel.Selection.Validation.ErrorMessage   := MsgErro;
  FExcel.Selection.Validation.ShowInput      := True;
  FExcel.Selection.Validation.ShowError      := True;

end;

function TExcelOfc.fIsDate(strData: String): Boolean;
  Var
    dtaData: TDateTime;
    Year, Month, Day: Word;
begin
  Try
    dtaData := StrToDate(strData);
    DecodeDate(dtaData, Year, Month, Day);
    Result := IsValidDate(Year, Month, Day);
  Except
    Result := False;
  End;
end;

end.
