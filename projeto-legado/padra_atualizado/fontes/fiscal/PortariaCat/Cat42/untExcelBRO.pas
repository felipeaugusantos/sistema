{****************************************}
{* CLASSE DE CALC(EXCEL) PARA BR-OFFICE *}
{*06/02/2012**************************AF*}
unit untExcelBRO;

interface

uses Classes, Dialogs, ComObj, Variants, Graphics, untExcel, Math,
  Windows, Messages, TLHelp32;

type
  TExcelBRO = Class(TExcel)
  private
    BrOffice : Variant;
    Desktop  : Variant;
    Documento: Variant;
    FPlanilha: Variant;

    FLinAtu: Integer;
    FColAtu: Integer;

    function  fFormataDir(strArquivo: String): String;
    function  fAtribuiProperty(Nome: String; Valor : Variant): Variant;
    function  fAtribuirBordas(strBordCmd: String): Variant;
    procedure fExecuta(strComando: String; varParams: Variant);
    procedure fToPoint(Celula: String);
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

    procedure setSheet(const Value: Integer); override;
  public
    constructor Create(Owner: TComponent); Override;

    function ProximaLinha: Integer; override;

    procedure ValidarCelulas(CelulaInicial, CelulaFinal, ValorMinimo, ValorMaximo: String); override;
    procedure BloquearCelulas(CelulaInicial, CelulaFinal: String; Bloquear: Boolean = True); override;
    procedure ProtegerPlanilha(Senha: String); override;
    procedure DesprotegerPlanilha(Senha: String); override;
    procedure DesprotegerEstrutura(Senha: String); override;
    procedure ProtegerEstrutura(Senha: String); override;
    procedure ExcluirPlanilha(Index: Integer); override;

    function LocalizarCelula(Texto: String): Boolean; override;

    function MaximodeLinhas: Integer; override;

    function Ler_Celula(Celula: String): String; override;

    procedure Escrever(linha, coluna: Integer; Valor: Variant); override;
    procedure FormatoNumerico(Linha, Coluna: Integer; Formato: String = '#.##0,00');overload; override;
    procedure FormatoNumerico(CelulaInicial, CelulaFinal: String; Formato: String = '#.##0,00');overload;override;
    procedure Mesclar(CelulaInicial, CelulaFinal: String);override;
    procedure Negrito(Linha, Coluna: Integer; blnNegrito: Boolean);overload;override;
    procedure Negrito(CelulaInicial, CelulaFinal: String; blnNegrito: Boolean);overload;override;
    procedure CorFundo(CelulaInicial, CelulaFinal: String; CorFundo: TCorExcel);overload;override;
    procedure CorFundo(CelulaInicial, CelulaFinal: String; CorFundo: Cardinal);overload;override;
    procedure CorFonte(CelulaInicial, CelulaFinal: String; CorFonte: TCorExcel);override;
    procedure PintarTudo(CorFundo: TCorExcel);override;
    procedure DefinirFonte(Fonte: TFonteExcel; Tamanho: Integer);overload;override;
    procedure DefinirFonte(CelulaInicial, CelulaFinal: String; Fonte: TFonteExcel; Tamanho: Integer);overload;override;
    procedure Alinhamento(CelulaInicial, CelulaFinal: String; Alinhamento: TAlinhamentoExcel);overload;override;
    procedure Alinhamento(Linha, Coluna: Integer; Alinhamento: TAlinhamentoExcel);overload;override;
    procedure Bordas(CelulaInicial, CelulaFinal: String);overload;override;
    procedure Bordas(CelulaInicial, CelulaFinal: String; Esquerda, Direita, Superior, Inferior: Boolean);overload;override;
    procedure OrientacaoPagina(Orientacao: TOrientacao);override;
    procedure CongelarPaines(Celula: String);override;
    procedure AutoAjuste;override;

    function AbrirArquivo(Nome_Arquivo: String): Boolean;override;
    function CriarArquivo: Boolean; Overload;override;
    function CriarArquivo(Nome_Arquivo: String): Boolean; Overload;override;

    procedure SalvarArquivo;override;
    procedure FecharArquivo;override;
    
    procedure SetaNomePlanilha(intPlanilha: Integer; strNome: String); Override;
    procedure AdicionaPlanilha; Override;

    procedure AlinhamentoVertical(CelulaInicial, CelulaFinal: String; Alinhamento: TAlinhamentoVertical);override;
    procedure AlinhamentoVertical(Linha, Coluna: Integer; Alinhamento: TAlinhamentoVertical);override;

    procedure EscreveVarios(CelulaInicial, CelulaFinal: String); Override;
  end;

