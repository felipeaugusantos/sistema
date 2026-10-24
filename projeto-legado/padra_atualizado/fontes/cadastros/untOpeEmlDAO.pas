unit untOpeEmlDAO;

interface

uses
  System.SysUtils, Uni, untOpeEml, Data.DB, UniClientDataSet;

Type
  TOpeEmlDAO = class
  private
    qryTabela: TUniQuery;

    function fRetornaSQLInsert: String;
    function fRetornaSQLDelete(strCondicao: String): String;
    function fRetornaSQLSelect(strCondicao: String): String;
    function fRetornaSQLSelectAgrupado(strCondicao: String): String;
    function fMontaObjModel(objDados: TDataSet): TOpeEml;
    function fExecutaDelete(strCondicao: String): Boolean;
    procedure pPreencheParametrosQuery(objDados: TOpeEml);
    procedure pExecutaConsulta(strCondicao: String; blnAgrupada: Boolean = False);
  public
    constructor Create;
    destructor Destroy; override;
    function fGravar(objDados: TOpeEml): Boolean;
    function fBuscaPorOperador(strCodOpe: String): TUniQuery;
    function fBuscaPorOperadorEmpresa(strCodOpe, strCodEmp: String): TOpeEml;
    function fDeletar(strCodOpe: String): Boolean;
  end;

implementation

uses
  untFuncoesSimples;

constructor TOpeEmlDAO.Create;
begin
  qryTabela := fCriaQuery;
end;

destructor TOpeEmlDAO.Destroy;
begin
  inherited;
  FreeAndNil(qryTabela);
end;

function TOpeEmlDAO.fRetornaSQLInsert: String;
begin
  Result := '  INSERT INTO OPEEML  '+
            '  (                   '+
            '    EML_CODEMP,       '+
            '    EML_CODOPE,       '+
            '    EML_E_NOME,       '+
            '    EML_CODPRV,       '+
            '    EML_E_MAIL,       '+
            '    EML_EMALOG,       '+
            '    EML_PRVSEN,       '+
            '    EML_EMAAUT,       '+
            '    EML_IMAGEM,       '+
            '    EML_TEXTO_,       '+
            '    EML_IMGB64        '+
            '  )                   '+
            '  VALUES              '+
            '    (                 '+
            '      :CODEMP,        '+
            '      :CODOPE,        '+
            '      :E_NOME,        '+
            '      :CODPRV,        '+
            '      :E_MAIL,        '+
            '      :EMALOG,        '+
            '      :PRVSEN,        '+
            '      :EMAAUT,        '+
            '      :IMAGEM,        '+
            '      :TEXTO_,        '+
            '      :IMGB64         '+
            '    )                 ';
end;

function TOpeEmlDAO.fRetornaSQLSelect(strCondicao: String): String;
begin
  Result := '  SELECT * FROM OPEEML      '+
            #13 + strCondicao;
end;

function TOpeEmlDAO.fRetornaSQLSelectAgrupado(strCondicao: String): String;
begin
  Result := '  SELECT                                     '+
            '    GROUP_CONCAT(EML_CODEMP) AS EML_EMAEMP,  '+
            '    EML_CODOPE,                              '+
            '    EML_E_NOME,                              '+
            '    EML_CODPRV,                              '+
            '    EML_E_MAIL,                              '+
            '    EML_EMALOG,                              '+
            '    EML_PRVSEN,                              '+
            '    EML_EMAAUT,                              '+
            '    EML_IMAGEM,                              '+
            '    EML_TEXTO_,                              '+
            '    EML_IMGB64,                              '+
            '    PRV_NOMPRV AS EML_NOMPRV                 '+
            '  FROM                                       '+
            '    OPEEML                                   '+
            '    INNER JOIN CADPRV                        '+
            '      ON PRV_CODPRV = EML_CODPRV             '+
               strCondicao                                 +
            '  GROUP BY EML_E_NOME,                       '+
            '    EML_CODPRV,                              '+
            '    EML_E_MAIL,                              '+
            '    EML_EMALOG,                              '+
            '    EML_PRVSEN,                              '+
            '    EML_EMAAUT,                              '+
            '    EML_IMAGEM,                              '+
            '    EML_TEXTO_,                              '+
            '    EML_IMGB64                               ';
end;

