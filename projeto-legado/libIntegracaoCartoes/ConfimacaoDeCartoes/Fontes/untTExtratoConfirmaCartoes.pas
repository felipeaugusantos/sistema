unit untTExtratoConfirmaCartoes;

interface

Uses Vcl.Forms,untFuncoes,untFuncoesSimples,System.SysUtils,cxProgressBar,
     untIDataset,Vcl.ComCtrls,System.Generics.Collections, untConstantes;

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
  Public
    destructor Destroy; override;
    function GravaExtratoCartoes(pgbProgresso: TcxProgressBar): Boolean;

    Property DadosVendas: TList<TDadosVendas> Read FDadosVendas Write FDadosVendas;
  End;

implementation

destructor TExtratoConfirmaCartoes.Destroy;
begin
  FreeAndNil(FDadosVendas);
  inherited;
end;

function TExtratoConfirmaCartoes.GravaExtratoCartoes(pgbProgresso: TcxProgressBar): Boolean;
  Var
    LExtMca: IDataset;
    LDadosVendas : TDadosVendas;
Begin
  Result := True;

  Try
    LExtMca := objFunctions.fGetDataSet;

    Try
      LExtMca.Close;
      LExtMca.SQL := RetornaSQLReplaceEXTMCA;

      pgbProgresso.Position := 0;
      pgbProgresso.Properties.Max := FDadosVendas.Count;

      For LDadosVendas In FDadosVendas Do
      Begin
        LExtMca.ParamByName('AUTOINCREM').Value := RetornaSequencial('EXTMCA',VS_strCodEmp);
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
        pStep(pgbProgresso);
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    LExtMca := Nil;
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

end.
