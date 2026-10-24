unit untTProcessaRetornoCustodia;

interface

uses
  System.Generics.Collections, System.Generics.Defaults, System.Sysutils,
  System.Classes;

type

  TChequeCustodia = class(TPersistent)
  private
    FVencimento: TDate;
    FDeposito: TDate;
    FAgencia: String;
    FCodOcorrencia: String;
    FNumConta: String;
    FDvConta: String;
    FDescOcorrencia: String;
    FBanco: String;
    FCadastro: TDate;
    FNumCheque: String;
    FCredito: TDate;
    FValor: Double;
    FEmitente: String;
    FCmc7: String;
    FLote: String;
    FStatus: Integer;
    FChave: String;
  published
    property intStatus        : Integer read FStatus         write FStatus;
    property strChave         : String  read FChave          write FChave;
    property strLote          : String  read FLote           write FLote;
    property strCodOcorrencia : String  read FCodOcorrencia  write FCodOcorrencia;
    property strDescOcorrencia: String  read FDescOcorrencia write FDescOcorrencia;
    property strBanco         : String  read FBanco          write FBanco;
    property strAgencia       : String  read FAgencia        write FAgencia;
    property strNumConta      : String  read FNumConta       write FNumConta;
    property strDvConta       : String  read FDvConta        write FDvConta;
    property strNumCheque     : String  read FNumCheque      write FNumCheque;
    property strCmc7          : String  read FCmc7           write FCmc7;
    property strEmitente      : String  read FEmitente       write FEmitente;
    property fltValor         : Double  read FValor          write FValor;
    property dtaCadastro      : TDate   read FCadastro       write FCadastro;
    property dtaVencimento    : TDate   read FVencimento     write FVencimento;
    property dtaDeposito      : TDate   read FDeposito       write FDeposito;
    property dtaCredito       : TDate   read FCredito        write FCredito;
  end;

  TLeitorRetornoCustodia = class;

  TProcessaRetornoCustodia = class
  private
    FListaCheques: TList<TChequeCustodia>;
    function fCriaLeitor(strCodBanco: String): TLeitorRetornoCustodia;
  public
    constructor Create(); reintroduce;
    destructor Destroy; override;
    function fProcessaArquivo(strNomeArq, strCodBanco: String): Boolean;
    procedure pInsereCheque(objCheque: TChequeCustodia);
    property lstCheques: TList<TChequeCustodia> read FListaCheques;
  end;

  TLeitorRetornoCustodia = class(TPersistent)
  public
    function fLerArquivo(strNomeArquivo: String; objProcessador: TProcessaRetornoCustodia): Boolean; virtual; abstract;
  end;

const
  PRESENTE_EM_AMBOS = 0;
  SOMENTE_NO_ARQUIVO = 1;
  SOMENTE_NO_BD = 2;

implementation

{ TProcessaRetornoCustodia }

constructor TProcessaRetornoCustodia.Create;
begin
  inherited Create;
  FListaCheques := TList<TChequeCustodia>.Create();
end;

destructor TProcessaRetornoCustodia.Destroy;
var
  objChq: TChequeCustodia;
begin
  For objChq in FListaCheques Do
    objChq.Destroy;

  FreeAndNil(FListaCheques);
  inherited Destroy;
end;

function TProcessaRetornoCustodia.fCriaLeitor(
  strCodBanco: String): TLeitorRetornoCustodia;
var
  clsLeitor: TClass;
begin
  clsLeitor := FindClass('TLeitorRetornoCustodia' + strCodBanco);
  If Assigned(clsLeitor) Then
    Result := TLeitorRetornoCustodia(clsLeitor.Create)
  Else
    raise Exception.Create('Rotina de importação de arquivo de retorno de cheques em custódia não implementada para o banco ' + strCodBanco);
end;

procedure TProcessaRetornoCustodia.pInsereCheque(objCheque: TChequeCustodia);
begin
  FListaCheques.Add(objCheque);
end;

function TProcessaRetornoCustodia.fProcessaArquivo(strNomeArq, strCodBanco: String): Boolean;
var
  objLeitor: TLeitorRetornoCustodia;
begin
  objLeitor := fCriaLeitor(strCodBanco);
  Try
    Result := objLeitor.fLerArquivo(strNomeArq, Self);
  Finally
    FreeAndNil(objLeitor);
  End;
end;

end.
