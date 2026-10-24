unit untLegendasItem;

interface

Uses Classes, cxStyles, cxGrid, cxGridDBBandedTableView, Graphics, untZClient;

Type
  TSituacaoItem = (sitInativo, sitInativoCompra, sitEstrutura, sitBocaCaixa,
                   sitPromocao, sitCombo, sitAgregado);

Const
  clOrange = 5275647;

  ARRCOR_SITUACAO_ITEM : Array[sitInativo..sitAgregado] Of Integer =
           (clRed,
            clOrange,
            clPurple,
            clTeal,
            clGreen,
            clAqua,
            clYellow);

  ARRDESC_SITUACAO_ITEM : Array[sitInativo..sitAgregado] Of String =
           ('ITEM INATIVO',
            'ITEM INATIVO PARA COMPRA',
            'ITEM ESTRUTURA',
            'ITEM BOCA DE CAIXA',
            'ITEM EM PROMOÇÃO',
            'ITEM COMBO',
            'ITEM AGREGADO');


Type
  TLegenda = Record
    objStyle : TcxStyle;
    strDescri: String;
  End;


  TLegendasItem = Class(TZClient)
    Private
      arrLegenda    : Array Of TLegenda;

    Public

      Function fRetStyle(strDescri: String): TcxStyle;

      constructor Create(Owner: TComponent; blnSomenteSitPro: Boolean = False); Reintroduce;

      Destructor Destroy; override;

      Function fAbreClient(blnSetProvider: Boolean = False; strNomFunc: String = ''; blnRefresh: Boolean = False;
                           blnExibirProgresso : Boolean = False): Boolean; Override;

  End;

implementation

uses untFuncoesSimples;


constructor TLegendasItem.Create(Owner: TComponent; blnSomenteSitPro: Boolean = False);
Begin
  Inherited Create(Owner, ' SELECT SIT_CODIGO, SIT_DESCRI, SIT_CORSIT, "SITPRO" AS TABELA ' +
                          ' FROM SITPRO WHERE ' + IIF(fCfgSis('SITPRO', varBoolean), ' TRUE', ' FALSE') +
                          IIF(Not blnSomenteSitPro,' UNION ALL SELECT "", SIT_SITUAC, SIT_CODCOR, "SITITE" FROM SITITE ', ''));

  fAbreClient;

  IndexFieldNames := 'SIT_CODIGO';

End;

function TLegendasItem.fAbreClient(blnSetProvider: Boolean; strNomFunc: String;
  blnRefresh: Boolean; blnExibirProgresso : Boolean): Boolean;
begin
  Result := Inherited fAbreClient(blnSetProvider, strNomFunc, blnRefresh, blnExibirProgresso);

  If Not Result Then
    Exit;

  //Sempre aque atualizar o ClientDataSet Recarrega o Array, para atualizar a pesquisa na hora.
  First;
  SetLength(arrLegenda, RecordCount);
  While Not Eof Do
  Begin
    arrLegenda[Pred(RecNo)].objStyle := TcxStyle.Create(Self);
    arrLegenda[Pred(RecNo)].objStyle.TextColor := FieldByName('SIT_CORSIT').AsInteger;
    arrLegenda[Pred(RecNo)].strDescri := FieldByName('SIT_DESCRI').AsString;
    Next;
  End;
  First;

end;

Function TLegendasItem.fRetStyle(strDescri: String): TcxStyle;
  Var
    intContador: Integer;
Begin
  Result := nil;

  For intContador := Low(arrLegenda) To High(arrLegenda) Do
    If arrLegenda[intContador].strDescri = strDescri Then
    Begin
      Result := arrLegenda[intContador].objStyle;
      Break;
    End;
End;

Destructor TLegendasItem.Destroy;
Begin
  Inherited;

  SetLength(arrLegenda, 0);
End;

end.
