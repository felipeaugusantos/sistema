unit untCadCotComparativo;

interface

uses
  Windows, Classes, Controls, Forms, untPaiOrdena, DB, UniClientDataSet,
  UniDataSetProvider, Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, untFuncoesSimples,
  untCadCotacaoGeral, ComCtrls, untExcel, untGeraExcel, CheckLst,
  BitBtnLockedIncrem, MemDS, DBAccess, Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, cxProgressBar;

type
  TRecObserv = Record
    blnEndLoj,
    blnDesmen: Boolean;
    strNomEmp,
    strEndere,
    strCidade,
    strCodTra,
    strObs001,
    strObs002,
    strObs003,
    strTipFre,
    strObsPd1,
    strObsPd2,
    strObsPd3,
    strPedVen,
    strAtenca,
    strCodEve,
    strCodCta: String;
    fltValFre,
    fltDesAce: Double;
  End;

  TfrmCadCotComparativo = class(TfrmPaiOrdena)
    Shape1: TShape;
    Label1: TLabel;
    Shape2: TShape;
    Label2: TLabel;
    Label3: TLabel;
    edtTotGer: TEditFocus;
    pgbProgresso: TProgressBar;
    Label4: TLabel;
    lblForUti: TLabel;
    lsvForUti: TCheckListBox;
    btnMarPre: TBitBtnLocked;
    btnGerPed: TBitBtnLocked;
    btnSelMen: TBitBtnLocked;
    btnExpExcel: TBitBtnLocked;
    btnSimilares: TBitBtnLocked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarPreClick(Sender: TObject);
    procedure btnGerPedClick(Sender: TObject);
    procedure btnSelMenClick(Sender: TObject);
    procedure btnExpExcelClick(Sender: TObject);
    procedure lsvForUtiClickCheck(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSimilaresClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);

  private
    { Private declarations }
    FListaItens: TStringList;

    dicPrecoMenor: TDicionario;
    dicTotForSel: TDicionario;
    dicTotForGer: TDicionario;

    cdsItensFornecInterno: TUniClientDataSet;
    cdsFornecedoresInterno: TUniClientDataSet;

    Function fMarcaStatus(Var cdsItens: TUniClientDataSet; strCodFor, strCodIte: String; blnStatus: Boolean = TRUE): Boolean;
    Function fIncluiCampos: Boolean;
    Function fTemItemCotado: Boolean;
    Function fPedeTransportadora: Boolean;

    Procedure pIncluiRegistros(blnVerStatus: Boolean = True);
    Procedure pMarcaPreco(Column: TColumn; strCodIte: String);
    Procedure pInsereTotalFornecedores(blnGeral: Boolean);
    Procedure pMarcaEscolhidos;
    procedure pDestroyCdsInternos;
    procedure pCriaClientItensFornecInterno;

    function fGetTotal(strCodFor: String; blnSomSelec: Boolean): Double;
    procedure pAtualizaTotais(blnSomTotSel: Boolean = False);
    procedure pExcelImprimeFiltros(Excel: TExcel; Dados: TDataSet;
      Campos: TCampos; Filtros: array of String);
    procedure pExportarExcel;
    function fRetAplicacao : string;
    function fRetMarca: string;
    function fRetSemelhantes: string;

    procedure pSomaTotais(var Totais: TTotais; Dados: TDataSet);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pImprimeDetalhes(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
    procedure pListaFornecedores;
    procedure pUtilizaFornecedor(var cdsForn: TUniClientDataSet; strCodFor: String;
      blnUtiliza: Boolean);
    procedure pFimGeracao(Excel: TExcel; Campos: TCampos);
    procedure pInicializaDados;

    function fMostraPedidosPendentes(pgbProgresso: TcxProgressBar): Boolean;
    Procedure pMostraPedidosPendentes;

  public
    { Public declarations }
    recObserv: TRecObserv;

    frmCadCotacaoGeral: TfrmCadCotacaoGeral;

    cdsItens,
    cdsFornecedores,
    cdsItensFornec: TUniClientDataSet;

    dicPrecoEscol: TDicionario;

    procedure pAbreConsulta(blnAtuPre: Boolean = False);
    procedure pDesabilitaAlteracao;

    Procedure pGeraComparativo(blnVerStatus: Boolean = True;
                               blnAtuPre: Boolean = False);

  protected
    function fGetFilter: String;  Override;
    procedure pMascaraValor; override;
  end;

var
  frmCadCotComparativo: TfrmCadCotComparativo;

implementation

uses SysUtils, StrUtils, Variants, Graphics, Math, untDigObservacoes,
     untConstantes, untCadCotAtuPrecos, untFatMostraProdSimilar,
     untGravando, untCadCotItensFornec,  untConsItensAbertosPC, untCadCotItens,
     untPedOrdenacao;

{$R *.dfm}

Const
  ITEM_TOTAL       = 'ZZZZA'; // Item de Total
  ITEM_TOTAL_GERAL = 'ZZZZZ'; // Item de Total Geral do Fornecedor
  COLFORINI        = 13;      // Coluna Inicial dos fornecedores

procedure TfrmCadCotComparativo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  Action := caNone;

end;

procedure TfrmCadCotComparativo.FormCreate(Sender: TObject);
begin
  inherited;
  pInicializaDados;

  FListaItens := TStringList.Create;
end;

procedure TfrmCadCotComparativo.pInicializaDados;
Begin
  pLimpaEventoEdits;
  blnTemSelecao := FALSE;

  dicPrecoMenor := TDicionario.Create;
  dicPrecoEscol := TDicionario.Create;
  dicTotForSel  := TDicionario.Create;
  dicTotForGer  := TDicionario.Create;
End;

procedure TfrmCadCotComparativo.pDestroyCdsInternos;
begin
  If Assigned(cdsItensFornecInterno) Then
    FreeAndNil(cdsItensFornecInterno);

  If Assigned(cdsFornecedoresInterno) Then
    FreeAndNil(cdsFornecedoresInterno);
end;

procedure TfrmCadCotComparativo.pAbreConsulta(blnAtuPre: Boolean = False);
  var
    blnFiltro: Boolean;
Begin
  blnSempreRelerBanco := FALSE;

  dbgConsulta.Visible := TRUE;
  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := 'CODITE';
  lflLastField.strNomCol := 'Cód.Item';
  lflLastField.ftyTipCam := ftString;

  pDestroyCdsInternos;

  blnFiltro := cdsItensFornec.Filtered;

  cdsItensFornec.Filtered := False;

  pCriaClientItensFornecInterno;

  If blnFiltro Then
    cdsItensFornec.Filtered := True;

  blnFiltro := cdsFornecedores.Filtered;

  cdsFornecedores.Filtered := False;

  cdsFornecedoresInterno := fCriaClientDatset(cdsFornecedores);

  If blnFiltro Then
    cdsFornecedores.Filtered := True;

  pListaFornecedores;    

  pGeraComparativo(True, blnAtuPre);
End;

Function TfrmCadCotComparativo.fIncluiCampos: Boolean;
Begin
  Try
    With cdsConsulta, FieldDefs Do
    Begin
      If Active Then
      Begin
        EmptyDataSet;
        Close;
      End;

      Clear;

      dbgConsulta.Columns.Clear;

      With AddFieldDef Do
      Begin
        Name     := 'CODITE';
        DataType := ftString;
        Size     := 5;
      End;

      dbgConsulta.Columns.Add;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Title.Caption := 'Cód.Item';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].FieldName     := 'CODITE';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Width         := 53;

      With AddFieldDef Do
      Begin
        Name     := 'CODFAB';
        DataType := ftString;
        Size     := 25;
      End;

      dbgConsulta.Columns.Add;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Title.Caption := 'Cód.Fábrica';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].FieldName     := 'CODFAB';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Width         := 135;

      With AddFieldDef Do
      Begin
        Name     := 'CODSIM';
        DataType := ftString;
        Size     := 25;
      End;

      dbgConsulta.Columns.Add;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Title.Caption := 'Cód.Sililar';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].FieldName     := 'CODSIM';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Width         := 60;

      With AddFieldDef Do
      Begin
        Name     := 'DESMAR';
        DataType := ftString;
        Size     := 30;
      End;

      dbgConsulta.Columns.Add;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Title.Caption := 'Marca';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].FieldName     := 'DESMAR';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Width         := 80;


      With AddFieldDef Do
      Begin
        Name     := 'DESITE';
        DataType := ftString;
        Size     := 70;
      End;

      dbgConsulta.Columns.Add;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Title.Caption := 'Descrição';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].FieldName     := 'DESITE';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Width         := 300;

      With AddFieldDef Do
      Begin
        Name     := 'REFERE';
        DataType := ftString;
        Size     := 16;
      End;

      dbgConsulta.Columns.Add;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Title.Caption := 'Referência';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].FieldName     := 'REFERE';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Width         := 80;

      With AddFieldDef Do
      Begin
        Name     := 'SIGUNI';
        DataType := ftString;
        Size     := 4;
      End;

      dbgConsulta.Columns.Add;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Title.Caption := 'Unidade';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].FieldName     := 'SIGUNI';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Width         := 45;

      With AddFieldDef Do
      Begin
        Name := 'QTDITE';
        DataType := ftFloat;
      End;

      dbgConsulta.Columns.Add;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Title.Caption   := 'Quantidade';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Title.Alignment := taRightJustify;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].FieldName       := 'QTDITE';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Alignment       := taRightJustify;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Width           := 100;

      With AddFieldDef Do
      Begin
        Name     := 'DTAULT';
        DataType := ftDate;
      End;

      dbgConsulta.Columns.Add;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Title.Caption := 'Data Ult.Com.';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].FieldName     := 'DTAULT';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Width         := 70;

      With AddFieldDef Do
      Begin
        Name     := 'FORULT';
        DataType := ftString;
        Size     := 20;
      End;

      dbgConsulta.Columns.Add;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Title.Caption := 'Forn.Ult.Com.';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].FieldName     := 'FORULT';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Width         := 150;

      With AddFieldDef Do
      Begin
        Name     := 'PREULT';
        DataType := ftFloat;
      End;

      dbgConsulta.Columns.Add;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Title.Caption   := 'Unit.Ult.Com.';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Title.Alignment := taRightJustify;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].FieldName       := 'PREULT';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Width           := 75;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Alignment       := taRightJustify;

      With AddFieldDef Do
      Begin
        Name     := 'PRECUS';
        DataType := ftFloat;
      End;

      dbgConsulta.Columns.Add;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Title.Caption   := 'Preço Custo';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Title.Alignment := taRightJustify;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].FieldName       := 'PRECUS';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Width           := 75;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Alignment       := taRightJustify;


      With AddFieldDef Do
      Begin
        Name     := 'DIFCUS';
        DataType := ftFloat;
      End;

      dbgConsulta.Columns.Add;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Title.Caption   := 'Difer.Custo %';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Title.Alignment := taRightJustify;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].FieldName       := 'DIFCUS';
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Width           := 75;
      dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Alignment       := taRightJustify;


      cdsFornecedoresInterno.Filtered := False;
      cdsFornecedoresInterno.IndexFieldNames := 'NOMFOR';

      cdsFornecedoresInterno.First;

      While Not cdsFornecedoresInterno.Eof Do
      Begin

        With AddFieldDef Do
        Begin
          Name        := 'C' + cdsFornecedoresInterno.FieldByName('CODFOR').AsString;
          DataType    := ftFloat;
        End;

        dbgConsulta.Columns.Add;
        dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Title.Caption   := cdsFornecedoresInterno.FieldByName('NOMFOR').AsString;;
        dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].FieldName       := 'C' + cdsFornecedoresInterno.FieldByName('CODFOR').AsString;
        dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Alignment       := taRightJustify;
        dbgConsulta.Columns[dbgConsulta.Columns.Count - 1].Width           := 100;

        cdsFornecedoresInterno.Next;
      End;


      CreateDataSet;
      Open;

      pMascaraValor;
    End;

    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fIncluiCampos]');
    End;
  End;
    
