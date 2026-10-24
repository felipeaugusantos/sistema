unit untTReimpressaoRelRessarcimentoCat158;

interface

uses UniClientDataSet,
     SysUtils,
     Uni;

type
  TReImpressaoRelRessarcimentoCat158 = class
  private
    FCdsEntradasReImpressao: TUniClientDataSet;
    FCdsSaidasReImpressao: TUniClientDataSet;
    FExisteDadosPeriodo: boolean;
    FQryDados: TUniQuery;
    FDtaIni: TDateTime;
    FDtaFin: TDateTime;
    FCodEmp: String;

    procedure pCarregaRegistrosImpressaoPeridoEntradas;
    procedure pCarregaRegistrosImpressaoPeridoSaidas;
    procedure pCarregaClients;
  public
    function fReImpressao: boolean;

    constructor create;
    destructor Destroy; override;

    property cdsEntradasReImpressao: TUniClientDataSet read FCdsEntradasReImpressao write FCdsEntradasReImpressao;
    property cdsSaidasReImpressao: TUniClientDataSet read FCdsSaidasReImpressao write FCdsSaidasReImpressao;
    property blnExisteDadosPeriodo: boolean read FExisteDadosPeriodo write FExisteDadosPeriodo;
    property dtaDtaIni: TDateTime read FDtaIni write FDtaIni;
    property dtaDtaFin: TDateTime read FDtaFin write FDtaFin;
    property strCodEmp: String read FCodEmp write FCodEmp;
  end;

implementation

uses untFuncoes, untFuncoesSimples;

{ TReimpressaoRelRessarcimentoCat158 }

constructor TReImpressaoRelRessarcimentoCat158.create;
begin
  FQryDados := fCriaQuery(nil);
end;

destructor TReImpressaoRelRessarcimentoCat158.Destroy;
begin
  FQryDados.Free;

  inherited;
end;

procedure TReImpressaoRelRessarcimentoCat158.pCarregaClients;
begin
  FExisteDadosPeriodo := false;

  with FQryDados do
  begin
    pCarregaRegistrosImpressaoPeridoEntradas;
    while not Eof do
    begin
      FCdsEntradasReImpressao.Append;
      FCdsEntradasReImpressao.FieldByName('DATA').AsDateTime := FieldByName('CAT_DTAENT').AsDateTime;
      FCdsEntradasReImpressao.FieldByName('DOCUMENTO').AsString := FieldByName('CAT_NUMDOC').AsString;
      FCdsEntradasReImpressao.FieldByName('FORNECEDOR').AsString := FieldByName('CAT_FORNEC').AsString;
      FCdsEntradasReImpressao.FieldByName('QUANTIDADE').AsFloat := FieldByName('CAT_QTDITE').AsFloat;
      FCdsEntradasReImpressao.FieldByName('TOTAL_PRODUTO').AsFloat := FieldByName('CAT_VLRCON').AsFloat;
      FCdsEntradasReImpressao.FieldByName('VALOR_ICMS').AsFloat := FieldByName('CAT_VALICM').AsFloat;
      FCdsEntradasReImpressao.FieldByName('VALORST').AsFloat := FieldByName('CAT_VALRET').AsFloat;
      FCdsEntradasReImpressao.FieldByName('VALORIPI').AsFloat := FieldByName('CAT_VALIPI').AsFloat;
      FCdsEntradasReImpressao.FieldByName('AUTOINCREM_VENDA').AsString := FieldByName('CAT_INCVEN').AsString;
      FCdsEntradasReImpressao.FieldByName('BASE_ICMS').AsFloat := FieldByName('CAT_BASICM').AsFloat;
      FCdsEntradasReImpressao.FieldByName('BASE_ST').AsFloat := FieldByName('CAT_BASRET').AsFloat;
      FCdsEntradasReImpressao.Post;

      Next;
    end;

    pCarregaRegistrosImpressaoPeridoSaidas;
    while not Eof do
    begin
      FCdsSaidasReImpressao.Append;
      FCdsSaidasReImpressao.FieldByName('DOCUMENTO').AsString := FieldByName('CAT_NUMDOC').AsString;
      FCdsSaidasReImpressao.FieldByName('DATA_EMISSAO').AsDateTime := FieldByName('CAT_DTAENT').AsDateTime;
      FCdsSaidasReImpressao.FieldByName('CLIENTE').AsString := FieldByName('CAT_CLIENT').AsString;
      FCdsSaidasReImpressao.FieldByName('ESTADO').AsString := FieldByName('CAT_ESTADO').AsString;
      FCdsSaidasReImpressao.FieldByName('CODITE').AsString := FieldByName('CAT_CODITE').AsString;
      FCdsSaidasReImpressao.FieldByName('REFERENCIA').AsString := FieldByName('CAT_REFERE').AsString;
      FCdsSaidasReImpressao.FieldByName('UNIDADE').AsString := FieldByName('CAT_UNIDAD').AsString;
      FCdsSaidasReImpressao.FieldByName('QUANTIDADE').AsFloat := FieldByName('CAT_QTDITE').AsFloat;
      FCdsSaidasReImpressao.FieldByName('CFOP').AsString := FieldByName('CAT_CLAFIS').AsString;
      FCdsSaidasReImpressao.FieldByName('VLR_CONTABIL').AsFloat := FieldByName('CAT_VLRCON').AsFloat;
      FCdsSaidasReImpressao.FieldByName('VLR_ICMS').AsFloat := FieldByName('CAT_VALICM').AsFloat;
      FCdsSaidasReImpressao.FieldByName('VLR_ICMS_ST').AsFloat := FieldByName('CAT_VALRET').AsFloat;
      FCdsSaidasReImpressao.FieldByName('VLR_DIFAL_ORIGEM').AsFloat := FieldByName('CAT_DIFORI').AsFloat;
      FCdsSaidasReImpressao.FieldByName('VLR_DIFAL_DESTINO').AsFloat := FieldByName('CAT_DIFDES').AsFloat;
      FCdsSaidasReImpressao.FieldByName('AUTOINCREM').AsString := FieldByName('CAT_INCVEN').AsString;
      FCdsSaidasReImpressao.Post;

      Next;
    end;
  end;

  if (FCdsEntradasReImpressao.RecordCount > 0) or (FCdsSaidasReImpressao.RecordCount > 0) then
    FExisteDadosPeriodo := true;
