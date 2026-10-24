unit untTckEstDAO;

interface

uses
  untTckEst, System.SysUtils, Uni;

type
  TTckEstDAO = class
  private
    qryTckEst: TUniQuery;
    function fRetornaSQLInsert: String;
  public
    constructor Create;
    destructor Destroy; override;
    procedure pGravar(objTcktEst: TTckEstModel);
  end;

implementation

uses
  untFuncoesSimples;

{ TTckEstDAO }

constructor TTckEstDAO.Create;
begin
  qryTckEst := fCriaQuery;
end;

destructor TTckEstDAO.Destroy;
begin
  FreeAndNil(qryTckEst);
end;

function TTckEstDAO.fRetornaSQLInsert: String;
begin
  Result := 'INSERT INTO TCKEST (    '+
            '  AUTOINCREM,           '+
            '  TCK_TICKET,           '+
            '  TCK_CODEMP,           '+
            '  TCK_CODCLI,           '+
            '  TCK_CODOPE,           '+
            '  TCK_OPELIB,           '+
            '  TCK_DTALIB,           '+
            '  TCK_HORLIB            '+
            ')                       '+
            'VALUES                  '+
            '  (                     '+
            '    :AUTOINCREM,        '+
            '    :TCK_TICKET,        '+
            '    :TCK_CODEMP,        '+
            '    :TCK_CODCLI,        '+
            '    :TCK_CODOPE,        '+
            '    :TCK_OPELIB,        '+
            '    :TCK_DTALIB,        '+
            '    :TCK_HORLIB         '+
            '  )                     ';
end;

procedure TTckEstDAO.pGravar(objTcktEst: TTckEstModel);
begin
  Try
    fStartTransaction;

    objTcktEst.setData(VS_Date);
    objTcktEst.setHora(fRetHoraServidor);

    qryTckEst.Close;
    qryTckEst.SQL.Clear;
    qryTckEst.SQL.Text := fRetornaSQLInsert;

    qryTckEst.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('TCKEST', VS_strCodEmp);
    qryTckEst.ParamByName('TCK_TICKET').AsString   := objTcktEst.getTicket;
    qryTckEst.ParamByName('TCK_CODEMP').AsString   := VS_strCodEmp;
    qryTckEst.ParamByName('TCK_CODCLI').AsString   := objTcktEst.getCodCli;
    qryTckEst.ParamByName('TCK_CODOPE').AsString   := objTcktEst.getCodOpeVenda;
    qryTckEst.ParamByName('TCK_OPELIB').AsString   := objTcktEst.getCodOpeLib;
    qryTckEst.ParamByName('TCK_DTALIB').AsDateTime := objTcktEst.getData;
    qryTckEst.ParamByName('TCK_HORLIB').AsTime     := objTcktEst.getHora;

    If (fEmptyStr(objTcktEst.getCodOpeLib)) Then
      qryTckEst.ParamByName('TCK_OPELIB').Clear;

    qryTckEst.ExecSQL;

    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
    End;
  End;
end;

end.