End;

Procedure TfrmCadCotComparativo.pInsereTotalFornecedores(blnGeral: Boolean);
  Var
    IntIndice: Integer;
Begin
  With cdsConsulta Do
  Begin
   
    Tag := 1;
    Insert;

    For intIndice := 0 To Fields.Count - 1 Do
      Case Fields[IntIndice].DataType Of
       ftString: If blnGeral Then
                    Fields[IntIndice].AsString := ITEM_TOTAL_GERAL
                  Else
                    Fields[IntIndice].AsString := ITEM_TOTAL;

        ftFloat : If blnGeral Then
                    Fields[IntIndice].AsFloat  := MaxDouble
                  Else
                    Fields[IntIndice].AsFloat  := MaxDouble - 1;
      End;

    Post;
    Tag := 0;

  End;
End;

Procedure TfrmCadCotComparativo.pMarcaEscolhidos;
Begin
  With cdsConsulta Do
  Begin
  
    Try
      pgbProgresso.Visible := True;
      pgbProgresso.Max     := RecordCount;

      DisableControls;
      First;
      While Not Eof Do
      Begin

        If (FieldByName('CODITE').AsString <> ITEM_TOTAL) Then
        Begin
           If (dicPrecoEscol[FieldByName('CODITE').AsString] <> null) And
              (dicPrecoEscol[FieldByName('CODITE').AsString] <> '') Then
           Begin
             fMarcaStatus(cdsItensFornec,
                          dicPrecoEscol[FieldByName('CODITE').AsString],
                          FieldByName('CODITE').AsString, TRUE);

             fMarcaStatus(cdsItensFornecInterno,
                          dicPrecoEscol[FieldByName('CODITE').AsString],
                          FieldByName('CODITE').AsString, TRUE);
           End
           Else
             dicPrecoEscol[FieldByName('CODITE').AsString] := '';
        End;

        pgbProgresso.Position := RecNo;

        If RecNo Mod 5 = 0 Then
          Application.ProcessMessages;

        Next;
      End;

      EnableControls;

      pgbProgresso.Visible := False;

    Except
      On E: Exception Do
      Begin
        EnableControls;
        pMensagensErro(E.Message, '');
      end;
    End;
    
  End;

End;

Procedure TfrmCadCotComparativo.pIncluiRegistros(blnVerStatus: Boolean = True);
  Var
    strIteAnt,
    strCodFor: String;
    fltTotMen: Double;
    blnPreEsc: Boolean;
    strIndex: String;

    procedure pPost;
    Begin
      {****************************************************}
      {* MARCA O FORNECEDOR COM MENOR PRECO COMO ESCOLHIDO*}
      {*************************************************JC*}
      If IfNull(dicPrecoEscol[strIteAnt], '') = ''  Then
        dicPrecoEscol[strIteAnt] := dicPrecoMenor[strIteAnt];

      cdsConsulta.Post;
    End;