implementation

uses DateUtils, SysUtils;

constructor TExcelBRO.Create(Owner: TComponent);
begin
  FSvdXls := TSaveDialog.Create(Nil);
  FSvdXls.Filter := 'Planilha do Excel|*.xls|Planilha ODF|*.ods';
  FSvdXls.DefaultExt := 'xlsx';

  WorkBookIndex := 0;
  SheetIndex    := 0;

  FAbrirArquivoExistente := False;

  blnErroArq := False;
end;

function TExcelBRO.ProximaLinha: Integer;
begin
  SalvarPosicao;
  LinhaAtual := LinhaAtual + 1;
  Result := LinhaAtual;
end;

function TExcelBRO.Ler_Celula(Celula: String): String;
begin
  Result := FPlanilha.getCellRangeByName(Celula).getFormula;
end;

procedure TExcelBRO.Escrever(linha, coluna: Integer; Valor: Variant);
begin
  Try
    If fIsDate(Valor) Then
      FPlanilha.getCellByPosition(coluna-1, linha-1).setString(Valor)
    Else
      FPlanilha.getCellByPosition(coluna-1, linha-1).setFormula(Valor);
  Except
    FPlanilha.getCellByPosition(coluna-1, linha-1).setFormula(Valor);
  End;
end;

procedure TExcelBRO.EscreveVarios(CelulaInicial, CelulaFinal: String);
begin
  //
end;

procedure TExcelBRO.Mesclar(CelulaInicial, CelulaFinal: String);
begin
  fToPoint(CelulaInicial + ':' + CelulaFinal);
  fExecuta('.uno:ToggleMergeCells', Unassigned);
end;

procedure TExcelBRO.Negrito(Linha, Coluna: Integer; blnNegrito: Boolean);
  Var
    parametro: Variant;
begin
  fToPoint(fGetLetraAlfa(Coluna) + IntToStr(Linha));

  parametro    := VarArrayCreate([0, 0], varVariant);
  parametro[0] := fAtribuiProperty('Bold', blnNegrito);
  fExecuta('.uno:Bold', parametro);
end;

procedure TExcelBRO.Negrito(CelulaInicial, CelulaFinal: String; blnNegrito: Boolean);
  Var
    parametro: Variant;
begin
  fToPoint(CelulaInicial + ':' + CelulaFinal);

  parametro    := VarArrayCreate([0, 0], varVariant);
  parametro[0] := fAtribuiProperty('Bold', blnNegrito);
  fExecuta('.uno:Bold', parametro);
end;

procedure TExcelBRO.CorFundo(CelulaInicial, CelulaFinal: String; CorFundo: TCorExcel);
  Var
    parametro: Variant;
begin
  fToPoint(CelulaInicial + ':' + CelulaFinal);

  parametro    := VarArrayCreate([0, 0], varVariant);
  parametro[0] := fAtribuiProperty('BackgroundColor', RetornaCor(CorFundo));
  fExecuta('.uno:BackgroundColor', parametro);

end;

procedure TExcelBRO.CorFonte(CelulaInicial, CelulaFinal: String; CorFonte: TCorExcel);
  Var
    parametro: Variant;
begin
  fToPoint(CelulaInicial + ':' + CelulaFinal);

  parametro    := VarArrayCreate([0, 0], varVariant);
  parametro[0] := fAtribuiProperty('Color', RetornaCor(CorFonte));
  fExecuta('.uno:Color', parametro);
end;

procedure TExcelBRO.CorFundo(CelulaInicial, CelulaFinal: String;
  CorFundo: Cardinal);
  Var
    parametro: Variant;
begin
  fToPoint(CelulaInicial + ':' + CelulaFinal);

  parametro    := VarArrayCreate([0, 0], varVariant);
  parametro[0] := fAtribuiProperty('BackgroundColor', CorFundo);
  fExecuta('.uno:BackgroundColor', parametro);
