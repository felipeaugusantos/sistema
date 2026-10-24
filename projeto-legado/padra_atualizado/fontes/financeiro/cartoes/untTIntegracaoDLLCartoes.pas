unit untTIntegracaoDLLCartoes;

interface

uses untConsultas,Forms,EditFocus,Vcl.StdCtrls,untTypesSistema,System.SysUtils,
     untLiberacao,untFuncoesSimples,Uni,untCadMovCartoes, untFuncoesRel;

Type
  TIntegracaoDLL = Class
  public
    Class function fIPesquisar(ASelf     : TForm;
                               edtCodigo: TCustomEdit;
                               edtDescri: TEditFocus;
                               Var chrKey: Char;
                               ACodPesquisa: String): Boolean;

    Class function PedirLiberacao(ADirAcesso: String; AMsgSenha: String; ATexto: String): Boolean;
    Class function CriarQuery: TUniQuery;
    Class function IncluirCartaoVenda(AAutoincremExtratoVenda: String): Boolean;
    Class function AlterarCartaoVenda(AAutoincremCartao: String): Boolean;
  End;

implementation

class function TIntegracaoDLL.AlterarCartaoVenda(
  AAutoincremCartao: String): Boolean;
  Var
    LCadMovCartoes : TfrmCadMovCartoes;
begin
  Result := true;
  Try
    pCriarFormularios(TfrmCadMovCartoes, LCadMovCartoes);
    LCadMovCartoes.blnChamadoDoManutencao := True;
    LCadMovCartoes.strAutoincrem := AAutoincremCartao;
    LCadMovCartoes.ShowModal;
  Finally
    FreeAndNil(LCadMovCartoes);
  End;
end;

class function TIntegracaoDLL.CriarQuery: TUniQuery;
begin
  Result := fCriaQuery(Nil);
end;

Class function TIntegracaoDLL.fIPesquisar(ASelf : TForm;
                                          edtCodigo: TCustomEdit;
                                          edtDescri: TEditFocus;
                                          Var chrKey: Char;
                                          ACodPesquisa: String): Boolean;
  Var
    arrConsultas : TConsultasArray;
begin
  Result := False;

  If UpperCase(ACodPesquisa).Equals('ESTANTREDECARD') Then
    Result := untConsultas.fPesqEstAntecipacaoRedeCard(ASelf, edtCodigo, edtDescri, Nil, chrKey,arrConsultas,True);
end;

class function TIntegracaoDLL.IncluirCartaoVenda(AAutoincremExtratoVenda: String): Boolean;
  Var
    LCadMovCartoes : TfrmCadMovCartoes;
begin
  Result := true;
  Try
    pCriarFormularios(TfrmCadMovCartoes, LCadMovCartoes);
    LCadMovCartoes.CarregaExtratoVenda(AAutoincremExtratoVenda);
    LCadMovCartoes.ShowModal;
  Finally
    FreeAndNil(LCadMovCartoes);
  End;
end;

Class function TIntegracaoDLL.PedirLiberacao(ADirAcesso:String; AMsgSenha:String;ATexto: String): Boolean;
  Var
    objLiberacao : TLiberacao;
Begin
  Try
    objLiberacao := TLiberacao.create;


    objLiberacao.Clear;
    objLiberacao.strDirAce    := ADirAcesso;
    objLiberacao.strMsgSen    := AMsgSenha;
    objLiberacao.strCodOpe    := strLoginUsuarioLogado;
    objLiberacao.objMsgLibera.pAddTexto(ATexto);

    Result := objLiberacao.fLibera;

    If Result Then
      pGeraLogLiberacao('', '', '');

  Finally
    FreeAndNil(objLiberacao);
  End;

End;

end.
