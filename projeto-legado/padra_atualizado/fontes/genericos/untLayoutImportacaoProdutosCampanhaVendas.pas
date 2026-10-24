unit untLayoutImportacaoProdutosCampanhaVendas;

interface

uses vcl.Controls, Winapi.Windows, SysUtils, Classes, untZClient, uni, Data.DB,
     untTValidaExcel, UniClientDataSet, StrUtils, System.Character, Dialogs,
     CxProgressBar;

Type

  TLinha = Record
    strCodigoItem: string;
    strCodigoItemCliente: string;
    fltQuantidade,
    fltPrecoCusto,
    fltPrecoContrato,
    fltPrecoCompraLiquido: Double;
  End;

  TAposCarregarDadosDaLinha = procedure (Linha: TLinha; var PararProcessamento: Boolean) of object;

  TImportaPlanilhaCampanhaVendas = Class
  Private

    FAposCarregarDadosDaLinha: TAposCarregarDadosDaLinha;
    objValidaExcel: TValidadorExcel;
    procedure pReiniciaLinha(var Linha: TLinha);

    Function fProcessaArquivoPrg(cxProgresso: TCxProgressBar): Boolean;
    function fMaiorQueZero(strValor: Variant; inLinhaAtual: Integer; var strMensagem: string): Boolean;
    function fConvertVazioToFloat(value: string): Double;

  public
    strCaminhoArquivo: string;

    constructor Create;
    destructor Destroy; override;
    procedure pProcessaArquivo();
    function fSelecionaArquivo: Boolean;
    property AposCarregarDadosDaLinha: TAposCarregarDadosDaLinha read FAposCarregarDadosDaLinha write FAposCarregarDadosDaLinha;


  End;

implementation

uses
  Forms,
  untFuncoesSimples,
  untGravando;


{ TImportaPlanilhaCampanhaVendas }

constructor TImportaPlanilhaCampanhaVendas.Create;
begin
end;

destructor TImportaPlanilhaCampanhaVendas.Destroy;
begin
end;

function TImportaPlanilhaCampanhaVendas.fSelecionaArquivo: Boolean;
var opdDialog: TOpenDialog;
begin
  opdDialog := TOpenDialog.Create(nil);
  Result := False;
  try
    opdDialog.Filter := 'Planilha|*.csv; *.xls; *.xlsx';
    If opdDialog.Execute then
    Begin
      strCaminhoArquivo := opdDialog.FileName;
      Result := not fEmptyStr(strCaminhoArquivo);
    End;
  Finally
    FreeAndNil(opdDialog);
  End;
end;

procedure TImportaPlanilhaCampanhaVendas.pReiniciaLinha(var Linha: TLinha);
begin
  Linha.strCodigoItem := '';
  Linha.strCodigoItemCliente := '';
  Linha.fltQuantidade := 0;
  Linha.fltPrecoCusto := 0;
  Linha.fltPrecoContrato := 0;
  Linha.fltPrecoCompraLiquido := 0;
end;

procedure TImportaPlanilhaCampanhaVendas.pProcessaArquivo();
  Var
    frmGravando: TfrmGravando;
Begin
  TfrmGravando.fExecuta(fProcessaArquivoPrg, frmGravando, 'Importando produtos, aguarde...');
End;

function TImportaPlanilhaCampanhaVendas.fMaiorQueZero(strValor: Variant;
  inLinhaAtual: Integer; var strMensagem: string): Boolean;
begin
  Result := False;
  If strValor > 0 Then
    Exit(True);
  strMensagem := 'Deve ser maior que zero';
end;

function TImportaPlanilhaCampanhaVendas.fConvertVazioToFloat(value: string): Double;
Begin
  value := AnsiReplaceStr(AnsiReplaceStr(value, '%', ''), 'R$', '');
  If value = '' Then
    Result := 0
  Else
    Result := StrToFloatDef(value, 0);
End;

Function TImportaPlanilhaCampanhaVendas.fProcessaArquivoPrg(cxProgresso: TCxProgressBar): Boolean;
var blnPararProcesso: Boolean;
    Linha: TLinha;
    intLinha: integer;
begin
  Result := True;

  If strCaminhoArquivo = '' Then
  Begin
    pMensagemOk('Arquivo não foi informado');
    Result := False;
    Exit;
  End;

  objValidaExcel := TValidadorExcel.Create(strCaminhoArquivo, 6, '', '', 1);
  Try
    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString('Código do Item', 'A', fTamCodIte, True, True, 'CADITE','ITE_CODITE'));

    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString('Cód. Prod. Cliente', 'B', 0, False, False, ''));

    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat('Objetivo Venda', 'C', True, fMaiorQueZero));
    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat('Preço Custo', 'D', True));
    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat('Preço Contrato', 'E', True, fMaiorQueZero));
    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat('Preço Compra Líquido', 'F', True));

    If Not objValidaExcel.fValidaCampos(True) Then
    Begin
      If fMensagem('Atenção', 'Foram encontradas inconsistências no seu arquivo, deseja prosseguir mesmo assim?', ['&Sim', '&Não']) = 2 Then
        Exit(False);
    End;

    blnPararProcesso := False;
    cxProgresso.Properties.Max := objValidaExcel.ArquivoCSV.Count;

    For intLinha := 0 To (objValidaExcel.ArquivoCSV.Count -1) Do
    Begin

      pReiniciaLinha(Linha);

      Linha.strCodigoItem         := objValidaExcel.fGetValueCSV(intLinha, 'A');
      Linha.strCodigoItemCliente  := objValidaExcel.fGetValueCSV(intLinha, 'B');
      Linha.fltQuantidade         := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, 'C'));
      Linha.fltPrecoCusto         := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, 'D'));
      Linha.fltPrecoContrato      := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, 'E'));
      Linha.fltPrecoCompraLiquido := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, 'F'));

      blnPararProcesso := False;

      FAposCarregarDadosDaLinha(Linha, blnPararProcesso);

      If blnPararProcesso Then
        Break;

      cxProgresso.Position := cxProgresso.Position + 1;
      Application.ProcessMessages;
    End;
  Finally
    FreeAndNil(objValidaExcel);
  End;

end;


end.
