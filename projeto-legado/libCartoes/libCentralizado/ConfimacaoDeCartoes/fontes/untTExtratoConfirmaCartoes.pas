unit untTExtratoConfirmaCartoes;

interface

Uses Vcl.Forms, System.SysUtils, Vcl.ComCtrls,System.Generics.Collections,

     cxProgressBar, Uni,

     untTLibCartoesFuncoes, untLibCartoesConstantes;

Type
  TPeriodoImportacao = Record
    DataInicial: TDateTime;
    DataFinal: TDateTime;
    ImportouVendas: Boolean;
  End;

Type
  TDadosVendas = Record
    Estabelecimento,
    Autorizacao,
    Nsu,
    Parcela,
    Cartao,
    Bandeira,
    Status,
    Operador,
    NomeOperadora: String;

    DataTransacao,
    DataVencimento,
    DataImportacao: TDateTime;

    ValorBruto,
    ValorTaxa,
    ValorLiquido: Double;
  End;

Type
  TExtratoConfirmaCartoes = Class
  Private
    FDadosVendas: TList<TDadosVendas>;
    function RetornaSQLReplaceEXTMCA:String;

    procedure SetDadosVendas(AValor: TList<TDadosVendas>);
  Public
    constructor Create;
    destructor Destroy; override;
    function GravaExtratoCartoes(pgbProgresso: TcxProgressBar): Boolean;

    Property DadosVendas: TList<TDadosVendas> Read FDadosVendas Write SetDadosVendas;
  End;

implementation

constructor TExtratoConfirmaCartoes.Create;
begin
  FDadosVendas := Nil;
end;

destructor TExtratoConfirmaCartoes.Destroy;
begin
  If Assigned(FDadosVendas) Then
  Begin
    FDadosVendas.Clear;
    FreeAndNil(FDadosVendas);
  End;

  inherited;
end;

function TExtratoConfirmaCartoes.GravaExtratoCartoes(pgbProgresso: TcxProgressBar): Boolean;
  Var
    LExtMca: TUniQuery;
    LDadosVendas : TDadosVendas;
Begin
  Result := True;

  LExtMca := VS_FuncoesExternas.fICriaQuery;
  Try
    Try
      LExtMca.Close;
      LExtMca.SQL.Text := RetornaSQLReplaceEXTMCA;

      pgbProgresso.Position := 0;
      pgbProgresso.Properties.Max := FDadosVendas.Count;

      For LDadosVendas In FDadosVendas Do
      Begin
        LExtMca.ParamByName('AUTOINCREM').Value := VS_FuncoesExternas.fIRetAutoIncrem('EXTMCA', VS_FuncoesExternas.fIRetEmpresaLogada);
        LExtMca.ParamByName('EXT_NUM_PV').Value := LDadosVendas.Estabelecimento;
        LExtMca.ParamByName('EXT_CODAUT').Value := LDadosVendas.Autorizacao;
        LExtMca.ParamByName('EXT_NUMNSU').Value := LDadosVendas.Nsu;
        LExtMca.ParamByName('EXT_PARCEL').Value := LDadosVendas.Parcela;
        LExtMca.ParamByName('EXT_DTACUP').Value := LDadosVendas.DataTransacao;
        LExtMca.ParamByName('EXT_DTAVEN').Value := LDadosVendas.DataVencimento;
        LExtMca.ParamByName('EXT_VALBRU').Value := LDadosVendas.ValorBruto;
        LExtMca.ParamByName('EXT_VALTAX').Value := LDadosVendas.ValorTaxa;
        LExtMca.ParamByName('EXT_VALLIQ').Value := LDadosVendas.ValorLiquido;
        LExtMca.ParamByName('EXT_NUMCAR').Value := LDadosVendas.Cartao;
        LExtMca.ParamByName('EXT_NOMBAN').Value := LDadosVendas.Bandeira;
        LExtMca.ParamByName('EXT_STATUS').Value := LDadosVendas.Status;
        LExtMca.ParamByName('EXT_OPEIMP').Value := LDadosVendas.Operador;
        LExtMca.ParamByName('EXT_DTAIMP').Value := LDadosVendas.DataImportacao;
        LExtMca.ParamByName('EXT_NOMCON').Value := LDadosVendas.NomeOperadora;

        LExtMca.ExecSQL;
        TLibCartoesFuncoes.pStepStatusGravacao(pgbProgresso);
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LExtMca);
  End;
End;

function TExtratoConfirmaCartoes.RetornaSQLReplaceEXTMCA:String;
begin
  Result := 'REPLACE INTO EXTMCA (  '+
            '  AUTOINCREM,        '+
            '  EXT_NUM_PV,        '+
            '  EXT_CODAUT,        '+
            '  EXT_NUMNSU,        '+
            '  EXT_PARCEL,        '+
            '  EXT_DTACUP,        '+
            '  EXT_DTAVEN,        '+
            '  EXT_VALBRU,        '+
            '  EXT_VALTAX,        '+
            '  EXT_VALLIQ,        '+
            '  EXT_NUMCAR,        '+
            '  EXT_NOMBAN,        '+
            '  EXT_STATUS,        '+
            '  EXT_OPEIMP,        '+
            '  EXT_DTAIMP,        '+
            '  EXT_NOMCON         '+
            ')       '+
            'VALUES  '+
            '  (     '+
            '    :AUTOINCREM,        '+
            '    :EXT_NUM_PV,        '+
            '    :EXT_CODAUT,        '+
            '    :EXT_NUMNSU,        '+
            '    :EXT_PARCEL,        '+
            '    :EXT_DTACUP,        '+
            '    :EXT_DTAVEN,        '+
            '    :EXT_VALBRU,        '+
            '    :EXT_VALTAX,        '+
            '    :EXT_VALLIQ,        '+
            '    :EXT_NUMCAR,        '+
            '    :EXT_NOMBAN,        '+
            '    :EXT_STATUS,        '+
            '    :EXT_OPEIMP,        '+
            '    :EXT_DTAIMP,        '+
            '    :EXT_NOMCON         '+
            '  ) ';
end;

procedure TExtratoConfirmaCartoes.SetDadosVendas(AValor: TList<TDadosVendas>);
  Var
    LContador: Integer;
begin
  If Assigned(FDadosVendas) Then
    FreeAndNil(FDadosVendas);

  If Not Assigned(AValor) Then
    Exit;

  FDadosVendas := TList<TDadosVendas>.Create;

  If AValor.Count = 0 Then
    Exit;

  For LContador := 0 To AValor.Count - 1 Do
    FDadosVendas.Add(AValor[LContador]);
end;

end.