end;

procedure TExcelBRO.AdicionaPlanilha;
  Var
    intNumTab : Integer;

begin
  inherited;
  intNumTab := Documento.getSheets.getCount;

  Documento.Sheets.InsertNewByName('Planilha' + IntToStr(intNumTab + 1), intNumTab);
end;

procedure TExcelBRO.Alinhamento(Linha, Coluna: Integer; Alinhamento: TAlinhamentoExcel);
  Var
    parametro: Variant;
begin
  fToPoint(fGetLetraAlfa(Coluna) + IntToStr(Linha));

  parametro    := VarArrayCreate([0, 0], varVariant);
  parametro[0] := fAtribuiProperty('HorizontalAlignment', fRetornaAlinhamento(Alinhamento));
  fExecuta('.uno:HorizontalAlignment', parametro);
end;

procedure TExcelBRO.AlinhamentoVertical(CelulaInicial, CelulaFinal: String;
  Alinhamento: TAlinhamentoVertical);
begin
  inherited;

end;

procedure TExcelBRO.AlinhamentoVertical(Linha, Coluna: Integer;
  Alinhamento: TAlinhamentoVertical);
begin
  inherited;

end;

procedure TExcelBRO.Alinhamento(CelulaInicial, CelulaFinal: String; Alinhamento: TAlinhamentoExcel);
  Var
    parametro: Variant;
begin
  fToPoint(CelulaInicial + ':' + CelulaFinal);

  parametro    := VarArrayCreate([0, 0], varVariant);
  parametro[0] := fAtribuiProperty('HorizontalAlignment', fRetornaAlinhamento(Alinhamento));
  fExecuta('.uno:HorizontalAlignment', parametro);
end;

function TExcelBRO.CriarArquivo: Boolean;
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

function TExcelBRO.CriarArquivo(Nome_Arquivo: String): Boolean;
  Var
    parametro: Variant;
begin
  If Nome_Arquivo = EmptyStr Then
    Result := CriarArquivo

  Else If FAbrirArquivoExistente Then
    Result := AbrirArquivo(Nome_Arquivo)

  Else
  Begin
    BrOffice  := CreateOleObject('com.sun.star.ServiceManager');
    Desktop   := BrOffice.CreateInstance('com.sun.star.frame.Desktop');

    If FindWindow(nil, 'LibreOffice') > 0 Then
      ShowWindow(FindWindow(nil, 'LibreOffice'),SW_HIDE);

    parametro    := VarArrayCreate([0, 0], varVariant);
    parametro[0] := fAtribuiProperty('Hidden', True);

    Documento := Desktop.LoadComponentFromURL('private:factory/scalc', '_blank', 0, parametro);
    FPlanilha := Documento.getSheets.getByIndex(0);

    Documento.getCurrentController.getFrame.getContainerWindow.setVisible(False);

    FNomArq := Nome_Arquivo;
    Result := True;

    FExcel := BrOffice;
  End;
end;

function TExcelBRO.fAtribuiProperty(Nome: String; Valor : Variant): Variant;
  var
    Reflec : Variant;
begin
  Reflec := BrOffice.createInstance('com.sun.star.reflection.CoreReflection');
  Reflec.forName('com.sun.star.beans.PropertyValue').createObject(result);
  result.Name := Nome;
  result.Value:= Valor;
end;