end;

procedure TReImpressaoRelRessarcimentoCat158.pCarregaRegistrosImpressaoPeridoEntradas;
  var
    strSQL: string;
begin
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CAT_DTAENT, ';
  strSQL := strSQL + '  CAT_NUMDOC, ';
  strSQL := strSQL + '  CAT_FORNEC, ';
  strSQL := strSQL + '  CAT_QTDITE, ';
  strSQL := strSQL + '  CAT_VLRCON, ';
  strSQL := strSQL + '  CAT_VALICM, ';
  strSQL := strSQL + '  CAT_VALRET, ';
  strSQL := strSQL + '  CAT_VALIPI, ';
  strSQL := strSQL + '  CAT_INCVEN, ';
  strSQL := strSQL + '  CAT_BASICM, ';
  strSQL := strSQL + '  CAT_BASRET ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CAT_158_ENTRADA ';
  strSQL := strSQL + 'WHERE CAT_MESANO = :MESANO ';
  strSQL := strSQL + '  AND CAT_CODEMP = :CODEMP ';

  with FQryDados do
  begin
    Close;
    SQL.Clear;
    SQL.Text := strSQL;
    ParamByName('MESANO').AsString := FormatDateTime('MM/YYYY', FDtaIni);
    ParamByName('CODEMP').AsString := FCodEmp;
    Open;
    First;
  end;
end;

procedure TReImpressaoRelRessarcimentoCat158.pCarregaRegistrosImpressaoPeridoSaidas;
  var
    strSQL: string;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CAT_NUMDOC, ';
  strSQL := strSQL + '  CAT_DTAENT, ';
  strSQL := strSQL + '  CAT_CLIENT, ';
  strSQL := strSQL + '  CAT_ESTADO, ';
  strSQL := strSQL + '  CAT_CODITE, ';
  strSQL := strSQL + '  CAT_REFERE, ';
  strSQL := strSQL + '  CAT_UNIDAD, ';
  strSQL := strSQL + '  CAT_QTDITE, ';
  strSQL := strSQL + '  CAT_CLAFIS, ';
  strSQL := strSQL + '  CAT_VLRCON, ';
  strSQL := strSQL + '  CAT_VALICM, ';
  strSQL := strSQL + '  CAT_VALRET, ';
  strSQL := strSQL + '  CAT_DIFORI, ';
  strSQL := strSQL + '  CAT_DIFDES, ';
  strSQL := strSQL + '  CAT_INCVEN ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CAT_158_SAIDAS ';
  strSQL := strSQL + 'WHERE CAT_MESANO = :MESANO ';
  strSQL := strSQL + '  AND CAT_CODEMP = :CODEMP ';

  with FQryDados do
  begin
    Close;
    SQL.Clear;
    SQL.Text := strSQL;
    ParamByName('MESANO').AsString := FormatDateTime('MM/YYYY', FDtaIni);
    ParamByName('CODEMP').AsString := FCodEmp;
    Open;
    First;
  end;
end;

function TReImpressaoRelRessarcimentoCat158.fReImpressao: boolean;
begin
  pCarregaClients;

  result := FExisteDadosPeriodo;
end;

end.
