unit untTckEstController;

interface

uses
  untInterSistemaEstacionamento, untTckEst, untTckEstDAO, untIntegracaoCTX,
  System.SysUtils;

type
  TTckEstController = class
  private
    objTckEstDAO: TTckEstDAO;
    objSistemaEstacionamento: ISistemaEstacionamento;
    function fMontaObjTckEst(strCodTicket, strCodCli, strCodOpeLiberacao: String): TTckEstModel;
    procedure pGravarTicket(objTckEst: TTckEstModel);
  public
    constructor Create;
    destructor Destroy; override;
    function fLiberarTicket(strCodTicket, strCodCli: String;
      Var strMsgRetorno: String; strCodOpeLiberacao: String = ''): Boolean;
  end;

implementation

uses
  untFuncoesSimples;

{ TTckEstController }

constructor TTckEstController.Create;
begin
  objTckEstDAO := TTckEstDAO.Create;
end;

destructor TTckEstController.Destroy;
begin
  FreeAndNil(objTckEstDAO);
end;

function TTckEstController.fLiberarTicket(strCodTicket, strCodCli: String;
  Var strMsgRetorno: String; strCodOpeLiberacao: String = ''): Boolean;
  Var
    objTckEst: TTckEstModel;
begin
  objTckEst := fMontaObjTckEst(strCodTicket, strCodCli, strCodOpeLiberacao);
  objSistemaEstacionamento := TIntegracaoCTX.Create;

  Try
    Result := objSistemaEstacionamento.fSolicitaLiberacaoDeTicket(strCodTicket, strMsgRetorno);

    If (Result) Then
      pGravarTicket(objTckEst);
  Finally
    FreeAndNil(objTckEst);
  End;
end;

procedure TTckEstController.pGravarTicket(objTckEst: TTckEstModel);
begin
  objTckEstDAO.pGravar(objTckEst);
end;

function TTckEstController.fMontaObjTckEst(strCodTicket, strCodCli,
  strCodOpeLiberacao: String): TTckEstModel;
begin
  Result := TTckEstModel.Create;
  Result.setTicket(strCodTicket);
  Result.setCodCli(strCodCli);
  Result.setCodOpeVenda(strLoginUsuarioLogado);
  Result.setCodOpeLib(strCodOpeLiberacao);
end;

end.