function TExcelBRO.fFormataDir(strArquivo: String): String;
begin
  Result:= '';

  If AnsiLowerCase(Copy(strArquivo,1,8)) <> 'file:///' Then
    Result := 'file:///';

  Result := Result + StringReplace(strArquivo, '\', '/', [rfReplaceAll, rfIgnoreCase]);
end;

function TExcelBRO.AbrirArquivo(Nome_Arquivo: String): Boolean;
  Var
    parametro: Variant;
begin
  Result := False;
  If FileExists(Nome_Arquivo) Then
  Begin
    BrOffice  := CreateOleObject('com.sun.star.ServiceManager');
    Desktop   := BrOffice.CreateInstance('com.sun.star.frame.Desktop');

    If FindWindow(nil, 'LibreOffice') > 0 Then
      ShowWindow(FindWindow(nil, 'LibreOffice'),SW_HIDE);

    parametro    := VarArrayCreate([0, 0], varVariant);
    parametro[0] := fAtribuiProperty('Hidden', True);

    Documento := Desktop.LoadComponentFromURL(fFormataDir(Nome_Arquivo), '_blank', 0, parametro);
    FPlanilha := Documento.getSheets.getByIndex(0);

    Documento.getCurrentController.getFrame.getContainerWindow.setVisible(False);

    FNomArq := Nome_Arquivo;
    Result := True;
  End;
end;

procedure TExcelBRO.fExecuta(strComando: String; varParams: Variant);
  Var
    Dispatcher, Frame: Variant;
begin

  If (VarIsEmpty(varParams) Or VarIsNull(varParams)) Then
    varParams:= VarArrayCreate([0, -1], varVariant);

  Frame      := Documento.getCurrentController.getFrame;
  Dispatcher := BrOffice.createInstance('com.sun.star.frame.DispatchHelper');
  Dispatcher.executeDispatch(Frame, strComando, '', 0, varParams);

end;

procedure TExcelBRO.OrientacaoPagina(Orientacao: TOrientacao);
  Var
    parametro: Variant;
begin
  parametro    := VarArrayCreate([0, 0], varVariant);
  Case Orientacao Of
    Retrato : parametro[0] := fAtribuiProperty('PaperOrientation', 0);
    Paisagem: parametro[0] := fAtribuiProperty('PaperOrientation', 1);
  End;
  Documento.Printer := parametro;
end;

procedure TExcelBRO.AutoAjuste;
begin
  FPlanilha.getColumns.OptimalWidth := True;
end;

procedure TExcelBRO.CongelarPaines(Celula: String);
begin
  SalvarPosicao;
  fToPoint(Celula);
  fExecuta('.uno:FreezePanes', Unassigned);
  VoltarPosicao;
end;

procedure TExcelBRO.fToPoint(Celula: String);
  Var
    parametro: Variant;
Begin
  parametro    := VarArrayCreate([0, 0], varVariant);
  parametro[0] := fAtribuiProperty('ToPoint', Celula);
  fExecuta('.uno:GoToCell', parametro);
End;

procedure TExcelBRO.SalvarArquivo;
  Var
    parametro: Variant;
begin
  If FileExists(FNomArq) Then
    DeleteFile(FNomArq);

  parametro    := VarArrayCreate([0, 0], varVariant);
  parametro[0] := fAtribuiProperty('Overwrite', blnAbrirArquivoExistente);
  Documento.StoreAsUrl(fFormataDir(FNomArq), parametro);

  fExecuta('.uno:GoToCell', parametro);
end;

procedure TExcelBRO.SalvarPosicao;
begin
  FLinAnt := LinhaAtual;
  FColAnt := ColunaAtual
end;

procedure TExcelBRO.SetaNomePlanilha(intPlanilha: Integer; strNome: String);
begin
  inherited;
  Documento.Sheets.getByIndex(intPlanilha - 1).Name := strNome;

end;

procedure TExcelBRO.setColAtu(Coluna: Integer);
begin
  FColAtu := Coluna;
end;

procedure TExcelBRO.setLinAtu(Linha: Integer);
begin
  FLinAtu := Linha;
end;

procedure TExcelBRO.setSheet(const Value: Integer);
begin
  inherited;
  If SheetIndex > 0 Then
    FPlanilha := Documento.getSheets.getByIndex(SheetIndex - 1);
end;

procedure TExcelBRO.VoltarPosicao;
begin
  LinhaAtual  := FLinAnt;
  ColunaAtual := FColAnt;
end;

procedure TExcelBRO.FecharArquivo;
begin
  Documento.getCurrentController.getFrame.getContainerWindow.setVisible(True);

//  BrOffice.Dispose;
  BrOffice  := Unassigned;
  Documento := Unassigned;
  FPlanilha := Unassigned;
  Desktop   := Unassigned;

end;

function TExcelBRO.fAtribuirBordas(strBordCmd: String): Variant;
  Var
    bordas, parametro: Variant;
begin
  bordas := VarArrayCreate([0, 3], varInteger);
  bordas[0] := 0; bordas[1] := 0; bordas[2] := 2; bordas[3] := 0;

  parametro    := VarArrayCreate([0, 0], varVariant);
  parametro[0] := fAtribuiProperty(strBordCmd, bordas);
  fExecuta('.uno:SetBorderStyle', parametro);
end;

procedure TExcelBRO.Bordas(CelulaInicial, CelulaFinal: String; Esquerda, Direita, Superior, Inferior: Boolean);
begin
  fToPoint(CelulaInicial + ':' + CelulaFinal);

  If Esquerda Then fAtribuirBordas('OuterBorder.LeftBorder');
  If Superior Then fAtribuirBordas('OuterBorder.TopBorder');
  If Inferior Then fAtribuirBordas('OuterBorder.BottomBorder');
  If Direita  Then fAtribuirBordas('OuterBorder.RightBorder');
end;

procedure TExcelBRO.Bordas(CelulaInicial, CelulaFinal: String);
  Var
    bordas   : Variant;
    parametro: Variant;
begin

  If SameText(CelulaInicial,CelulaFinal) Then
  Begin
    Self.Bordas(CelulaInicial, CelulaFinal, True, True, True, True);
    Exit;
  End;

  fToPoint(CelulaInicial + ':' + CelulaFinal);

  bordas := VarArrayCreate([0, 3], varInteger);
  bordas[0] := 0; bordas[1] := 0; bordas[2] := 2; bordas[3] := 0;

  parametro     := VarArrayCreate([0, 12], varVariant);
  parametro[0]  := fAtribuiProperty('OuterBorder.LeftBorder', bordas);
  parametro[1]  := fAtribuiProperty('OuterBorder.LeftDistance', 0);
  parametro[2]  := fAtribuiProperty('OuterBorder.RightBorder', bordas);
  parametro[3]  := fAtribuiProperty('OuterBorder.RightDistance', 0);
  parametro[4]  := fAtribuiProperty('OuterBorder.TopBorder', bordas);
  parametro[5]  := fAtribuiProperty('OuterBorder.TopDistance', 0);
  parametro[6]  := fAtribuiProperty('OuterBorder.BottomBorder', bordas);
  parametro[7]  := fAtribuiProperty('OuterBorder.BottomDistance', 0);
  parametro[8]  := fAtribuiProperty('InnerBorder.Horizontal', bordas);
  parametro[9]  := fAtribuiProperty('InnerBorder.Vertical', bordas);
  parametro[10] := fAtribuiProperty('InnerBorder.Flags', 3);
  parametro[11] := fAtribuiProperty('InnerBorder.ValidFlags', 127);
  parametro[12] := fAtribuiProperty('InnerBorder.DefaultDistance', 0);
  fExecuta('.uno:SetBorderStyle', parametro);
end;

function TExcelBRO.RetornaCor(Cor: TCorExcel): Integer;
begin
  Result := 0;
  Case Cor Of
    Preto        : Result := 0;
    Branco       : Result := 16777215;
    Cinza        : Result := 13421772;
    CinzaEscuro  : Result := 10066329;
    Amarelo      : Result := 16776960;
    Verde_Mar    : Result := 32896;
    Verde        : Result := 32768;
    Lima         : Result := 65280;
    Azul         : Result := 255;
    Vermelho     : Result := 14426880;
  End;
end;

function TExcelBRO.RetornaFonte(Fonte: TFonteExcel): String;
begin
  Case Fonte Of
    Arial      : Result := 'Arial';
    Courier    : Result := 'Courier';
    CourierNew : Result := 'Courier New';
    Times      : Result := 'Times New Roman';
  End;
end;

function TExcelBRO.fRetornaAlinhamento(Alinhamhento: TAlinhamentoExcel): Integer;
begin
  Result := 0;
  Case Alinhamhento Of
    Esquerda: Result := 1;
    Direita : Result := 3;
    Centro  : Result := 2;
  End;
end;

function TExcelBRO.fRetornaAlinhamentoVertical(
  Alinhamento: TAlinhamentoVertical): Integer;
begin
  Result := -1;
end;

function TExcelBRO.getColAtu: Integer;
begin
  Result := FColAtu;
end;

function TExcelBRO.getLinAtu: Integer;
begin
  Result := FLinAtu;
end;

procedure TExcelBRO.PintarTudo(CorFundo: TCorExcel);
  Var
    bordas, parametro: Variant;
begin

  SalvarPosicao;
  fExecuta('.uno:SelectAll', unassigned);

  parametro    := VarArrayCreate([0, 0], varVariant);
  parametro[0] := fAtribuiProperty('BackgroundPattern.BackColor', RetornaCor(CorFundo));
  fExecuta('.uno:BackgroundPattern', parametro);

  If CorFundo = Branco Then
  Begin
    bordas := VarArrayCreate([0, 3], varInteger);
    bordas[0] := 16777215; bordas[1] := 0; bordas[2] := 2; bordas[3] := 0;

    parametro     := VarArrayCreate([0, 12], varVariant);
    parametro[0]  := fAtribuiProperty('OuterBorder.LeftBorder', bordas);
    parametro[1]  := fAtribuiProperty('OuterBorder.LeftDistance', 0);
    parametro[2]  := fAtribuiProperty('OuterBorder.RightBorder', bordas);
    parametro[3]  := fAtribuiProperty('OuterBorder.RightDistance', 0);
    parametro[4]  := fAtribuiProperty('OuterBorder.TopBorder', bordas);
    parametro[5]  := fAtribuiProperty('OuterBorder.TopDistance', 0);
    parametro[6]  := fAtribuiProperty('OuterBorder.BottomBorder', bordas);
    parametro[7]  := fAtribuiProperty('OuterBorder.BottomDistance', 0);
    parametro[8]  := fAtribuiProperty('InnerBorder.Horizontal', bordas);
    parametro[9]  := fAtribuiProperty('InnerBorder.Vertical', bordas);
    parametro[10] := fAtribuiProperty('InnerBorder.Flags', 3);
    parametro[11] := fAtribuiProperty('InnerBorder.ValidFlags', 127);
    parametro[12] := fAtribuiProperty('InnerBorder.DefaultDistance', 0);
    fExecuta('.uno:SetBorderStyle', parametro);
  End
  Else
  Begin
    parametro    := VarArrayCreate([0, 0], varVariant);
    parametro[0] := fAtribuiProperty('BackgroundPattern.BackColor', RetornaCor(CorFundo));
    fExecuta('.uno:BackgroundPattern', parametro);
  End;

  VoltarPosicao;
end;

procedure TExcelBRO.DefinirFonte(Fonte: TFonteExcel; Tamanho: Integer);
begin
  DefinirFonte('A1','AMJ65536',Fonte, Tamanho);
end;

procedure TExcelBRO.DefinirFonte(CelulaInicial, CelulaFinal: String; Fonte: TFonteExcel; Tamanho: Integer);
  Var
    parametro: Variant;
begin
  SalvarPosicao;
  fToPoint(CelulaInicial + ':' + CelulaFinal);

  parametro    := VarArrayCreate([0, 0], varVariant);
  parametro[0] := fAtribuiProperty('CharFontName.FamilyName', RetornaFonte(Fonte));
  fExecuta('.uno:CharFontName', parametro);

  parametro    := VarArrayCreate([0, 0], varVariant);
  parametro[0] := fAtribuiProperty('FontHeight.Height', Tamanho);
  fExecuta('.uno:FontHeight', parametro);

  VoltarPosicao;
end;

procedure TExcelBRO.FormatoNumerico(Linha, Coluna: Integer; Formato: String = '#.##0,00');
begin
// ESTÁ GERANDO ERRO EM MUITOS RELATÓRIOS
//  If Formato = '#.##0,00' Then
//    FPlanilha.getCellByPosition(Coluna-1, Linha-1).NumberFormat := 4

//  Else If Formato = '@' Then
//    FPlanilha.getCellByPosition(Coluna-1, Linha-1).NumberFormat := 100;
end;

procedure TExcelBRO.FormatoNumerico(CelulaInicial, CelulaFinal: String; Formato: String = '#.##0,00');
begin
// ESTÁ GERANDO ERRO EM MUITOS RELATÓRIOS
//  If Formato = '#.##0,00' Then
//    FPlanilha.getCellRangeByName(CelulaInicial, CelulaFinal).NumberFormat := 4

//  Else If Formato = '@' Then
//    FPlanilha.getCellRangeByName(CelulaInicial, CelulaFinal).NumberFormat := 100;
end;

procedure TExcelBRO.BloquearCelulas(CelulaInicial, CelulaFinal: String; Bloquear: Boolean = True);
  Var
    parametro: Variant;
begin
  SalvarPosicao;
  fToPoint(CelulaInicial + ':' + CelulaFinal);

  parametro    := VarArrayCreate([0, 0], varVariant);
  parametro[0] := fAtribuiProperty('Protection.Locked', Bloquear);
  fExecuta('.uno:Protection', parametro);

  VoltarPosicao;
end;

procedure TExcelBRO.DesprotegerPlanilha(Senha: String);
begin
  FPlanilha.unprotect(Senha);
end;

procedure TExcelBRO.ProtegerPlanilha(Senha: String);
begin
  FPlanilha.protect(Senha);
end;

procedure TExcelBRO.DesprotegerEstrutura(Senha: String);
begin
  Documento.unprotect(Senha);
end;

procedure TExcelBRO.ProtegerEstrutura(Senha: String);
begin
  Documento.protect(Senha);
end;

procedure TExcelBRO.ExcluirPlanilha(Index: Integer);
begin
  Documento.getSheets.RemoveByName(Documento.Sheets.getByIndex(Index).Name);
end;

{************************************}
{* CASO NÃO ENCONTRE DARA UMA       *}
{* MENSAGEM DE CHAVE NÃO ENCONTRADA *}
{*************MELHORAR***************}
{*********************************AF*}
function TExcelBRO.LocalizarCelula(Texto: String): Boolean;
  Var
    parametro: Variant;
begin
  parametro    := VarArrayCreate([0, 1], varVariant);
  parametro[0] := fAtribuiProperty('SearchItem.SearchString', Texto);
  parametro[1] := fAtribuiProperty('Quiet', True);
  fExecuta('.uno:ExecuteSearch', parametro);

  Result := (Trim(Documento.getCurrentSelection.getFormula) = Trim(Texto));
end;

function TExcelBRO.MaximodeLinhas: Integer;
begin
  SalvarPosicao;

  fExecuta('.uno:GoToEndOfData', Unassigned);
  Result := Documento.getCurrentSelection.getCellAddress.Row + 1;
  fExecuta('.uno:GoToStartOfData', Unassigned);

  VoltarPosicao;
end;

procedure TExcelBRO.ValidarCelulas(CelulaInicial, CelulaFinal, ValorMinimo, ValorMaximo: String);
  Const
    xlValidateDecimal = 2;
    xlValidAlertStop  = 1;
    xlBetween         = 1;
  var
    parametro : Variant;
    validation: Variant;
begin
  parametro    := VarArrayCreate([0, 0], varVariant);
  parametro[0] := fAtribuiProperty('ToPoint', CelulaInicial + ':' + CelulaFinal);
  fExecuta('.uno:GoToCell', parametro);

  validation := Documento.getCurrentSelection.Validation;

  validation.Type             := 2;
  validation.ShowErrorMessage := True;
  validation.ErrorMessage     := 'Informe um valor entre ' + ValorMinimo + ' e ' + ValorMaximo;
  validation.ErrorTitle       := 'Valor Inválido';
  validation.ShowInputMessage := False;
  validation.InputTitle       := '';
  validation.InputMessage     := '';
  validation.ErrorAlertStyle  := 0;
  validation.setOperator(7);
  validation.setFormula1(StrToInt64(ValorMinimo));
  validation.setFormula2(StrToInt64(ValorMaximo));

  Documento.getCurrentSelection.Validation := validation;
end;

function TExcelBRO.fIsDate(strData: String): Boolean;
  Var
    dtaData: TDateTime;
    Year, Month, Day: Word;
begin
  dtaData := StrToDate(strData);
  DecodeDate(dtaData, Year, Month, Day);
  Result := IsValidDate(Year, Month, Day);
end;

end.
