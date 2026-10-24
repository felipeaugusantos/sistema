unit Produto.GS1CNP.Model;

interface

uses System.SysUtils, Uni, untFuncoesSimples;

type
  TProdutoGS1CNPModel = class
  public
    class procedure GravarGS1JsonResponse(const ACodIte, AJsonResponse, AOrigem, AOperacao: String);
  end;

implementation

{ TProdutoGS1CNPModel }

class procedure TProdutoGS1CNPModel.GravarGS1JsonResponse(const ACodIte,
  AJsonResponse, AOrigem, AOperacao: String);
var
  LQryInsert: TUniQuery;
begin
  LQryInsert := fCriaQuery(Nil);
  Try
    Try
      LQryInsert.Close;
      LQryInsert.SQL.Clear;
      LQryInsert.SQL.Add('SELECT * FROM GS1JSR WHERE FALSE');
      LQryInsert.Open;

      LQryInsert.Insert;
      LQryInsert.FieldByName('JSR_CODITE').AsString   := ACodIte;
      LQryInsert.FieldByName('JSR_DTACAD').AsDateTime := VS_Date;
      LQryInsert.FieldByName('JSR_HORCAD').AsDateTime := fTime();
      LQryInsert.FieldByName('JSR_CODOPE').AsString   := strLoginUsuarioLogado;
      LQryInsert.FieldByName('JSR_CODEMP').AsString   := VS_strCodEmp;
      LQryInsert.FieldByName('JSR_ARQUIV').AsString   := AJsonResponse;
      LQryInsert.FieldByName('JSR_ORIGEM').AsString   := AOrigem;
      LQryInsert.FieldByName('JSR_OPERAC').AsString   := AOperacao;
      LQryInsert.Post;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TProdutoGS1CNPModel.GravarGS1JsonResponse]');
      End;
    End;
  Finally
    FreeAndNil(LQryInsert);
  End;
end;

end.