Begin
  Try
    cdsFornecedoresInterno.First;

    While Not cdsFornecedoresInterno.Eof Do
    Begin
      dicTotForSel[cdsFornecedoresInterno.FieldByName('CODFOR').AsString] := 0;
      dicTotForGer[cdsFornecedoresInterno.FieldByName('CODFOR').AsString] := 0;
      cdsFornecedoresInterno.Next;
    End;

    cdsFornecedores.First;

    If cdsFornecedoresInterno.RecordCount = 0 Then
    Begin
      edtTotGer.Text := '0,00';
      dbgConsulta.Visible := FALSE;
      Exit;
    End;

    cdsConsulta.Tag := 1;
    With cdsConsulta Do
    Begin
      DisableControls;
      strIndex := IndexFieldNames;

      If fEmptyStr(strIndex) Then
        strIndex := 'CODITE';

      IndexFieldNames := '';

      dicPrecoMenor.Limpar;
      dicPrecoEscol.Limpar;

      strIteAnt := '';
      strCodFor := '';
      fltTotMen := 0.0;
      cdsItensFornecInterno.Filtered := FALSE;
      cdsItensFornecInterno.IndexFieldNames := 'CODITE;NOMFOR';
      cdsItensFornecInterno.First;

      blnPreEsc := FALSE;

      While Not cdsItensFornecInterno.Eof Do
      Begin
        strCodFor := cdsItensFornecInterno.FieldByName('CODFOR').AsString;

        cdsFornecedoresInterno.Locate('CODFOR', strCodFor, []);

        If strIteAnt <> cdsItensFornecInterno.FieldByName('CODITE').AsString Then
        Begin
          If State = dsInsert Then
            pPost;

          strIteAnt := cdsItensFornecInterno.FieldByName('CODITE').AsString;

          dicPrecoMenor[strIteAnt] := '';
          dicPrecoEscol[strIteAnt] := '';

          fltTotMen := MaxDouble;

          blnPreEsc := FALSE;
          Insert;

          FieldByName('CODITE').AsString := cdsItensFornecInterno.FieldByName('CODITE').AsString;
          FieldByName('CODFAB').AsString := cdsItensFornecInterno.FieldByName('CODFAB').AsString;
          FieldByName('CODSIM').AsString := cdsItensFornecInterno.FieldByName('CODSIM').AsString;
          FieldByName('DESMAR').AsString := cdsItensFornecInterno.FieldByName('DESMAR').AsString;
          FieldByName('DESITE').AsString := cdsItensFornecInterno.FieldByName('DESITE').AsString;
          FieldByName('REFERE').AsString := cdsItensFornecInterno.FieldByName('REFERE').AsString;
          FieldByName('SIGUNI').AsString := cdsItensFornecInterno.FieldByName('SIGUNI').AsString;
          FieldByName('QTDITE').AsFloat  := cdsItensFornecInterno.FieldByName('QTDITE').AsFloat;

          FieldByName('DTAULT').Value    := cdsItensFornecInterno.FieldByName('DTAULT').Value;
          FieldByName('PREULT').Value    := cdsItensFornecInterno.FieldByName('PREULT').Value;
          FieldByName('FORULT').Value    := cdsItensFornecInterno.FieldByName('FORULT').Value;

          FieldByName('PRECUS').Value    := cdsItensFornecInterno.FieldByName('PRECUS').Value;
        End;

        If cdsItensFornecInterno.FieldByName('QTDITE').AsFloat > 0 Then
          FieldByName('C' + strCodFor).AsFloat :=
            (cdsItensFornecInterno.FieldByName('VALTOT').AsFloat / cdsItensFornecInterno.FieldByName('QTDITE').AsFloat)
        Else
          FieldByName('C' + strCodFor).AsFloat := 0.00;

        If (cdsFornecedoresInterno.FieldByName('UTILIZ').AsString = 'S') Then
        Begin

          If blnVerStatus And (cdsItensFornecInterno.FieldByName('STATUS').AsInteger = 1) Then
          Begin
            blnPreEsc := True;
            dicPrecoEscol[strIteAnt] := strCodFor;

            If cdsItensFornecInterno.FieldByName('PRECUS').AsFloat > 0 then
              FieldByName('DIFCUS').AsFloat := ((cdsItensFornecInterno.FieldByName('VALUNI').AsFloat - cdsItensFornecInterno.FieldByName('PRECUS').AsFloat) /
                                             cdsItensFornecInterno.FieldByName('PRECUS').AsFloat) * 100
            Else
              FieldByName('DIFCUS').Clear;
          End;

          If (cdsItensFornecInterno.FieldByName('VALTOT').AsFloat < fltTotMen) And
             (cdsItensFornecInterno.FieldByName('VALTOT').AsFloat <> 0)        Then
          Begin
            fltTotMen := cdsItensFornecInterno.FieldByName('VALTOT').AsFloat;
            dicPrecoMenor[strIteAnt] := strCodFor;

            If Not blnPreEsc Then
              dicPrecoEscol[strIteAnt] := strCodFor;

          End;

        End;

        cdsItensFornecInterno.Next;
      End;

      If State = dsInsert Then
        pPost;

      pInsereTotalFornecedores(TRUE);
      pInsereTotalFornecedores(FALSE);

      cdsItensFornecInterno.Filtered := False;
      cdsItensFornecInterno.Filter   := '';

      IndexFieldNames := strIndex;

      pMarcaEscolhidos;

      EnableControls;
    End;

    cdsConsulta.Tag := 0;

  Except
    On E: Exception Do
    Begin
      cdsConsulta.EnableControls;
      cdsConsulta.Tag := 0;
      pMensagensErro(E.Message, '[pIncluiRegistros]');
    End;
  End;
End;

Procedure TfrmCadCotComparativo.pGeraComparativo(blnVerStatus: Boolean = True;
                                                 blnAtuPre: Boolean = False);
Begin

  If fIncluiCampos Then
    pIncluiRegistros(blnVerStatus);

  If blnAtuPre then
    frmCadCotAtuPrecos.cdsItensAtuPre.pAtualizaItens(cdsConsulta,  cdsItensFornec,
                                                     dicPrecoEscol,
                                                     frmCadCotAtuPrecos.chkAtuIpi.Checked);

  pAtualizaTotais;
End;

procedure TfrmCadCotComparativo.FormDestroy(Sender: TObject);
begin
  inherited;
  pDestroyCdsInternos;

  FreeAndNil(dicPrecoMenor);
  FreeAndNil(dicPrecoEscol);
  FreeAndNil(dicTotForSel);
  FreeAndNil(dicTotForGer);
  FreeAndNil(FListaItens);
end;

procedure TfrmCadCotComparativo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F11 Then
    btnSimilares.Click
  Else
    inherited;

  Case Key Of
    VK_F3: Key := 0;
    VK_F5: Key := 0;
  End;

end;

procedure TfrmCadCotComparativo.FormShow(Sender: TObject);
begin
  inherited;

  blnFecharComEscape := False;
end;

procedure TfrmCadCotComparativo.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
  Var
    strTexto: String;
    strTotal: String;
    rectAux : TRect;
    strValor: String;
