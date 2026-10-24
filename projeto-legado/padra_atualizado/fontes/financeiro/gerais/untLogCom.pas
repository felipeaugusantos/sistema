{**************************************}
{* EFETUA A GRAVAÇÃO DA TABELA LOGCOM *}
{* PARA A COMISSAO DE PROFISSIONAIS   *}
{**************************************}
unit untLogCom;

interface

uses System.SysUtils, Uni, DB, StrUtils, Variants, System.Classes;

Var
    FCamposLogCom,
    FParametrosLogCom: String;

Const
  FArrayCamposIgnorados: Array of String = ['AUTOINCREM', 'COM_DTALOG', 'COM_HORLOG', 'COM_OPELOG', 'COM_DESCRI', 'COM_NOMFRM'];

procedure GeraListaDeCamposLOGCOM;

Function fGravaLogCom(AAutoIncrem,
                      ADescricao,
                      ANomeFormulario: String;
                      AOperadorLog: String = '' ) : Boolean;

Function fGravalogComLst( stlListAutoIncrem : TStringList; strDescriLog, strNomeFormulario: String ) : Boolean;

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

procedure GeraListaDeCamposLOGCOM;
  Var
    LConsulta: TUniQuery;

    LCampo: TField;
Begin
  If Not FCamposLogCom.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriarQuery('SELECT * FROM LOGCOM WHERE FALSE');
    LConsulta.Open;

    FCamposLogCom     := '';
    FParametrosLogCom := '';

    For LCampo In LConsulta.Fields Do
    Begin
      FCamposLogCom     := FCamposLogCom     + LCampo.FieldName + ',';
      FParametrosLogCom := FParametrosLogCom + ':' + LCampo.FieldName + ',';
    End;

    FCamposLogCom     := LeftStr(FCamposLogCom, FCamposLogCom.Length - 1);
    FParametrosLogCom := LeftStr(FParametrosLogCom, FParametrosLogCom.Length - 1);
  Finally
    FreeAndNil(LConsulta);
  End;
End;

function fGravaLogCom(AAutoIncrem,
                      ADescricao,
                      ANomeFormulario: String;
                      AOperadorLog: String = '' ) : boolean;
  Var
    LConsulta,
    LGravarLog: TUniQuery;

    LCampo: TField;
Begin

  Result := False;

  GeraListaDeCamposLOGCOM;

  LConsulta  := fCriaQuery;
  LGravarLog := fCriaQuery;

  Try

    LConsulta.SQL.Text := 'SELECT * FROM COMPRO WHERE AUTOINCREM="' + AAutoIncrem + '"';
    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
    Begin

      LGravarLog.SQL.Text := 'INSERT INTO LOGCOM (' + FCamposLogCom     + ') ' +
                                        ' VALUES (' + FParametrosLogCom + ') ';

      For LCampo In LConsulta.Fields Do
      Begin
          If MatchStr(LCampo.FieldName, FArrayCamposIgnorados) Then
             Continue;

          if pos(LCampo.FieldName, FCamposLogCom) = 0 then
          begin
            continue ;
          end;

          LGravarLog.ParamByName(LCampo.FieldName).Value := LCampo.Value;
      End;

      LGravarLog.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGCOM', LConsulta.FieldByName('COM_CODEMP').AsString);
      LGravarLog.ParamByName('COM_DTALOG').AsDateTime := VS_Date;
      LGravarLog.ParamByName('COM_HORLOG').AsTime     := fRetHoraServidor;
      LGravarLog.ParamByName('COM_OPELOG').AsString   := RetornaOperadorDoLog(AOperadorLog);
      LGravarLog.ParamByName('COM_DESCRI').AsString   := ADescricao;
      LGravarLog.ParamByName('COM_NOMFRM').AsString   := ANomeFormulario;

      LGravarLog.ExecSQL;

      Result := True;
    End;
    FreeAndNil(LConsulta);
    FreeAndNil(LGravarLog);

  Except
    On E: Exception Do
    Begin

      // Result := False;
       Raise Exception.Create(E.Message);

    End;
  End;
End;

Function fGravalogComLst( stlListAutoIncrem : TStringList; strDescriLog, strNomeFormulario: String ) : Boolean;
  Var
      intCont : Integer;
      strAutoincren : String;
Begin

  Try

    For intCont := 0 To stlListAutoIncrem.Count -1 Do
    Begin

      strAutoincren := stlListAutoIncrem[intCont];
      fGravaLogCom( strAutoincren, strDescriLog, strNomeFormulario, '');

    End;

    Result := True;

  Except

    On E: Exception Do
    Begin
       Raise Exception.Create(E.Message);
    End;

  End;

End;

end.