function TOpeEmlDAO.fRetornaSQLDelete(strCondicao: String): String;
begin
  Result := '  DELETE FROM OPEEML        '+
            #13 + strCondicao;
end;

function TOpeEmlDAO.fBuscaPorOperador(strCodOpe: String): TUniQuery;
  Var
    strCondicao: String;
begin
  strCondicao := ' WHERE EML_CODOPE  = '+ QuotedStr(strCodOpe);

  pExecutaConsulta(strCondicao, True);
  Result := qryTabela;
end;

function TOpeEmlDAO.fBuscaPorOperadorEmpresa(strCodOpe, strCodEmp: String): TOpeEml;
  Var
    strCondicao: String;
begin
  strCondicao := ' WHERE EML_CODOPE  = '+ QuotedStr(strCodOpe)+
                 '   AND EML_CODEMP  = '+ QuotedStr(strCodEmp);

  pExecutaConsulta(strCondicao);
  Result := fMontaObjModel(qryTabela);
end;

function TOpeEmlDAO.fDeletar(strCodOpe: String): Boolean;
begin
  Result := fExecutaDelete(' WHERE EML_CODOPE = ' + QuotedStr(strCodOpe));
end;

function TOpeEmlDAO.fGravar(objDados: TOpeEml): Boolean;
begin
  Try
    fStartTransaction;

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Text := fRetornaSQLInsert;

    pPreencheParametrosQuery(objDados);
    qryTabela.ExecSQL;

    Result := fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Raise Exception.Create('Erro ao gravar dados: ' + E.Message);
    End;
  End;
end;

function TOpeEmlDAO.fExecutaDelete(strCondicao: String): Boolean;
begin
  Try
    fStartTransaction;

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Text := fRetornaSQLDelete(strCondicao);
    qryTabela.ExecSQL;

    Result := fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Raise Exception.Create('Erro ao deletar dados: ' + E.Message);
    End;
  End;
end;

procedure TOpeEmlDAO.pPreencheParametrosQuery(objDados: TOpeEml);
begin
  qryTabela.ParamByName('CODEMP').AsString := objDados.getCodEmp;
  qryTabela.ParamByName('CODOPE').AsString := objDados.getCodOpe;
  qryTabela.ParamByName('E_NOME').AsString := objDados.getE_Nome;
  qryTabela.ParamByName('CODPRV').AsString := objDados.getCodPrv;
  qryTabela.ParamByName('E_MAIL').AsString := objDados.getE_Mail;
  qryTabela.ParamByName('EMALOG').AsString := objDados.getEmaLog;
  qryTabela.ParamByName('PRVSEN').AsString := objDados.getPrvSen;
  qryTabela.ParamByName('EMAAUT').AsString := objDados.getEmaAut;
  qryTabela.ParamByName('IMAGEM').AsString := objDados.getImagem;
  qryTabela.ParamByName('TEXTO_').AsString := objDados.getTexto_;
  qryTabela.ParamByName('IMGB64').AsString := objDados.getImgB64;
end;

procedure TOpeEmlDAO.pExecutaConsulta(strCondicao: String; blnAgrupada: Boolean = False);
begin
  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Text := IIF(blnAgrupada, fRetornaSQLSelectAgrupado(strCondicao), fRetornaSQLSelect(strCondicao));
  qryTabela.Open;
end;

function TOpeEmlDAO.fMontaObjModel(objDados: TDataSet): TOpeEml;
begin
  Result := Nil;

  If (objDados.IsEmpty) Then
    Exit;

  Result := TOpeEml.Create(objDados.FieldByName('EML_CODOPE').AsString,
                           objDados.FieldByName('EML_CODEMP').AsString,
                           objDados.FieldByName('EML_E_NOME').AsString,
                           objDados.FieldByName('EML_CODPRV').AsString,
                           objDados.FieldByName('EML_E_MAIL').AsString,
                           objDados.FieldByName('EML_EMALOG').AsString,
                           objDados.FieldByName('EML_PRVSEN').AsString,
                           objDados.FieldByName('EML_EMAAUT').AsString,
                           objDados.FieldByName('EML_IMAGEM').AsString,
                           objDados.FieldByName('EML_TEXTO_').AsString,
                           objDados.FieldByName('EML_IMGB64').AsString);
end;

end.
