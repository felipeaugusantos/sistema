unit untWord;

interface

uses Classes, Dialogs, ComObj, Variants, UITypes;

type
  TWord = Class(TComponent)
  protected
    FNomArq  : String;
    FWord    : Variant;
    Documento: Variant;
    Texto    : Variant;
    FBlnTabelaCriada: Boolean;
  public
    class function fCriarWord(Owner: TComponent): TWord;

    procedure pGoToPageHeader; Virtual; Abstract;
    procedure pGoToMainDocument; Virtual; Abstract;
    procedure pGoToPageFooter; Virtual; Abstract;
    procedure pInsereImagem(strPath: String); overload; Virtual; Abstract;
    procedure pInsereImagem(strPath: String; strSearchStringImagem: String); overload; Virtual; Abstract;
    procedure pReplace(strOri, strDes: String); Virtual; Abstract;
    procedure pCriaTabela(strChave: String; intQtdLin, intQtdCol: Integer); Virtual; Abstract;
    procedure pCelulaNegrito(intLinha, intColuna: Integer); Virtual; Abstract;
    procedure pOtimizaTamanho(intLinha, intColuna : Integer; intTamanho : Integer = 0); Virtual; Abstract;
    procedure pCelulaEscreve(intLinha, intColuna: Integer; strTexto: String); Virtual; Abstract;
    procedure pCelulaAlignRight(intLinha, intColuna: Integer); Virtual; Abstract;
    procedure pSalvar; Virtual; Abstract;
    procedure pSalvarSemPerguntarFormato; Virtual;
    procedure pSetarImpressora(strPrinter: String); Virtual; Abstract;
    procedure pPrint; Virtual; Abstract;
    procedure pFechar;Virtual; Abstract;
    procedure pSaveAsHtml;Virtual; Abstract;
    function AbrirArquivo(Nome_Arquivo: String): Boolean;Virtual; Abstract;
    procedure SaveAsPDF(const ATargetFileURL: string); Virtual; Abstract;
    procedure pCelulaAlignCenter(intLinha, intColuna: Integer); Virtual; Abstract;
  published
    property Word: Variant        read FWord  write FWord;
    property NomeArquivo: String  read FNomArq;
    property blnTabelaCriada: Boolean read FBlnTabelaCriada write FBlnTabelaCriada;
  end;

implementation

uses untWordBRO, untWordOfc;

{ TWord }

class function TWord.fCriarWord(Owner: TComponent): TWord;
  Var
    test: Variant;
begin

  Try
    test := CreateOleObject('Word.Application');
    test.Quit;

    Result := TWordOfc.Create(Owner);
  Except
    Try
      Result := TWordBRO.Create(Owner);
    Except
      MessageDlg('É suportado Office até 2007 ou BROffice!' + #10#13 + 'Não foi possível carregar aplicativo!', mtWarning, [mbOK], 0);
      Result := Nil;
    End;
  End;
end;

procedure TWord.pSalvarSemPerguntarFormato;
begin
  // Só o LibreOffice pergunta o formato ao salvar: aqui grava como sempre.
  pSalvar;
end;


end.
