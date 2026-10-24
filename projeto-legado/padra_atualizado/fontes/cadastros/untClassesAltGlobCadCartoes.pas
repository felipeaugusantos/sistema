unit untClassesAltGlobCadCartoes;

interface

uses Datasnap.DBClient, UniClientDataSet, MemDS, DBAccess, Uni, Data.DB,
     System.Generics.Collections ;

type
  TDadosAtualizarCartaoSelecionados = (dacsClisitef, dacsNcr) ;
  TArrayDadosAtualizarCartao = array[TDadosAtualizarCartaoSelecionados] of Boolean ;

  TListaAutoIncremCadCar = TList<String> ;

  TDadosAtualizarCartao = record
    CAR_TFTRED: String;
    CAR_TFTBAN: String;
    CAR_TFRED2: String;
    CAR_TFBAN2: String;
    CAR_STATUS: String;
  end ;

  TDadosAlteracaoGlobalCartoes = class
  private
    class function fListaToStr(const ALstAutoIncs: TListaAutoIncremCadCar): String ;
  public
    class function fCarregarDados(var AcdsDados: TUniClientDataSet): Boolean ;
    class function fAtualizarDados(const ArecCartao: TDadosAtualizarCartao;
                                   const ALstAutoIncs: TListaAutoIncremCadCar;
                                   const LarrAtualizar: TArrayDadosAtualizarCartao): Boolean ;
  end ;

implementation

uses untFuncoesSimples, SysUtils, StrUtils ;

{ TDadosAlteracaoGlobalCartoes }

class function TDadosAlteracaoGlobalCartoes.fAtualizarDados(const ArecCartao: TDadosAtualizarCartao;
                                                            const ALstAutoIncs: TListaAutoIncremCadCar;
                                                            const LarrAtualizar: TArrayDadosAtualizarCartao): Boolean;
var
  LstrCodigos: String ;
  LqryExec: TUniQuery ;
begin
  Result := False ;
  LstrCodigos := fListaToStr(ALstAutoIncs) ;
  if fEmptyStr(LstrCodigos) then
    Exit ;

  LqryExec := fCriaQuery() ;
  try
    try

      LqryExec.Close ;
      LqryExec.SQL.Clear ;
      LqryExec.SQL.Add(' UPDATE CADCAR ') ;
      LqryExec.SQL.Add(' SET ') ;
      LqryExec.SQL.Add('   CAR_STATUS = :STATUS  ') ;
      LqryExec.SQL.Add(' WHERE CAR_CODCAR IN (' + LstrCodigos + ') ; ') ;
      LqryExec.ParamByName('STATUS').AsString := ArecCartao.CAR_STATUS ;
      LqryExec.ExecSQL ;

      if LarrAtualizar[dacsClisitef] then
      begin
        LqryExec.Close ;
        LqryExec.SQL.Clear ;
        LqryExec.SQL.Add(' UPDATE CADCAR ') ;
        LqryExec.SQL.Add(' SET ') ;
        LqryExec.SQL.Add('   CAR_TFTRED = :TFTRED, ') ;
        LqryExec.SQL.Add('   CAR_TFTBAN = :TFTBAN  ') ;
        LqryExec.SQL.Add(' WHERE CAR_CODCAR IN (' + LstrCodigos + ') ; ') ;
        LqryExec.ParamByName('TFTRED').AsString := ArecCartao.CAR_TFTRED ;
        LqryExec.ParamByName('TFTBAN').AsString := ArecCartao.CAR_TFTBAN ;
        LqryExec.ExecSQL ;
      end ;
      if LarrAtualizar[dacsNcr] then
      begin
        LqryExec.Close ;
        LqryExec.SQL.Clear ;
        LqryExec.SQL.Add(' UPDATE CADCAR ') ;
        LqryExec.SQL.Add(' SET ') ;
        LqryExec.SQL.Add('   CAR_TFRED2 = :TFRED2, ') ;
        LqryExec.SQL.Add('   CAR_TFBAN2 = :TFBAN2  ') ;
        LqryExec.SQL.Add(' WHERE CAR_CODCAR IN (' + LstrCodigos + ') ; ') ;
        LqryExec.ParamByName('TFRED2').AsString := ArecCartao.CAR_TFRED2 ;
        LqryExec.ParamByName('TFBAN2').AsString := ArecCartao.CAR_TFBAN2 ;
        LqryExec.ExecSQL ;
      end ;
    except
      On E: Exception Do
      begin
        pMensagensErro(E.Message , '[TDadosAlteracaoGlobalCartoes.fAtualizarDados]');
        exit ;
      end ;
    end;
  finally
    FreeAndNil(LqryExec);
  end ;

  Result := True ;
end;

class function TDadosAlteracaoGlobalCartoes.fCarregarDados(var AcdsDados: TUniClientDataSet): Boolean;
var
  LqryCartoes: TUniQuery ;
begin
  LqryCartoes := fCriaQuery() ;
  try
    LqryCartoes.Close ;
    LqryCartoes.SQL.Clear ;
    LqryCartoes.SQL.Add(' SELECT CADCAR.CAR_CODCAR, ') ;
    LqryCartoes.SQL.Add('        CADCAR.CAR_DESCAR, ') ;
    LqryCartoes.SQL.Add('        CADCAR.CAR_TFTRED, ') ;
    LqryCartoes.SQL.Add('        CADCAR.CAR_TFTBAN, ') ;
    LqryCartoes.SQL.Add('        CADCAR.CAR_TFRED2, ') ;
    LqryCartoes.SQL.Add('        CADCAR.CAR_TFBAN2, ') ;
    LqryCartoes.SQL.Add('        CADCAR.CAR_CODEMP, ') ;
    LqryCartoes.SQL.Add('        CADEMP.EMP_NOMFAN, ') ;
    LqryCartoes.SQL.Add('        CADCAR.CAR_STATUS ') ;
    LqryCartoes.SQL.Add(' FROM CADCAR LEFT JOIN CADEMP ON CADCAR.CAR_CODEMP = CADEMP.EMP_CODEMP ') ;
    LqryCartoes.SQL.Add(' ORDER BY CADCAR.CAR_DESCAR ') ;
    LqryCartoes.Open ;

    if Assigned(AcdsDados) then
      FreeAndNil(AcdsDados);

    AcdsDados := fCriaClientDatset(LqryCartoes) ;


  finally
    FreeAndNil(LqryCartoes) ;
  end ;

  Result := True ;
end;

class function TDadosAlteracaoGlobalCartoes.fListaToStr(
  const ALstAutoIncs: TListaAutoIncremCadCar): String;
var
  LstrValor: String ;
begin
  Result := '' ;
  for LstrValor in ALstAutoIncs do
    Result := Result + IfThen(Trim(Result) <> '', ',', '') + QuotedStr(LstrValor) ;
end;

end.
