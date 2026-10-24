{**************************************}
{* EFETUA A GRAVAÇÃO DA TABELA MOVCTR *}
{* TABELA RELACIONAL DA MOVBAN QUANDO *}
{* UTILIZADO SEPARAÇÃO DE JUROS E     *}
{* DESCONTO N MOVBAN                  *}
{**************************************}
unit untLogMovCtr;

interface

uses System.SysUtils, Uni, DB, StrUtils, Variants, System.Classes;

Var
    FCamposLogMovCtr,
    FParametrosLogMovCtr: String;

Const
  FArrayCamposIgnorados: Array of String = ['AUTOINCREM', 'MOV_DTALOG', 'MOV_HORLOG', 'MOV_OPELOG', 'MOV_DESCRI', 'MOV_NOMFRM'];

procedure GeraListaDeCamposLOGMOVCTR;

Function fGravaLogMovCtr(AAutoIncrem,
                      ADescricao,
                      ANomeFormulario: String;
                      AOperadorLog: String = '' ) : Boolean;

function RetornaOperadorDoLog(AOperadorLog: String): String;

implementation

uses untFuncoesSimples, untUtilRepository, Forms, System.DateUtils,
     untVersaoProg;

function RetornaOperadorDoLog(AOperadorLog: String): String;
Begin
  Result := strLoginUsuarioLogado;

  If Not AOperadorLog.IsEmpty Then
    Result := AOperadorLog;
End;

procedure GeraListaDeCamposLOGMOVCTR;
  Var
    LConsulta: TUniQuery;

    LCampo: TField;
Begin
  If Not FCamposLogMovCtr.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriarQuery('SELECT * FROM LOGMCR WHERE FALSE');
    LConsulta.Open;

    FCamposLogMovCtr     := '';
    FParametrosLogMovCtr := '';

    For LCampo In LConsulta.Fields Do
    Begin
      FCamposLogMovCtr     := FCamposLogMovCtr     + LCampo.FieldName + ',';
      FParametrosLogMovCtr := FParametrosLogMovCtr + ':' + LCampo.FieldName + ',';
    End;

    FCamposLogMovCtr     := LeftStr(FCamposLogMovCtr, FCamposLogMovCtr.Length - 1);
    FParametrosLogMovCtr := LeftStr(FParametrosLogMovCtr, FParametrosLogMovCtr.Length - 1);
  Finally
    FreeAndNil(LConsulta);
  End;
End;

function fGravaLogMovCtr(AAutoIncrem,
                         ADescricao,
                         ANomeFormulario: String;
                         AOperadorLog: String = '' ) : boolean;
  Var
    LConsulta,
    LGravarLog: TUniQuery;

    LCampo: TField;
Begin

  Result := False;

  GeraListaDeCamposLOGMOVCTR;

  LConsulta  := fCriaQuery;
  LGravarLog := fCriaQuery;

  Try

    LConsulta.SQL.Text := 'SELECT * FROM MOVCTR WHERE AUTOINCREM="' + AAutoIncrem + '"';
    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
    Begin

      LGravarLog.SQL.Text := 'INSERT INTO LOGMCR (' + FCamposLogMovCtr     + ') ' +
                                        ' VALUES (' + FParametrosLogMovCtr + ') ';

      For LCampo In LConsulta.Fields Do
      Begin
          If MatchStr(LCampo.FieldName, FArrayCamposIgnorados) Then
             Continue;

          if pos(LCampo.FieldName, FCamposLogMovCtr) = 0 then
          begin
            continue ;
          end;

          LGravarLog.ParamByName(LCampo.FieldName).Value := LCampo.Value;
      End;

      LGravarLog.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGMCR', VS_strCodEmp);
      LGravarLog.ParamByName('MOV_DTALOG').AsDateTime := VS_Date;
      LGravarLog.ParamByName('MOV_HORLOG').AsTime     := fRetHoraServidor;
      LGravarLog.ParamByName('MOV_OPELOG').AsString   := RetornaOperadorDoLog(AOperadorLog);
      LGravarLog.ParamByName('MOV_DESCRI').AsString   := ADescricao;
      LGravarLog.ParamByName('MOV_NOMFRM').AsString   := ANomeFormulario;

      LGravarLog.ExecSQL;

      Result := True;
    End;
    FreeAndNil(LConsulta);
    FreeAndNil(LGravarLog);

  Except
    On E: Exception Do
    Begin

       Raise Exception.Create(E.Message);

    End;
  End;
End;

end.