begin
  inherited;

  With dbgConsulta.Canvas Do
  Begin
    If cdsConsulta.IsEmpty Then
      Exit;

    If cdsConsulta.FieldByName('CODITE').AsString = ITEM_TOTAL Then
    Begin
      dbgConsulta.Canvas.Brush.Color:= clMoneyGreen;
      dbgConsulta.Canvas.FillRect(Rect);

      If Column.Index = 2 Then
      Begin
        strTexto := 'TOTAL SELECIONADO POR FORNECEDOR';
        dbgConsulta.Canvas.TextOut(Rect.Right - TextWidth(strTexto) - 3, Rect.Top + 2, strTexto);
      End

      Else If Column.Index >= COLFORINI Then
      Begin
        If dicTotForSel[RightStr(Column.FieldName, 8)] <> Null Then
          strTexto := FormatFloat('#,##0.00', dicTotForSel[RightStr(Column.FieldName, 8)])
        Else
          strTexto := '0,00';

        dbgConsulta.Canvas.TextOut(Rect.Right - TextWidth(strTexto) - 3, Rect.Top + 2, strTexto);
      End;

    End

    {*****************************************}
    {* TOTAL GERAL DA COTAÇÃO                *}
    {**************************************EL*}
    Else If cdsConsulta.FieldByName('CODITE').AsString = ITEM_TOTAL_GERAL Then
    Begin
      dbgConsulta.Canvas.Brush.Color := clSilver;
      dbgConsulta.Canvas.FillRect(Rect);

      If Column.Index = 2 Then
      Begin
        strTotal := 'TOTAL GERAL DO FORNECEDOR';
        dbgConsulta.Canvas.TextOut(Rect.Right - TextWidth(strTotal) - 3, Rect.Top + 2, strTotal);
      End;

      If Column.Index >= COLFORINI Then
      Begin
        If dicTotForGer[RightStr(Column.FieldName, 8)] <> Null Then
          strTexto := FormatFloat('#,##0.00', dicTotForGer[RightStr(Column.FieldName, 8)])
        Else
          strTexto := '0,00';

        dbgConsulta.Canvas.TextOut(Rect.Right - TextWidth(strTexto) - 3, Rect.Top + 2, strTexto);
      End;

    End
    Else

    Begin

      If (Column.Index >= COLFORINI) Then
      Begin

        If (RightStr(Column.FieldName, 8) = dicPrecoMenor[cdsConsulta.FieldByName('CODITE').AsString]) And
           (RightStr(Column.FieldName, 8) = dicPrecoEscol[cdsConsulta.FieldByName('CODITE').AsString]) Then
        Begin
          dbgConsulta.Canvas.Brush.Color:= clGreen;
          dbgConsulta.Canvas.FillRect(Rect);

          dbgConsulta.Canvas.Brush.Color:= clYellow;
          dbgConsulta.Canvas.Font.Color:= clWindowText;

          rectAux := Rect;

          rectAux.Left := rectAux.Left + 2;
          rectAux.Top  := rectAux.Top  + 2;

          rectAux.Bottom := rectAux.Bottom - 2;
          rectAux.Right  := rectAux.Right - 2;

          dbgConsulta.Canvas.FillRect(rectAux);

          strValor := FormatFloat('#,##0.00', cdsConsulta.FieldByName(Column.FieldName).AsFloat);

          dbgConsulta.Canvas.TextOut(rectAux.Right - TextWidth(strValor), rectAux.Bottom - TextHeight(strValor), strValor);

          Exit;
        End

        Else If (RightStr(Column.FieldName, 8) = dicPrecoEscol[cdsConsulta.FieldByName('CODITE').AsString]) Then
        Begin
          dbgConsulta.Canvas.Brush.Color:= clYellow;
          dbgConsulta.Canvas.Font.Color:= clWindowText;
          dbgConsulta.Canvas.FillRect(Rect);
        End

        Else If (RightStr(Column.FieldName, 8) = dicPrecoMenor[cdsConsulta.FieldByName('CODITE').AsString]) Then
        Begin
          dbgConsulta.Canvas.Brush.Color:= clGreen;
          dbgConsulta.Canvas.Font.Color:= clWhite;
          dbgConsulta.Canvas.FillRect(Rect);
        End;

      End;

      dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);

    End;

  End;


end;

Function TfrmCadCotComparativo.fMarcaStatus(Var cdsItens: TUniClientDataSet; strCodFor, strCodIte: String; blnStatus: Boolean = TRUE): Boolean;
  Var
    blnFiltro: Boolean;
    strFilter: String;
