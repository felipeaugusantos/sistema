unit untImpCheques;

interface

CONST
  IMPCHQ_ELGIN = 'ELGIN';

Type
  TImpCheques = class(TObject)
  private

  protected
    FPorta: String;
    FNumBco: String;
    FNumChq: String;
    FDtaChq: TDateTime;
    FNomFav: String;
    FNomCid: String;
    FValChq: Double;
  public

    class function fCriarImpressora: TImpCheques;

    Constructor Create;
    procedure pImprimirCheque; virtual; abstract;
    procedure pInicializaDLL; virtual;

    property strPorta: String Read FPorta Write FPorta;
    property strNumBco: String Read FNumBco Write FNumBco;
    property strNumChq: String Read FNumChq Write FNumChq;
    property dtaDtaChq: TDateTime Read FDtaChq Write FDtaChq;
    property strNomFav: String Read FNomFav Write FNomFav;
    property strNomCid: String Read FNomCid Write FNomCid;
    property fltValChq: Double Read FValChq Write FValChq;

  End;

implementation

uses SysUtils, untFuncoesSimples, untImpChequesElgin,Forms;

{ TImpCheques }

constructor TImpCheques.Create;
begin
  inherited Create;
  pInicializaDLL;
end;

class function TImpCheques.fCriarImpressora: TImpCheques;
  Var
    strMarca: String;
begin
  Result := Nil;
  strMarca := fArqIniLocal(0, 'GERAL', 'MARCA', '', ExtractFilePath(Application.ExeName)+ 'opcoes_impchq.ini');

  If strMarca = IMPCHQ_ELGIN Then
    Result := TImpChequesElgin.Create;
end;

procedure TImpCheques.pInicializaDLL;
begin
  //
end;

end.
