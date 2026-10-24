unit untTFatReprocessarSaldoItem;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  cxProgressBar, Vcl.Forms,
{$ENDIF}
  System.SysUtils, System.DateUtils, System.Generics.Collections, System.Classes, Uni;

type
  IItemReprocessarSaldo = interface
    ['{7B039D2E-5416-442C-BBCB-835D943F9A3A}']
    function Codigo(AValue: String): IItemReprocessarSaldo; overload;
    function Codigo(): String; overload;
    function Empresa(AValue: String): IItemReprocessarSaldo; overload;
    function Empresa(): String; overload;
    function Lote(AValue: String): IItemReprocessarSaldo; overload;
    function Lote(): String; overload;
    function EhItemEntregaFutura(AValue: Boolean): IItemReprocessarSaldo; overload;
    function EhItemEntregaFutura(): Boolean; overload;
  end;

  IItensReprocessarDoDocumento = interface
    ['{F3897E1D-7D20-4798-805D-C4FAFD609D85}']
    function ListaAutInc(AValue: String): IItensReprocessarDoDocumento; overload;
    function ListaAutInc(): String; overload;
    function ProcessarLotesDocumento(AValue: Boolean): IItensReprocessarDoDocumento; overload;
    function ProcessarLotesDocumento(): Boolean; overload;
    function Documento(AValue: String): IItensReprocessarDoDocumento; overload;
    function Documento(): String; overload;
    function Especie(AValue: String): IItensReprocessarDoDocumento; overload;
    function Especie(): String; overload;
    function Empresa(AValue: String): IItensReprocessarDoDocumento; overload;
    function Empresa(): String; overload;
    function Itens(): TList<IItemReprocessarSaldo>;
  end;

  IReprocessarSaldoItem = interface
    ['{44851FB9-C9A2-4732-98F8-F6F854FEF5F9}']
    procedure Clear;
    function AddItem(AItem: IItemReprocessarSaldo): IReprocessarSaldoItem;
    function AddItensDoDocumento(AItensDoDocumento: IItensReprocessarDoDocumento): IReprocessarSaldoItem;
    function ReprocessarSaldoPedidos(AProgresso: TcxProgressBar = nil): IReprocessarSaldoItem;
    function ReprocessarSaldoEntregaFutura(AProgresso: TcxProgressBar = nil): IReprocessarSaldoItem;
    function NotificarRoboParaReprocessarSaldos(aAguardarSegundos: Integer=0; aNotificarTodosLotes: Boolean=False; aLisNumLot: String=''; aApenasVerificar: Boolean=False): IReprocessarSaldoItem;
    function ListaProcessada: Boolean;
  end;

type
  TItemReprocessarSaldo = class(TInterfacedObject, IItemReprocessarSaldo)
  private
    FCodigo: String;
    FEmpresa: String;
    FLote: String;
    FEhItemEntregaFutura: Boolean;
  public
    class function New(): IItemReprocessarSaldo;
    function Codigo(AValue: String): IItemReprocessarSaldo; overload;
    function Codigo(): String; overload;
    function Empresa(AValue: String): IItemReprocessarSaldo; overload;
    function Empresa(): String; overload;
    function Lote(AValue: String): IItemReprocessarSaldo; overload;
    function Lote(): String; overload;
    function EhItemEntregaFutura(AValue: Boolean): IItemReprocessarSaldo; overload;
    function EhItemEntregaFutura(): Boolean; overload;
  end;

type
  TItensReprocessarDoDocumento = class(TInterfacedObject, IItensReprocessarDoDocumento)
  private
    FDocumento: String;
    FEspecie: String;
    FEmpresa: String;
    FItens: TList<IItemReprocessarSaldo>;
    FProcessarLotesDocumento: Boolean;
    FListaAutInc: String;
    procedure CarregarItens;
  protected
    constructor Create;
  public
    destructor Destroy; override;
    class function New(): IItensReprocessarDoDocumento;
    function ListaAutInc(AValue: String): IItensReprocessarDoDocumento; overload;
    function ListaAutInc(): String; overload;
    function ProcessarLotesDocumento(AValue: Boolean): IItensReprocessarDoDocumento; overload;
    function ProcessarLotesDocumento(): Boolean; overload;
    function Documento(AValue: String): IItensReprocessarDoDocumento; overload;
    function Documento(): String; overload;
    function Especie(AValue: String): IItensReprocessarDoDocumento; overload;
    function Especie(): String; overload;
    function Empresa(AValue: String): IItensReprocessarDoDocumento; overload;
    function Empresa(): String; overload;
    function Itens(): TList<IItemReprocessarSaldo>;
  end;