Begin
  Try

    With cdsItens Do
    Begin
      DisableControls;

      blnFiltro := Filtered;
      strFilter := Filter;

      Filter   := 'CODITE = ''' +  strCodIte + '''';
      Filtered := True;

      First;

      While Not Eof Do
      Begin
        Edit;

        If FieldByName('CODFOR').AsString = strCodFor Then
        Begin
          If blnStatus Then
            FieldByName('STATUS').AsInteger := 1;
          FieldByName('PREESC').AsInteger := 1;
        End Else
        Begin
          If blnStatus Then
            FieldByName('STATUS').AsInteger := 0;
          FieldByName('PREESC').AsInteger := 0;
        End;

        Post;

        Next;
      End;

      Filter := strFilter;
      Filtered := blnFiltro;

      EnableControls;
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := FALSE;
      cdsItens.EnableControls;
      pMensagensErro(E.Message, '[fMarcaStatus]');
    End;
  End;

End;

procedure TfrmCadCotComparativo.pMarcaPreco(Column: TColumn; strCodIte: String);
  Var
    strCodFor: String;
Begin

  If (Column.Index >= COLFORINI) And (Not cdsConsulta.IsEmpty) And
     (strCodIte <> ITEM_TOTAL) And (strCodIte <> ITEM_TOTAL_GERAL) And
     (Column.Field.AsFloat > 0) Then
  Begin
    strCodFor := RightStr(Column.FieldName, 8);

    If cdsFornecedoresInterno.Locate('CODFOR', strCodFor, []) Then
    Begin

      If (cdsFornecedoresInterno.FieldByName('UTILIZ').AsString <> 'S') Then
        Exit;

      If dicPrecoEscol[strCodIte] = RightStr(Column.FieldName, 8) Then
        dicPrecoEscol[strCodIte] := dicPrecoMenor[strCodIte]
      Else
        dicPrecoEscol[strCodIte] := RightStr(Column.FieldName, 8);

      If cdsItensFornecInterno.Locate('CODFOR;CODITE', VarArrayOf([dicPrecoEscol[strCodIte], strCodIte]), []) Then
      With cdsConsulta Do
      Begin
        Edit;

        If cdsItensFornecInterno.FieldByName('PRECUS').AsFloat > 0 then
          FieldByName('DIFCUS').AsFloat := ((cdsItensFornecInterno.FieldByName('VALUNI').AsFloat - cdsItensFornecInterno.FieldByName('PRECUS').AsFloat) /
                                         cdsItensFornecInterno.FieldByName('PRECUS').AsFloat) * 100
        Else
          FieldByName('DIFCUS').Clear;

        Post;

      End;

    End;

    fMarcaStatus(cdsItensFornec, dicPrecoEscol[strCodIte], strCodIte);
    fMarcaStatus(cdsItensFornecInterno, dicPrecoEscol[strCodIte], strCodIte);

    pAtualizaTotais(True);

    dbgConsulta.Repaint;
    dbgConsulta.Refresh;
  End;

End;

procedure TfrmCadCotComparativo.pMascaraValor;
  Var
    intIndex: integer;
Begin
  If cdsConsulta.Active Then
    With dbgConsulta.Columns Do
    For intIndex := 1 To Count - 1 Do
      Case Items[intIndex].Field.DataType Of
        ftFloat: TFloatField(Items[intIndex].Field).DisplayFormat := '#0.0000';
        ftDate : TFloatField(Items[intIndex].Field).EditMask      := '99/99/9999;1;_';
      End;
End;

procedure TfrmCadCotComparativo.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: btnMarPre.Click;

    VK_ESCAPE: Begin
                 If Shift = [ssCtrl] Then
                   Key := 0;
               End;
  End;

end;

procedure TfrmCadCotComparativo.btnMarPreClick(Sender: TObject);
begin
  inherited;
  If btnMarPre.Visible Then
    pMarcaPreco(dbgConsulta.Columns[dbgConsulta.SelectedIndex],
                cdsConsulta.FieldByName('CODITE').AsString);
end;

procedure TfrmCadCotComparativo.pUtilizaFornecedor(var cdsForn: TUniClientDataSet; strCodFor: String; blnUtiliza: Boolean);
  var
    blnFilter: Boolean;
begin
  blnFilter := cdsForn.Filtered;

  cdsForn.Filtered := False;

  If cdsForn.Locate('CODFOR', strCodFor, []) Then
  Begin
    cdsForn.Edit;
    cdsForn.FieldByName('UTILIZ').AsString := IIF(blnUtiliza, 'S', 'N');
    cdsForn.Post;
  End;

  cdsForn.Filtered := blnFilter;
end;

procedure TfrmCadCotComparativo.btnSelMenClick(Sender: TObject);
begin
  inherited;
  pGeraComparativo(False);
end;

procedure TfrmCadCotComparativo.btnSimilaresClick(Sender: TObject);
  Var
    strAutIncSim,
    strCodFab,
    strCodIte: String;
    blnEnterSim: Boolean;
begin
  inherited;

  If Not btnSimilares.Visible Then
    Exit;

  If cdsConsulta.IsEmpty Then
    Exit;

  If not TfrmFatMostraProdSimilar.fMostraSimilar(cdsConsulta.FieldByName('CODSIM').AsString,
                                                 cdsConsulta.FieldByName('CODITE').AsString,
                                                 cdsConsulta.FieldByName('DESITE').AsString,
                                                 '1',
                                                 blnEnterSim,
                                                 strAutIncSim,
                                                 strCodFab,
                                                 strCodIte,
                                                 True,
                                                 False,
                                                 False,
                                                 True) Then
    fMensagem('', 'Não há itens similares!', ['&O k']);
end;

procedure TfrmCadCotComparativo.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;

  btnSimilares.Visible := (cdsConsulta.FindField('CODSIM') <> NIl ) And
                          (not fEmptyStr(cdsConsulta.FieldByName('CODSIM').AsString)) And
                          (Pos('Z', cdsConsulta.FieldByName('CODSIM').AsString)=0);

end;

function TfrmCadCotComparativo.fGetFilter: String;
Begin
  Result := Inherited fGetFilter;

  If Not fEmptyStr(Result) Then
    Result := '(' + Result + ') OR (CODITE = ''' + ITEM_TOTAL + ''') OR (CODITE = ''' + ITEM_TOTAL_GERAL + ''')';

End;

Function TfrmCadCotComparativo.fTemItemCotado: Boolean;
Begin
  Result := dicPrecoEscol.Chaves.Count > 0;
End;

procedure TfrmCadCotComparativo.lsvForUtiClickCheck(Sender: TObject);
begin
  inherited;
  pUtilizaFornecedor(cdsFornecedores,
                     LeftStr(lsvForUti.Items[lsvForUti.ItemIndex], 8),
                     lsvForUti.Checked[lsvForUti.ItemIndex]);

  pUtilizaFornecedor(cdsFornecedoresInterno,
                     LeftStr(lsvForUti.Items[lsvForUti.ItemIndex], 8),
                     lsvForUti.Checked[lsvForUti.ItemIndex]);

  pGeraComparativo(False);
end;

Function TfrmCadCotComparativo.fPedeTransportadora: Boolean;
Begin
  FillChar(recObserv, SizeOf(recObserv), #0);

  pCriarFormularios(TfrmDigObservacoes, frmDigObservacoes);

  frmDigObservacoes.Caption := 'Encerramento da Cotação e Geração de Pedido(s)';
  frmDigObservacoes.gpbFinalPed.Visible      := frmCadCotacaoGeral.dbeMulLoj.Checked;
  frmDigObservacoes.rdgOpcMultiLojas.Caption := 'Encerrar a cotação e';
  frmDigObservacoes.gpbFinalPed.Caption := ' FINALIZAÇÃO DA COTAÇÃO ';
  frmDigObservacoes.edtObserv4.Visible := False;
  frmDigObservacoes.edtObserv5.Visible := False;
  frmDigObservacoes.gpbObservacao.Height := frmDigObservacoes.gpbObservacao.Height - (frmDigObservacoes.edtObserv4.Height * 2);

  frmDigObservacoes.blnCotacao := True;
  frmDigObservacoes.ShowModal;

  Result := frmDigObservacoes.blnConfirma;

  If Result Then
  With recObserv Do
  Begin
    blnEndLoj   := frmDigObservacoes.rdgEndEnt.ItemIndex = 1;
    blnDesmen   := frmDigObservacoes.rdgOpcMultiLojas.ItemIndex = 1;
    strCodTra   := frmDigObservacoes.strCodTra;

    strNomEmp   := frmDigObservacoes.edtNomEmp.Text;
    strEndere   := frmDigObservacoes.strEndere;
    strCidade   := frmDigObservacoes.strCidade;

    strTipFre   := frmDigObservacoes.strTipFre;

    strCodEve   := frmDigObservacoes.edtCodEve.Text;
    strCodCta   := frmDigObservacoes.mskCodCta.Text;

    strObsPd1   := frmDigObservacoes.strObserv1;
    strObsPd2   := frmDigObservacoes.strObserv2;
    strObsPd3   := frmDigObservacoes.strObserv3;

    strPedVen   := frmDigObservacoes.edtPedVen.Text;
    strAtenca   := frmDigObservacoes.strAtenca;
    fltValFre   := fStrToFloat(frmDigObservacoes.edtValFre.Text);
    fltDesAce   := fStrToFloat(frmDigObservacoes.edtDesAce.Text);
  End;

  FreeAndNil(frmDigObservacoes);
End;  

function TfrmCadCotComparativo.fRetAplicacao: string;
begin
  If cdsItens.FieldByName('CODITE').AsString <> cdsConsulta.FieldByName('CODITE').AsString Then
    cdsItens.Locate('CODITE', cdsConsulta.FieldByName('CODITE').AsString, []);
  Result := cdsItens.FieldByName('APLICA').AsString;
  Result := AnsiReplaceStr(Result, STRING_QUEBRA, ' ');
end;

function TfrmCadCotComparativo.fRetMarca: string;
begin
  If cdsItens.FieldByName('CODITE').AsString <> cdsConsulta.FieldByName('CODITE').AsString Then
    cdsItens.Locate('CODITE', cdsConsulta.FieldByName('CODITE').AsString, []);
  Result := cdsItens.FieldByName('DESMAR').AsString;
end;

function TfrmCadCotComparativo.fRetSemelhantes: string;
begin
  If cdsItens.FieldByName('CODITE').AsString <> cdsConsulta.FieldByName('CODITE').AsString Then
    cdsItens.Locate('CODITE', cdsConsulta.FieldByName('CODITE').AsString, []);
  Result := cdsItens.FieldByName('CODSEM').AsString;
end;

procedure TfrmCadCotComparativo.btnExpExcelClick(Sender: TObject);
begin
  inherited;
  pLimpaPesquisa;

  If cdsConsulta.Active And (Not cdsConsulta.IsEmpty) Then
    pExportarExcel;
end;

Procedure TfrmCadCotComparativo.pMostraPedidosPendentes;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);

  frmGravando.lblGravando.Caption   := 'Verificando pedidos pendentes...';
  frmGravando.fExecutarAcao := fMostraPedidosPendentes;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);

  If FListaItens.Count > 0 Then
  Begin
    pCriarFormularios(TfrmConsItensAbertosPC, frmConsItensAbertosPC);

    If frmCadCotItens.blnMljLoj Then
      frmConsItensAbertosPC.strCodEmp := '%'
    Else
      frmConsItensAbertosPC.strCodEmp := VS_strCodEmp;

    frmConsItensAbertosPC.strItens  := fCommaText(FListaItens);

    If frmConsItensAbertosPC.fAbreConsulta Then
      frmConsItensAbertosPC.ShowModal;

    pFreeAndNil(frmConsItensAbertosPC);
  End;
End;

function TfrmCadCotComparativo.fMostraPedidosPendentes(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strFilter: String;
Begin
  Try
    FListaItens.Clear;

    With frmCadCotItensFornec.cdsConsulta Do
    Begin
      DisableControls;
      strFilter := Filter;

      Filter := '(PREESC = 1) AND (QTDITE > 0)';

      pgbProgresso.Properties.Max := RecordCount;
      Application.ProcessMessages;

      First;

      While (Not Eof) Do
      Begin
        FListaItens.Add(QuotedStr(FieldByName('CODITE').AsString));

        Next;
        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;
      End;

      Filter := strFilter;
      EnableControls;
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMostraPedidosPendentres]');
    End;
  End;

  frmCadCotItensFornec.cdsConsulta.EnableControls;
  frmCadCotItensFornec.cdsConsulta.Filter := strFilter;
End;

procedure TfrmCadCotComparativo.btnGerPedClick(Sender: TObject);
begin
  inherited;
  If (Not fTemItemCotado) or (fGetTotal('', True) <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum preço selecionado para geração de pedidos!', ['&O k']);
    Exit;
  End;

  pMostraPedidosPendentes;

  If Not fPedeTransportadora Then
    Exit;

  frmCadCotacaoGeral.blnGerarPedidos := TRUE;
  frmCadCotacaoGeral.btnGravar.Click;
end;

procedure TfrmCadCotComparativo.pDesabilitaAlteracao;
Begin
  btnMarPre.Visible := FALSE;
  btnGerPed.Visible := FALSE;
  btnSelMen.Visible := FALSE;
End;

procedure TfrmCadCotComparativo.pCriaClientItensFornecInterno;
  Var
    intCont: Integer;
begin

  cdsItensFornecInterno := TUniClientDataSet.Create(Self);

  With cdsItensFornecInterno Do
  Begin

    AggregatesActive := True;

    For intCont := 0 To cdsItensFornec.Fields.Count -1 Do
      FieldDefs.Add(cdsItensFornec.Fields[intCont].FieldName,
                    cdsItensFornec.Fields[intCont].DataType,
                    cdsItensFornec.Fields[intCont].Size,
                    False);

    With TAggregateField.Create(cdsItensFornecInterno) Do
    Begin
      FieldName     := 'TOT_VALTOT';
      DataSet       := cdsItensFornecInterno;
      DisplayFormat := '#,##0.00';
      Alignment     := Classes.taRightJustify;
      Expression    := 'SUM(VALTOT)';
      Active        := True;
    End;

    CreateDataSet;
    Open;

    cdsItensFornec.DisableControls;
    cdsItensFornec.First;

    While Not cdsItensFornec.Eof Do
    Begin
      Append;

      For intCont := 0 To cdsItensFornec.Fields.Count -1 Do
        Fields[intCont].Value := cdsItensFornec.Fields[intCont].Value;

      Post;

      cdsItensFornec.Next;
    End;

    cdsItensFornec.First;
    cdsItensFornec.EnableControls;    
  End;

end;

function TfrmCadCotComparativo.fGetTotal(strCodFor: String; blnSomSelec: Boolean): Double;
begin
  cdsItensFornecInterno.Filtered := False;

  cdsItensFornecInterno.Filter := '(1 = 1)';

  If blnSomSelec Then
    cdsItensFornecInterno.Filter := cdsItensFornecInterno.Filter +  ' AND (PREESC = 1)';

  If Not fEmptyStr(strCodFor) Then
    cdsItensFornecInterno.Filter := cdsItensFornecInterno.Filter +  ' AND (CODFOR = ' + QuotedStr(strCodFor) + ')';

  cdsItensFornecInterno.Filtered := True;

  cdsItensFornecInterno.Active := False;
  cdsItensFornecInterno.Active := True;

  If (TAggregateField(cdsItensFornecInterno.FieldByName('TOT_VALTOT')).Value = Null) Then
    Result := 0
  Else
    Result := TAggregateField(cdsItensFornecInterno.FieldByName('TOT_VALTOT')).Value;

  cdsItensFornecInterno.Filtered := False;
end;

procedure TfrmCadCotComparativo.pAtualizaTotais(blnSomTotSel: Boolean = False);
  var
    intCont: Integer;
begin
  If Not blnSomTotSel Then
    edtTotGer.Text := FormatFloat('#,##0.00', fGetTotal('', False));

  If Not blnSomTotSel Then
    for intCont := 0 to dicTotForGer.Chaves.Count -1 do
      dicTotForGer[dicTotForGer.Chaves[intCont]] := fGetTotal(dicTotForGer.Chaves[intCont], False);

  for intCont := 0 to dicTotForSel.Chaves.Count -1 do
    dicTotForSel[dicTotForSel.Chaves[intCont]] := fGetTotal(dicTotForSel.Chaves[intCont], True);

end;

procedure TfrmCadCotComparativo.pExcelImprimeFiltros(Excel: TExcel; Dados: TDataSet;
  Campos: TCampos; Filtros: Array Of String);

  procedure pTitulo(intLinha: Integer; CorDaFonte: TCorExcel; intFonte: Integer; opcAlinhamento: TAlinhamentoExcel; strTitulo: String);
    var
      strLinha: String;
  begin
    strLinha := IntToStr(intLinha);

    With Excel, Campos Do
    Begin
      Mesclar     ('A' + strLinha, fGetLetraAlfa(Colunas.Count) + strLinha);
      Alinhamento ('A' + strLinha, fGetLetraAlfa(Colunas.Count) + strLinha, opcAlinhamento);
      Negrito     ('A' + strLinha, fGetLetraAlfa(Colunas.Count) + strLinha, True);
      CorFonte    ('A' + strLinha, fGetLetraAlfa(Colunas.Count) + strLinha, CorDaFonte);
      DefinirFonte('A' + strLinha, fGetLetraAlfa(Colunas.Count) + strLinha, Arial, intFonte);

      Escrever(intLinha, 1, strTitulo);
    End;
  end;

begin
  Excel.PintarTudo(Branco);

  pTitulo(1, Preto, 16, Centro, fRetNomeEmpresa);
  Excel.Mesclar('A1', fGetLetraAlfa(Campos.Colunas.Count) + '1'); //No BROffice se der merge 2x ele tira, e ja estava com merge.

  pTitulo(Excel.ProximaLinha, Preto, 16, Centro,'DEPARTAMENTO DE COMPRAS');

  pTitulo(Excel.ProximaLinha, Vermelho, 16, Centro, 'COTAÇÃO DE PREÇOS: ' + frmCadCotacaoGeral.dtsCotacao.DataSet.FieldByName('COT_NUMCOT').AsString);

  pTitulo(Excel.ProximaLinha, Preto, 10, Centro, 'COMPRADOR: ' +
    fRetNomVendRep(frmCadCotacaoGeral.dtsCotacao.DataSet.FieldByName('COT_CODCMP').AsString));

  {**************************************}
  {* INSERE UMA NOVA COLUNA NOS TITULOS *}
  {**************************************}
  With Excel Do
  Begin
    Escrever   (LinhaAtual + 1, Campos.Colunas.Count + 1, '% VAR.(*)');
    Negrito    (LinhaAtual + 1, Campos.Colunas.Count + 1, True);
    Alinhamento(LinhaAtual + 1, Campos.Colunas.Count + 1, Direita);

    CorFundo('A' + IntToStr(LinhaAtual + 1), fGetLetraAlfa(Campos.Colunas.Count + 1) + IntToStr(LinhaAtual + 1), Preto);
    CorFonte('A' + IntToStr(LinhaAtual + 1), fGetLetraAlfa(Campos.Colunas.Count + 1) + IntToStr(LinhaAtual + 1), Branco);
    Bordas  ('A' + IntToStr(LinhaAtual + 1), fGetLetraAlfa(Campos.Colunas.Count + 1) + IntToStr(LinhaAtual + 1));
  End;

end;

procedure TfrmCadCotComparativo.pSomaTotais(var Totais: TTotais;
  Dados: TDataSet);
  var
    intColumn: Integer;
    strColFor: String;
    fltTotIte: Double;
begin

  For intColumn := COLFORINI To dbgConsulta.Columns.Count -1 Do
  Begin
    strColFor := dbgConsulta.Columns[intColumn].FieldName;

    fltTotIte := Dados.FieldByName('QTDITE').AsFloat * Dados.FieldByName(strColFor).AsFloat;

    If intColumn >= COLFORINI Then
    Begin
      Totais['TOT_GER_' + strColFor] := Totais['TOT_GER_' + strColFor] + fltTotIte;

      If dicPrecoEscol[Dados.FieldByName('CODITE').AsString] = RightStr(strColFor, 8) Then
        Totais['TOT_SEL_' + strColFor] := Totais['TOT_SEL_' + strColFor] + fltTotIte;
    End;

  End;

end;

procedure TfrmCadCotComparativo.pMontaResumo(Excel: TExcel; Campos: TCampos;
  Quebra: TRecQuebras);
  var
    intCont: Integer;
begin
  With Excel Do
  Begin
    If Quebra.NomeCampo = '[GERAL]' Then
    Begin
      ProximaLinha;

      Mesclar('A' + IntToStr(LinhaAtual), fGetLetraAlfa(COLFORINI) + IntToStr(LinhaAtual));
      Escrever(LinhaAtual, 1, 'TOTAL SELECIONADO POR FORNECEDOR');

      For intCont := COLFORINI To dbgConsulta.Columns.Count -1 Do
      Begin
        Escrever(LinhaAtual, intCont + 2, Quebra.Totais['TOT_SEL_' + dbgConsulta.Columns[intCont].FieldName]);
        FormatoNumerico(LinhaAtual, intCont + 2);
      End;

      Negrito ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
      CorFundo('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Verde_Mar);
      CorFonte('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Branco);
      Bordas  ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));

      ProximaLinha;

      Mesclar('A' + IntToStr(LinhaAtual), fGetLetraAlfa(COLFORINI) + IntToStr(LinhaAtual));
      Escrever(LinhaAtual, 1, 'TOTAL GERAL POR FORNECEDOR');

      For intCont := COLFORINI To dbgConsulta.Columns.Count -1 Do
      Begin
        Escrever(LinhaAtual, intCont + 2, Quebra.Totais['TOT_GER_' + dbgConsulta.Columns[intCont].FieldName]);
        FormatoNumerico(LinhaAtual, intCont + 2);
      End;

      Negrito ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
      CorFundo('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
      CorFonte('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
      Bordas  ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));

      ProximaLinha;

      Mesclar('A' + IntToStr(LinhaAtual), fGetLetraAlfa(COLFORINI) + IntToStr(LinhaAtual));
      Escrever(LinhaAtual, 1, '(*) Percentual de Variação entre os dois menores preços.');

      ProximaLinha;
      ProximaLinha;      

      Bordas  ('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual));
      CorFundo('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual), Verde);
      Escrever(LinhaAtual, 2, 'Menor Preço');

      ProximaLinha;

      Bordas  ('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual));
      CorFundo('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual), Amarelo);
      Escrever(LinhaAtual, 2, 'Preço Escolhido');

    End;
  End;

end;

procedure TfrmCadCotComparativo.pFimGeracao(Excel: TExcel; Campos: TCampos);
  var
    intCont  : Integer;
    strColuna: string;
    strNomFor: String;
    strRange : String;
begin

  For intCont := COLFORINI To dbgConsulta.Columns.Count -1 Do
  Begin
    strColuna := dbgConsulta.Columns[intCont].FieldName;
    strNomFor := LeftStr(dbgConsulta.Columns[intCont].Title.Caption, 12);

    With cdsFornecedoresInterno Do
    Begin

      If (Locate('CODFOR', RightStr(strColuna, 8), [])) And (FieldByName('UTILIZ').AsString <> 'S') Then
      Begin

        If (Excel.LocalizarCelula(strNomFor)) Then
        Begin
          strRange := Campos.ColunaPorNome[strColuna].Letra + IntToStr(Excel.LinhaAtual);
          Excel.CorFonte(strRange, strRange, CinzaEscuro);
        End;

      End;

    End;

  End;

end;

procedure TfrmCadCotComparativo.pImprimeDetalhes(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
  var
    intCont  : Integer;
    strColFor: String;
    strRange : String;
    stlPrecos: TStringList;
    fltPerVar: Double;
begin

  stlPrecos := TStringList.Create;
  stlPrecos.Sorted := True;

  With Excel, Campos Do
  Begin
    For intCont := COLFORINI To dbgConsulta.Columns.Count -1 Do
    Begin
      strColFor := dbgConsulta.Columns[intCont].FieldName;
      strRange  := fGetLetraAlfa(ColunaPorNome[strColFor].Coluna) + IntToStr(LinhaAtual);

      If dicPrecoEscol[Dados.FieldByName('CODITE').AsString] = RightStr(strColFor, 8) Then
      Begin
        CorFundo(strRange, strRange, Amarelo);
        CorFonte(strRange, strRange, Azul);
      End

      Else If dicPrecoMenor[Dados.FieldByName('CODITE').AsString] = RightStr(strColFor, 8) Then
      Begin
        CorFundo(strRange, strRange, Verde);
        CorFonte(strRange, strRange, Branco);
      End;

      If (cdsFornecedoresInterno.Locate('CODFOR', RightStr(strColFor, 8), []) And
         (cdsFornecedoresInterno.FieldByName('UTILIZ').AsString = 'S'))       And
         (Dados.FieldByName(strColFor).AsFloat > 0)                           Then
      Begin
        stlPrecos.Add(fStrZero(FloatToStrF(Dados.FieldByName(strColFor).AsFloat, ffFixed, 12, 2), 12));
      End;

    End;

    {*******************************************************}
    {* CALCULA % VARIAC ENTRE OS DOIS MENORES PRECOS       *}
    {****************************************************JC*}
    If stlPrecos.Count > 1 Then
    Begin
      fltPerVar := ( ( ( fStrToFloat(stlPrecos[1]) / fStrToFloat(stlPrecos[0]) ) - 1 ) * 100 );
    End
    Else
      fltPerVar := 0.00;

    FormatoNumerico(LinhaAtual, Campos.Colunas.Count + 1);
    Escrever       (LinhaAtual, Campos.Colunas.Count + 1, fltPerVar);
    Alinhamento    (LinhaAtual, Campos.Colunas.Count + 1, Direita);

    Bordas(fGetLetraAlfa(Campos.Colunas.Count + 1) + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count + 1) + IntToStr(LinhaAtual));

    If Dados.RecNo Mod 2 = 0 Then
      CorFundo(fGetLetraAlfa(Campos.Colunas.Count + 1) + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count + 1) + IntToStr(LinhaAtual), Cinza);
  End;

  FreeAndNil(stlPrecos);

end;

procedure TfrmCadCotComparativo.pExportarExcel;
  var
    qryCadEmp: TUniQuery;
    intColumn: Integer;
    objGeraExcel: TGeraExcel;
    blnConfirma: Boolean;

  procedure pLeEmpresa;
    Var
      strSQL: String;
  Begin
    qryCadEmp := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_NOMEMP, ';
    strSQL := strSQL + '  CONCAT(EMP_ENDERE, ", ", IFNULL(EMP_ENDNUM,""), "  ", IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP)), " - ", EMP_BAIRRO) AS EMP_ENDERE, ';
    strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, "-", CADCID.CID_ESTADO, "   CEP: ", EMP_C_E_P_) AS EMP_NOMCID, ';
    strSQL := strSQL + '  EMP_FONE01, ';
    strSQL := strSQL + '  EMP_F_A_X_, ';
    strSQL := strSQL + '  EMP_EMAIL_ ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP, ';
    strSQL := strSQL + '  CADCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CADEMP.EMP_CODCID = CADCID.CID_CODCID AND ';
    strSQL := strSQL + '  CADEMP.EMP_CODEMP = :CODEMP ';

    With qryCadEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;

  end;

begin

  Try
    pCriarFormularios(TfrmPedOrdenacao, frmPedOrdenacao);
    With frmPedOrdenacao Do
    Begin
      blnConfirma := ShowModal = mrOk;

      If blnConfirma Then
        Case rdgOrdenacao.ItemIndex Of
           1:   cdsConsulta.IndexFieldNames := 'DESITE';
           2:   cdsConsulta.IndexFieldNames := 'DESMAR;DESITE';
           Else cdsConsulta.IndexFieldNames := 'CODITE';
        End;
    End;
    FreeAndNil(frmPedOrdenacao);

    If Not blnConfirma Then
      Exit;

    cdsConsulta.DisableControls;

    cdsConsulta.Filter := '(CODITE <> ''' + ITEM_TOTAL + ''') AND (CODITE <> ''' + ITEM_TOTAL_GERAL + ''')';
    cdsConsulta.Filtered := True;

    objGeraExcel := TGeraExcel.Create(cdsConsulta, pgbProgresso);

    objGeraExcel.strNomRel := fRetFantasiaEmpresa;
    objGeraExcel.intFonteNomRel := 16;

    objGeraExcel.blnImpEmp := False;
    objGeraExcel.blnTestaArq := True;

    pLeEmpresa;

    objGeraExcel.AddFiltro(qryCadEmp.FieldByName('EMP_ENDERE').AsString);
    objGeraExcel.AddFiltro(qryCadEmp.FieldByName('EMP_NOMCID').AsString);
    objGeraExcel.AddFiltro('Fone.: ' + qryCadEmp.FieldByName('EMP_FONE01').AsString);
    objGeraExcel.AddFiltro('Fax..: ' + qryCadEmp.FieldByName('EMP_F_A_X_').AsString);
    objGeraExcel.AddFiltro('Email: ' + qryCadEmp.FieldByName('EMP_EMAIL_').AsString);

    objGeraExcel.OnImpFiltros  := pExcelImprimeFiltros;
    objGeraExcel.OnSomaResumo  := pSomaTotais;
    objGeraExcel.OnMontaResumo := pMontaResumo;
    objGeraExcel.OnImpDetalhes := pImprimeDetalhes;
    objGeraExcel.OnFimGeracao  := pFimGeracao;

    For intColumn := 0 To dbgConsulta.Columns.Count -1 Do
    Begin
      objGeraExcel.AddCampo(dbgConsulta.Columns[intColumn].FieldName, LeftStr(dbgConsulta.Columns[intColumn].Title.Caption, 12));

      If SameText(dbgConsulta.Columns[intColumn].FieldName, 'REFERE') then
      Begin
        objGeraExcel.AddCampo(fRetMarca, 'DESMAR', 'Marca');
        objGeraExcel.AddCampo(fRetAplicacao, 'ITE_APLICA', 'Aplicação');
      End

      Else If SameText(dbgConsulta.Columns[intColumn].FieldName, 'CODSIM') then
      Begin
        objGeraExcel.AddCampo(fRetSemelhantes, 'CODSEM', 'Semelhantes');
      End;

      If intColumn >= COLFORINI Then
      Begin
        objGeraExcel.AddTotais('TOT_SEL_' + dbgConsulta.Columns[intColumn].FieldName);
        objGeraExcel.AddTotais('TOT_GER_' + dbgConsulta.Columns[intColumn].FieldName);
      End;

    End;

    If objGeraExcel.fGerarRelatorio Then
      pMensagemOk('Arquivo gerado com sucesso!');

    FreeAndNil(objGeraExcel);
    FreeAndNil(qryCadEmp);
    
  Except
    On E: Exception Do
      pMensagensErro(E.Message, ''); 
  End;

  cdsConsulta.EnableControls;
  cdsConsulta.Filter   := '';
  cdsConsulta.Filtered := False;

end;

procedure TfrmCadCotComparativo.pListaFornecedores;
begin
  lsvForUti.Clear;

  With cdsFornecedoresInterno Do
  Begin
    IndexFieldNames := 'NOMFOR';

    First;

    While Not Eof Do
    Begin
      lsvForUti.Items.Add(FieldByName('CODFOR').AsString + '-' + FieldByName('NOMFOR').AsString);

      If FieldByName('UTILIZ').AsString = 'S' Then
        lsvForUti.Checked[RecNo -1] := True;

      Next;
    End;

    First;
  End;

end;


end.
