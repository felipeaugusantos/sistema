unit untCadCta;

interface

uses
  Uni;

function fVerificaLinhaCadCta(strLinha: String): Boolean;

function fVerificaGrupoCadCta(strLinha: String): Boolean;

function fValidaLinhaGrupoCadCta(strLinGru: String): Boolean;

//function fConsultaCentroCusto(Sender: TForm; qryConsulta: TUniQuery): Boolean;

implementation

uses SysUtils, StrUtils, untFuncoesSimples, Data.DB;

{*****************************************}
{* VERIFICA A LINHA DO => CADCTA <=      *}
{* RETORNA 'TRUE' CASO EXISTA            *}
{**************************************MV*}
function fVerificaLinhaCadCta(strLinha: String): Boolean;
  Var
    strSQL   : String;
    strTemp  : String;
    qryGenCta: TUniQuery;

begin
  Try

    qryGenCta := fCriaQuery(nil);

    Result := True;
    {******************************************}
    {* EX. DE LINHA: '01.00.000', '02.00.000' *}
    {***************************************MV*}
    strTemp := LeftStr(strLinha, 2) + '00000';

    If (RightStr(strLinha, 5) = '00000') Then
    Begin
      Exit;
    End;

    {*****************************************}
    {* CASO O DIGITO DO GRUPO SEJA ZERO      *}
    {* RESULT = FALSE                        *}
    {**************************************MV*}
    If Copy(strLinha, 3, 2) = '00' Then
    Begin
      Result := False;
      Exit;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  CTA_CODCTA ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCTA ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTA_CODCTA = :CODCTA ';


    With qryGenCta Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCTA').AsString := strTemp;
      Open;
      If IsEmpty Then
        Result := False;
      Close;
    End;

  Finally
    FreeAndNil(qryGenCta);
  End;

end;

{*****************************************}
{* VERIFICA SE DETERMINADO GRUPO ESTA    *}
{* CADASTRADO NO CENTRO DE CUSTO         *}
{**************************************MV*}
function fVerificaGrupoCadCta(strLinha: String): Boolean;
  Var
    strSQL   : String;
    strTemp  : String;
    qryGenCta: TUniQuery;

begin
  Try

    Result := True;

    qryGenCta := fCriaQuery(nil);

    strTemp := LeftStr(strLinha, 4) + '000';

    If RightStr(strLinha, 3) = '000' Then
    Begin
      Exit;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  CTA_CODCTA ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCTA ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTA_CODCTA = :CODCTA ';

    With qryGenCta Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCTA').AsString := strTemp;
      Open;
      If IsEmpty Then
        Result := False;
      Close;
    End;

  Finally
    FreeAndNil(qryGenCta);
  End;

end;

{*****************************************}
{* VALIDA LINHA / GRUPO DO CENTRO DE     *}
{* CUSTO                                 *}
{**************************************MV*}
function fValidaLinhaGrupoCadCta(strLinGru: String): Boolean;
begin
  Result := True;

  If RightStr(strLinGru, 3) = '000' Then
    Result := False;
end;
{**************************************************}
{* COM A NOVA CONSULTA ESSA FUNÇÃO CAIU EM DESUSO *}
{***********************************************JU*}
//function fConsultaCentroCusto(Sender: TForm;
//  qryConsulta: TUniQuery): Boolean;


end.