type
  TReprocessarSaldoItem = class(TInterfacedObject, IReprocessarSaldoItem)
  private
    FItens: TList<IItemReprocessarSaldo>;
    FListaProcessada: Boolean;
  protected
    constructor Create;
  public
    destructor Destroy; override;
    class function New(): IReprocessarSaldoItem;
    procedure Clear;
    function AddItem(AItem: IItemReprocessarSaldo): IReprocessarSaldoItem;
    function AddItensDoDocumento(AItensDoDocumento: IItensReprocessarDoDocumento): IReprocessarSaldoItem;
    function ReprocessarSaldoPedidos(AProgresso: TcxProgressBar = nil): IReprocessarSaldoItem;
    function ReprocessarSaldoEntregaFutura(AProgresso: TcxProgressBar = nil): IReprocessarSaldoItem;
    function NotificarRoboParaReprocessarSaldos(aAguardarSegundos: Integer=0; aNotificarTodosLotes: Boolean=False; aLisNumLot: String=''; aApenasVerificar: Boolean=False): IReprocessarSaldoItem;
    function ListaProcessada: Boolean;
  end;

implementation

uses
{$IFDEF LINUX}

{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untFuncoesGenerica, untTFatReservaSaldo, untTFatEntregaFutura, untConstantes,
  Shared.Functions.Monitores;

{ TItemReprocessarSaldo }

function TItemReprocessarSaldo.Codigo(AValue: String): IItemReprocessarSaldo;
begin
  Result := Self;
  FCodigo := AValue;
end;

function TItemReprocessarSaldo.Codigo: String;
begin
  Result := FCodigo;
end;

function TItemReprocessarSaldo.EhItemEntregaFutura(
  AValue: Boolean): IItemReprocessarSaldo;
begin
  Result := Self;
  FEhItemEntregaFutura := AValue;
end;

function TItemReprocessarSaldo.EhItemEntregaFutura: Boolean;
begin
  Result := FEhItemEntregaFutura;
end;

function TItemReprocessarSaldo.Empresa: String;
begin
  Result := FEmpresa;
end;

function TItemReprocessarSaldo.Lote(AValue: String): IItemReprocessarSaldo;
begin
  Result := Self;
  FLote := AValue;
end;

function TItemReprocessarSaldo.Lote: String;
begin
  Result := FLote;
end;

function TItemReprocessarSaldo.Empresa(AValue: String): IItemReprocessarSaldo;
begin
  Result := Self;
  FEmpresa := AValue;
end;

class function TItemReprocessarSaldo.New: IItemReprocessarSaldo;
begin
  Result := Self.Create;
end;

{ TReprocessarSaldoItem }

function TReprocessarSaldoItem.AddItem(
  AItem: IItemReprocessarSaldo): IReprocessarSaldoItem;
begin
  Result := Self;
  FItens.Add(AItem);
end;

function TReprocessarSaldoItem.AddItensDoDocumento(
  AItensDoDocumento: IItensReprocessarDoDocumento): IReprocessarSaldoItem;
Var
  LItem: IItemReprocessarSaldo;
begin
  Result := Self;
  For LItem In AItensDoDocumento.Itens() Do
  Begin
    Self.AddItem(
      TItemReprocessarSaldo.New
        .Codigo(LItem.Codigo())
        .Empresa(LItem.Empresa())
        .Lote(LItem.Lote())
        .EhItemEntregaFutura(LItem.EhItemEntregaFutura())
      );
  End;
end;

procedure TReprocessarSaldoItem.Clear;
begin
  FItens.Clear;
end;

constructor TReprocessarSaldoItem.Create;
begin
  FItens := TList<IItemReprocessarSaldo>.Create;
  FListaProcessada := False;
end;

destructor TReprocessarSaldoItem.Destroy;
begin
  FItens.Free;
  inherited;
end;

function TReprocessarSaldoItem.ListaProcessada: Boolean;
begin
  Result := FListaProcessada;
end;

function TReprocessarSaldoItem.ReprocessarSaldoEntregaFutura(
  AProgresso: TcxProgressBar): IReprocessarSaldoItem;
Var
  LItem: IItemReprocessarSaldo;
  LPos: Integer;
begin
  Result := Self;
  LPos := 0;
  If Assigned(AProgresso) Then
    AProgresso.Properties.Max := FItens.Count;

  For LItem In FItens Do
  Begin
    Inc(LPos);

    If Assigned(AProgresso) Then
    Begin
      AProgresso.Position := LPos;
      Application.ProcessMessages;
    End;

    TAuditoriaEF.New(
      TParamEF.New()
        .CodIte(LItem.Codigo)
        .CodEmp(LItem.Empresa)
        .Reprocesso(True)
      ).pExecute();
  End;
end;

function TReprocessarSaldoItem.ReprocessarSaldoPedidos(
  AProgresso: TcxProgressBar = nil): IReprocessarSaldoItem;
Var
  LItem: IItemReprocessarSaldo;
  LPos: Integer;
begin
  Result := Self;
  LPos := 0;
  If Assigned(AProgresso) Then
    AProgresso.Properties.Max := FItens.Count;

  For LItem In FItens Do
  Begin
    Inc(LPos);

    If Assigned(AProgresso) Then
    Begin
      AProgresso.Position := LPos;
      Application.ProcessMessages;
    End;

    If (LItem.Codigo <> '') And
       (LItem.Lote <> '') And
       (LItem.Empresa <> '') Then
    Begin
      TAuditoriaReserva.New(
        TReservaParametros.New()
          .CodigoItem(LItem.Codigo)
          .EmpresaItem(LItem.Empresa)
          .CodEmpresa(LItem.Empresa)
          .NumeroLote(LItem.Lote)
          .EhReprocesso(True)
          .TabelaAudit('CADLOT')
        ).pExecute();
    End;

    TAuditoriaReserva.New(
      TReservaParametros.New()
        .CodigoItem(LItem.Codigo)
        .EmpresaItem(LItem.Empresa)
        .CodEmpresa(LItem.Empresa)
        .EhReprocesso(True)
        .TabelaAudit('ITEGER')
      ).pExecute();
  End;
end;

class function TReprocessarSaldoItem.New: IReprocessarSaldoItem;
begin
  Result := Self.Create;
end;

function TReprocessarSaldoItem.NotificarRoboParaReprocessarSaldos(aAguardarSegundos: Integer=0; aNotificarTodosLotes: Boolean=False; aLisNumLot: String=''; aApenasVerificar: Boolean=False): IReprocessarSaldoItem;
Var
  LItem: IItemReprocessarSaldo;
  LSQL,
  LSQLIteGer,
  LSQLCadLot,
  LWhereIteGer,
  LWhereCadLot,
  LListaCodIte,
  LListaCodEmp,
  LListaNumLot: String;
  LQryAux: TUniQuery;
  dtaHorIni: TDateTime;
  LProcessado: Boolean;
  LTemEntregaFutura: Boolean;

  function fNotificaIteger: Boolean;
  begin
    Result := (LListaCodIte <> '');
  end;

  function fNotificaCadLot: Boolean;
  begin
    Result := (LListaNumLot <> '') And (LListaCodIte <> '');
  end;

  procedure pLimparTags;
  begin
    LSQLIteGer   := fLimparMarcaRepAud(LSQLIteGer);
    LWhereIteGer := fLimparMarcaRepAud(LWhereIteGer);
    LSQLCadLot   := fLimparMarcaRepAud(LSQLCadLot);
    LWhereCadLot := fLimparMarcaRepAud(LWhereCadLot);
  end;

begin
  LQryAux := fCriaQuery;
  Try
    Result := Self;

    aLisNumLot := Trim(aLisNumLot);

    LSQL := '';
    LSQLIteGer   := '';
    LSQLCadLot   := '';
    LWhereIteGer := '';
    LWhereCadLot := '';
    LListaCodIte := '';
    LListaCodEmp := '';
    LListaNumLot := fOrdenarListaParaClausulaIN(aLisNumLot);
    LTemEntregaFutura := False;
    FListaProcessada := True;

    For LItem In FItens Do
    Begin
      If (Not LTemEntregaFutura) Then
        LTemEntregaFutura := LItem.EhItemEntregaFutura();

      If (LItem.Codigo <> '') Then
        pIncrementaListaStr(LItem.Codigo,  LListaCodIte, True);

      If (LItem.Empresa <> '') Then
        pIncrementaListaStr(LItem.Empresa, LListaCodEmp, True);

      If (LItem.Lote <> '') Then
        pIncrementaListaStr(LItem.Lote,    LListaNumLot, True);

      If (aNotificarTodosLotes) Then
      Begin
        //SE FOR INFORMADO UMA LISTA ESPECÍFICA DE LOTES SÓ SERÁ NOTIFICADAS ESTAS SENÃO TODOS OS LOTES ATIVOS DO ITEM
        If (aLisNumLot = '') Then
        Begin
          LQryAux.Close;
          LQryAux.SQL.Text := ' SELECT LOT_NUMLOT   ' +
                              '   FROM CADLOT       ' +
                              '  WHERE LOT_CODEMP = :CODEMP ' +
                              '    AND LOT_CODITE = :CODITE ' +
                              '    AND ((LOT_AUTREM IS NOT NULL) OR (LOT_STATUS <> "N")) ' +
                              '  ORDER BY LOT_NUMLOT ';

          LQryAux.ParamByName('CODITE').AsString := LItem.Codigo();
          LQryAux.ParamByName('CODEMP').AsString := LItem.Empresa();
          LQryAux.Open;

          LQryAux.First;
          While Not LQryAux.Eof Do
          Begin
            pIncrementaListaStr(LQryAux.FieldByName('LOT_NUMLOT').AsString, LListaNumLot, True);

            LQryAux.Next;
          End;
        End;
      End;
    End;

    LListaCodIte := fOrdenarListaParaClausulaIN(LListaCodIte);
    LListaCodEmp := fOrdenarListaParaClausulaIN(LListaCodEmp);
    LListaNumLot := fOrdenarListaParaClausulaIN(LListaNumLot);

    If (fNotificaIteger) Then
    Begin
      LSQLIteGer :=
        ' UPDATE ITEGER '+
        '    SET ITE_REPAUD = "S" ' + IIF(LTemEntregaFutura, ' ,ITE_REPAEF = "S" ','') +
        '  WHERE TRUE ';

      LWhereIteGer := LWhereIteGer + ' AND ITE_CODITE IN ('+fMarcarListaRepAud(LListaCodIte, TAG_REPAUD_CODITE, mlraIteGer)+') ';

      If (LListaCodEmp <> '') Then
        LWhereIteGer := LWhereIteGer + ' AND ITE_CODEMP IN ('+fMarcarListaRepAud(LListaCodEmp, TAG_REPAUD_CODEMP, mlraIteGer)+') ';

      LSQLIteGer := Trim(LSQLIteGer + LWhereIteGer) + ';'
    End;

    If (fNotificaCadLot) Then
    Begin
      LSQLCadLot :=
        ' UPDATE CADLOT '+
        '    SET LOT_REPAUD = "S" '+
        '  WHERE TRUE ';

      LWhereCadLot := LWhereCadLot + ' AND LOT_NUMLOT IN ('+fMarcarListaRepAud(LListaNumLot, TAG_REPAUD_NUMLOT, mlraCadLot)+') ';
      LWhereCadLot := LWhereCadLot + ' AND LOT_CODITE IN ('+fMarcarListaRepAud(LListaCodIte, TAG_REPAUD_CODITE, mlraCadLot)+') ';

      If (LListaCodEmp <> '') Then
        LWhereCadLot := LWhereCadLot + ' AND LOT_CODEMP IN ('+fMarcarListaRepAud(LListaCodEmp, TAG_REPAUD_CODEMP, mlraCadLot)+') ';

      LSQLCadLot := Trim(LSQLCadLot + LWhereCadLot) + ';'
    End;

    If (LSQLIteGer.IsEmpty) And (LSQLCadLot.IsEmpty) Then
      Exit;

    If (Not aApenasVerificar) Then
    Begin
      If fUsouBatchReprocessarSaldo([LSQLIteGer, LSQLCadLot]) Then
      Begin
        Exit;
      End
      Else
      Begin
        pLimparTags;

        LSQLIteGer   := fNormalizeSQL(LSQLIteGer);
        LSQLCadLot   := fNormalizeSQL(LSQLCadLot);

        If (LSQLIteGer <> '') Then
          If Not fExecutaSQL(LSQLIteGer, True) Then
            Raise Exception.Create('TReprocessarSaldoItem.NotificarRoboParaReprocessarSaldos');

        If (LSQLCadLot <> '') Then
          If Not fExecutaSQL(LSQLCadLot, True) Then
            Raise Exception.Create('TReprocessarSaldoItem.NotificarRoboParaReprocessarSaldos');
      End;
    End
    Else
    Begin
      pLimparTags;
    End;

    If (aAguardarSegundos > 0) Then
    Begin
      If (fNotificaIteger Or fNotificaCadLot) Then
      Begin
        dtaHorIni := Date+Time;

        LSQL := '';
        If fNotificaIteger Then
        Begin
          LSQL := LSQL +
           ' SELECT COUNT(*) AS PROCES FROM ITEGER '+
           '  WHERE TRUE ' + LWhereIteGer           +
           '    AND '+IIF(LTemEntregaFutura, ' ((ITE_REPAUD = "S") OR (ITE_REPAEF = "S")) ', ' ITE_REPAUD = "S" ');
        End;

        If (fNotificaCadLot) Then
        Begin
          If (LSQL <> '') Then
            LSQL := LSQL + ' UNION ALL ';

          LSQL := LSQL +
            ' SELECT COUNT(*) AS PROCES FROM CADLOT '+
            '  WHERE TRUE ' + LWhereCadLot           +
            '    AND LOT_REPAUD = "S"               ';
        End;

        LQryAux.Close;
        LQryAux.SQL.Clear;
        LQryAux.SQL.Text := 'SELECT SUM(PROCES) FROM ('+LSQL+') AS VW';

        LProcessado := False;
        Repeat
          LQryAux.Open;

          FListaProcessada := LQryAux.Fields[0].AsInteger = 0;

          If (SecondsBetween(Date+Time, dtaHorIni) > aAguardarSegundos) Or (FListaProcessada) Then
            LProcessado := True;

          LQryAux.Close;

          If (Not LProcessado) Then
          Begin
            Application.ProcessMessages;

            Sleep(1000);
          End;

        Until LProcessado;
      End;
    End;
  Finally
    FreeAndNil(LQryAux)
  End;
end;

{ TItensReprocessarDoDocumento }

procedure TItensReprocessarDoDocumento.CarregarItens;
var
  LQryIte: TUniQuery;
  LQryLot: TUniQuery;
  LTabela: String;
  LIdCampo: String;
  LLote: String;
  LEmpresa: String;
  LEmpresas: TArray<String>;
  LSubItem: String;
  LSubItens: TArray<String>;
  LCampoDocFut: String;
  LCampoSeqGer: String;
  LJoinTabelaAuxiliar: String;
begin
  If FItens.Count > 0 Then Exit;
  If FDocumento.IsEmpty Then Exit;

  LQryIte := fCriaQuery();
  LQryLot := fCriaQuery();
  Try
    If (FEspecie = 'PD') Or (FEspecie = 'OR') Then
    Begin
      LTabela             := 'FATDOR';
      LIdCampo            := 'FDO_';
      LCampoDocFut        := 'CAST(NULL AS CHAR(1)) AS DOCFUT, ';
      LCampoSeqGer        := 'FATDOR.FDO_SEQGER     AS SEQGER, ';
      LJoinTabelaAuxiliar := 'INNER JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ';
    End
    Else
    Begin
      LTabela             := 'MOVDET';
      LIdCampo            := 'DET_';
      LCampoDocFut        := LIdCampo+'DOCFUT   AS DOCFUT, ';
      LCampoSeqGer        := 'MOVDET.DET_SEQGER AS SEQGER, ';
      LJoinTabelaAuxiliar := 'INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
    End;

    LQryIte.SQL.Clear;
    LQryIte.SQL.Add('SELECT');
    LQryIte.SQL.Add('  ' + LTabela  + '.AUTOINCREM AS AUTINC, ');
    LQryIte.SQL.Add('  ' + LCampoSeqGer);
    LQryIte.SQL.Add('  ' + LIdCampo + 'CODITE AS CODITE, ');
    LQryIte.SQL.Add('  ' + LIdCampo + 'CODEMP AS CODEMP, ');
    LQryIte.SQL.Add('  ' + LIdCampo + 'ENTFUT AS ENTFUT, ');
    LQryIte.SQL.Add('  ' + LIdCampo + 'CLAFIS AS CLAFIS, ');
    LQryIte.SQL.Add('  ' + LCampoDocFut);
    LQryIte.SQL.Add('  ' + LIdCampo + 'INCFUT AS INCFUT  ');
    LQryIte.SQL.Add('FROM');
    LQryIte.SQL.Add('  ' + LTabela + ' ');
    LQryIte.SQL.Add('  ' + LJoinTabelaAuxiliar);
    LQryIte.SQL.Add('WHERE');
    LQryIte.SQL.Add('  ' + LIdCampo + 'NUMDOC = :NUMDOC AND');
    LQryIte.SQL.Add('  ' + LIdCampo + 'ESPDOC = :ESPDOC AND');
    LQryIte.SQL.Add('  ' + LIdCampo + 'CODEMP = :CODEMP');
    LQryIte.SQL.Add('ORDER BY CODITE, CODEMP ');

    LQryIte.ParamByName('NUMDOC').AsString := FDocumento;
    LQryIte.ParamByName('ESPDOC').AsString := FEspecie;
    LQryIte.ParamByName('CODEMP').AsString := FEmpresa;
    LQryIte.Open;
    LQryIte.First;

    If LTabela = 'FATDOR' Then
      LEmpresas := untFuncoesGenerica.fGetEmpresasReprocessarPedido(LQryIte.FieldByName('SEQGER').AsString);

    If FProcessarLotesDocumento Then
    Begin
      LQryLot.Close;
      If LTabela = 'FATDOR' Then
      Begin
        LQryLot.SQL.Text :=
          ' SELECT D.AUTOINCREM AS AUTINC, ' +
          '        D.FDO_NUMLOT AS NUMLOT, ' +
          '        L.LDO_NUMLOT AS LDOLOT, ' +
          '        D.FDO_CODITE AS CODITE  ' +
          '   FROM FATDOR D                ' +
          '      LEFT JOIN LOTDOR L ON L.LDO_SEQFDO = D.AUTOINCREM '+
          '  WHERE D.FDO_SEQGER = :SEQGER  ' +
          '  ORDER BY D.FDO_CODITE, D.FDO_NUMLOT, L.LDO_NUMLOT ';
      End
      Else
      Begin
        LQryLot.SQL.Text :=
          ' SELECT D.AUTOINCREM AS AUTINC, ' +
          '        D.DET_NUMLOT AS NUMLOT, ' +
          '        D.DET_CODITE AS CODITE, ' +
          '        D.DET_CODEMP AS CODEMP  ' +
          '   FROM MOVDET D                ' +
          '  WHERE D.DET_SEQGER = :SEQGER  ' +
          '  ORDER BY D.DET_CODITE, D.DET_NUMLOT ';
      End;
      LQryLot.Close;
      LQryLot.ParamByName('SEQGER').AsString := LQryIte.FieldByName('SEQGER').AsString;
      LQryLot.Open;
      LQryLot.First;

      While Not LQryLot.Eof Do
      Begin
        If (FListaAutInc <> '') Then
        Begin
          If Pos(LQryLot.FieldByName('AUTINC').AsString, FListaAutInc) = 0 Then
          Begin
            LQryLot.Next;
            Continue;
          End;
        End;

        If LTabela = 'FATDOR' Then
        Begin
          For LEmpresa In LEmpresas Do
          Begin
            LLote := LQryLot.FieldByName('NUMLOT').AsString;
            If (LLote <> '') Then
            Begin
              FItens.Add(
                TItemReprocessarSaldo.New
                  .Codigo(LQryLot.FieldByName('CODITE').AsString)
                  .Empresa(LEmpresa)
                  .Lote(LLote));
            End;

            LLote := LQryLot.FieldByName('LDOLOT').AsString;
            If (LLote <> '') Then
            Begin
              FItens.Add(
                TItemReprocessarSaldo.New
                  .Codigo(LQryLot.FieldByName('CODITE').AsString)
                  .Empresa(LEmpresa)
                  .Lote(LLote));
            End;
          End;
        End
        Else
        Begin
          LLote := LQryLot.FieldByName('NUMLOT').AsString;
          If (LLote <> '') Then
          Begin
            FItens.Add(
              TItemReprocessarSaldo.New
                .Codigo(LQryLot.FieldByName('CODITE').AsString)
                .Empresa(LQryLot.FieldByName('CODEMP').AsString)
                .Lote(LLote));
          End;
        End;

        LQryLot.Next;
      End;
    End;

    While Not LQryIte.Eof Do
    Begin
      If (FListaAutInc <> '') Then
      Begin
        If Pos(LQryIte.FieldByName('AUTINC').AsString, FListaAutInc) = 0 Then
        Begin
          LQryIte.Next;
          Continue;
        End;
      End;

      If LTabela = 'FATDOR' Then //Empresa da reserva de estoque do pedido
      Begin
        For LEmpresa In LEmpresas Do
        Begin
          FItens.Add(
            TItemReprocessarSaldo.New
              .Codigo(LQryIte.FieldByName('CODITE').AsString)
              .Empresa(LEmpresa)
              .EhItemEntregaFutura(fReprocessarSaldoReservadoEntregaFutura(
                                     LQryIte.FieldByName('ENTFUT').AsString,
                                     LQryIte.FieldByName('CLAFIS').AsString,
                                     LQryIte.FieldByName('INCFUT').AsString,
                                     LQryIte.FieldByName('DOCFUT').AsString))
            );

          If (fCfgSis('BXSBIT') = '2') And (fCfgSis('EMOPPD') = 'N') Then
          Begin
            LSubItens := fGetSubItensEstrutura(LQryIte.FieldByName('CODITE').AsString);
            For LSubItem In LSubItens Do
              FItens.Add(
                TItemReprocessarSaldo.New
                  .Codigo(LSubItem)
                  .Empresa(LEmpresa)
                );
          End;
        End;
      End
      Else
      Begin
        FItens.Add(
          TItemReprocessarSaldo.New
            .Codigo(LQryIte.FieldByName('CODITE').AsString)
            .Empresa(LQryIte.FieldByName('CODEMP').AsString)
            .EhItemEntregaFutura(fReprocessarSaldoReservadoEntregaFutura(
                                   LQryIte.FieldByName('ENTFUT').AsString,
                                   LQryIte.FieldByName('CLAFIS').AsString,
                                   LQryIte.FieldByName('INCFUT').AsString,
                                   LQryIte.FieldByName('DOCFUT').AsString))
          );
      End;

      LQryIte.Next;
    End;

  Finally
    If Assigned(LQryIte) Then
      FreeAndNil(LQryIte);

    If Assigned(LQryLot) Then
      FreeAndNil(LQryLot);
  End;
end;

constructor TItensReprocessarDoDocumento.Create;
begin
  FItens := TList<IItemReprocessarSaldo>.Create;
  FProcessarLotesDocumento := False;
  FListaAutInc := '';
end;

destructor TItensReprocessarDoDocumento.Destroy;
begin
  FItens.Free;
  inherited;
end;

function TItensReprocessarDoDocumento.Documento: String;
begin
  Result := FDocumento;
end;

function TItensReprocessarDoDocumento.Documento(
  AValue: String): IItensReprocessarDoDocumento;
begin
  Result := Self;
  FDocumento := AValue;
end;

function TItensReprocessarDoDocumento.Empresa: String;
begin
  Result := FEmpresa;
end;

function TItensReprocessarDoDocumento.Empresa(
  AValue: String): IItensReprocessarDoDocumento;
begin
  Result := Self;
  FEmpresa := AValue;
end;

function TItensReprocessarDoDocumento.Especie(
  AValue: String): IItensReprocessarDoDocumento;
begin
  Result := Self;
  FEspecie := AValue;
end;

function TItensReprocessarDoDocumento.Especie: String;
begin
  Result := FEspecie;
end;

function TItensReprocessarDoDocumento.Itens: TList<IItemReprocessarSaldo>;
begin
  CarregarItens;
  Result := FItens;
end;

function TItensReprocessarDoDocumento.ListaAutInc(
  AValue: String): IItensReprocessarDoDocumento;
begin
  Result := Self;
  FListaAutInc := AValue;
end;

function TItensReprocessarDoDocumento.ListaAutInc: String;
begin
  Result := FListaAutInc;
end;

class function TItensReprocessarDoDocumento.New: IItensReprocessarDoDocumento;
begin
  Result := Self.Create;
end;

function TItensReprocessarDoDocumento.ProcessarLotesDocumento(
  AValue: Boolean): IItensReprocessarDoDocumento;
begin
  Result := Self;
  FProcessarLotesDocumento := AValue;
end;

function TItensReprocessarDoDocumento.ProcessarLotesDocumento: Boolean;
begin
  Result := FProcessarLotesDocumento;
end;

end.
