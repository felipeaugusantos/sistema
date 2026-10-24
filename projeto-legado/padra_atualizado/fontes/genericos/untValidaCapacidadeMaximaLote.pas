unit untValidaCapacidadeMaximaLote;

interface

uses Windows, Messages, Uni, untMensagemExplicativa, UniClientDataSet, untMsgLiberacao,
     untLiberacao, untFuncoesSimples, System.SysUtils, Data.DB;

  function fValidaCapacidadeMaximaLote(strNumLot: String; cdsDataCapacMaxima: TUniClientDataSet): Boolean;
  function fCriaDataCapaMaxima(cdsData: TUniClientDataSet): TUniClientDataSet;
  function fInsereItemCapacidadeMaxima(strCodIte, strNumLot: String; fltQtdIte: Double; cdsData:TUniClientDataSet): TUniClientDataSet;
  function fTravaAviso(cdsDataCapacMaxima: TUniClientDataSet;
                       var qryCons      : TUniQuery;
                       var objLinha     : TLinhaMsgLibera;
                       var objLiberacao : TLiberacao;
                       var objTabela    : TRegistroMsgLiberaTabela;
                           blnTrava     : Boolean;
                           blnAvisa     : Boolean;
                       var strMsg       : String;
                       var blnEntradaUltrapassaCapassidadeMaxima: Boolean) : Boolean;
  function fTrava(cdsDataCapacMaxima: TUniClientDataSet;
                  var qryCons      : TUniQuery;
                  var objLinha     : TLinhaMsgLibera;
                  var objLiberacao : TLiberacao;
                  var objTabela    : TRegistroMsgLiberaTabela;
                       blnTrava     : Boolean;
                       blnAvisa     : Boolean;
                  var strMsg       : String;
                  var blnEntradaUltrapassaCapassidadeMaxima: Boolean) : Boolean;
  function fAviso(cdsDataCapacMaxima: TUniClientDataSet;
                  var qryCons      : TUniQuery;
                  var objLinha     : TLinhaMsgLibera;
                  var objLiberacao : TLiberacao;
                  var objTabela    : TRegistroMsgLiberaTabela;
                      blnTrava     : Boolean;
                      blnAvisa     : Boolean;
                  var strMsg       : String;
                  var blnEntradaUltrapassaCapassidadeMaxima: Boolean) : Boolean;

Const
  cvcmlSQL_CONSULTA =  ' SELECT                            '+
                  '   LOT_CAPACI,                     '+
                  '   LOT_NUMLOT,                     '+
                  '   LOT_SALDOS                      '+
                  ' FROM CADLOT                       '+
                  ' WHERE LOT_CODEMP = :CODEMP AND    '+
                  '       LOT_CODITE IN (:CODITE) AND '+
                  '       LOT_NUMLOT = :NUMLOT AND    '+
                  '       LOT_STATUS = :STATUS AND    '+
                  '       LOT_CAPACI > 0              ';

  cvcmlCOMPLEMENTO_X = '-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';

implementation

function fValidaCapacidadeMaximaLote(strNumLot: String; cdsDataCapacMaxima: TUniClientDataSet): Boolean;

Var
   qryCons      : TUniQuery;
   objLinha     : TLinhaMsgLibera;
   objLiberacao : TLiberacao;
   objTabela    : TRegistroMsgLiberaTabela;
   blnTrava     : Boolean;
   blnAvisa     : Boolean;
   strMsg       : String;
   blnEntradaUltrapassaCapassidadeMaxima: Boolean;

begin

  If cdsDataCapacMaxima = Nil Then
  Begin
    Result:= False;
    Exit;
  End;
  strMsg      := '';
  qryCons     := fCriaQuery(Nil);
  objTabela   := TRegistroMsgLiberaTabela.Create;
  objLiberacao:= TLiberacao.Create;


  blnEntradaUltrapassaCapassidadeMaxima := False;

  Try
    Result := False;
    blnTrava:= (fCfgSis('CAMXUT',varString) = 'T');
    blnAvisa:= (fCfgSis('CAMXUT',varString) = 'A');


    cdsDataCapacMaxima.First;
    While Not(cdsDataCapacMaxima.eof) do
    Begin

      qryCons.Close;
      qryCons.SQL.Clear;
      qryCons.SQL.Add(cvcmlSQL_CONSULTA);
      qryCons.ParamByName('CODEMP').AsString:= VS_strCodEmp;
      qryCons.ParamByName('CODITE').AsString:= cdsDataCapacMaxima.FieldByName('CODITE').AsString;
      qryCons.ParamByName('NUMLOT').AsString:= cdsDataCapacMaxima.FieldByName('NUMLOT').AsString;
      qryCons.ParamByName('STATUS').AsString:= 'S';
      qryCons.Open;

      If qryCons.IsEmpty Then
      Begin
        Result := True;
        Exit;
      End;

      blnEntradaUltrapassaCapassidadeMaxima:= (qryCons.FieldByName('LOT_CAPACI').AsFloat <
                                             (qryCons.FieldByName('LOT_SALDOS').AsFloat +
                                              cdsDataCapacMaxima.FieldByName('QTDITE').AsFloat)) And
                                              (qryCons.FieldByName('LOT_CAPACI').AsFloat > 0);

      If blnEntradaUltrapassaCapassidadeMaxima Then
        Break;

      cdsDataCapacMaxima.Next;
    End;

    If blnEntradaUltrapassaCapassidadeMaxima Then
    Begin
      Result := fTravaAviso(cdsDataCapacMaxima,
                             qryCons,
                             objLinha,
                             objLiberacao,
                             objTabela,
                             blnTrava,
                             blnAvisa,
                             strMsg,
                             blnEntradaUltrapassaCapassidadeMaxima)

    End
    Else

      Result := True;


  Finally
    FreeAndNil(qryCons);

    If objTabela <> Nil Then
      FreeAndNil(objTabela);

    If cdsDataCapacMaxima <> Nil Then
      FreeAndNil(cdsDataCapacMaxima);

  End;
End;

function fTrava(cdsDataCapacMaxima: TUniClientDataSet;
                var qryCons      : TUniQuery;
                var objLinha     : TLinhaMsgLibera;
                var objLiberacao : TLiberacao;
                var objTabela    : TRegistroMsgLiberaTabela;
                    blnTrava     : Boolean;
                    blnAvisa     : Boolean;
                var strMsg       : String;
                var blnEntradaUltrapassaCapassidadeMaxima: Boolean) : Boolean;
Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Capacidade máxima do lote ultrapassada');

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'Número do Lote'         , 40, alCentro , teAutcom);
    objLinha.pAddColuna(''  , 'Capacidade Máxima Lote' , 40 , alCentro , teAutcom);
    objLinha.pAddColuna(''  , 'Saldo Lote Após Entrada', 40 , alCentro  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);



    cdsDataCapacMaxima.First;
    While Not(cdsDataCapacMaxima.eof) do
    Begin

      qryCons.Close;
      qryCons.SQL.Clear;
      qryCons.SQL.Add(cvcmlSQL_CONSULTA);
      qryCons.ParamByName('CODEMP').AsString:= VS_strCodEmp;
      qryCons.ParamByName('CODITE').AsString:= cdsDataCapacMaxima.FieldByName('CODITE').AsString;
      qryCons.ParamByName('NUMLOT').AsString:= cdsDataCapacMaxima.FieldByName('NUMLOT').AsString;
      qryCons.ParamByName('STATUS').AsString:= 'S';
      qryCons.Open;

      blnEntradaUltrapassaCapassidadeMaxima:=(qryCons.FieldByName('LOT_CAPACI').AsFloat <
                                             (qryCons.FieldByName('LOT_SALDOS').AsFloat +
                                              cdsDataCapacMaxima.FieldByName('QTDITE').AsFloat)) And
                                              (qryCons.FieldByName('LOT_CAPACI').AsFloat > 0);

      If blnEntradaUltrapassaCapassidadeMaxima Then
      Begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Número do Lote'          , qryCons.FieldByName('LOT_NUMLOT').AsString, 40, alCentro);
        objLinha.pAddColuna('Capacidade Máxima Lote'  , qryCons.FieldByName('LOT_CAPACI').AsString, 40 , alCentro);
        objLinha.pAddColuna('Saldo Lote Após Entrada' , FormatFloat('#,##0.00', (qryCons.FieldByName('LOT_SALDOS').AsFloat +
                                                                                 cdsDataCapacMaxima.FieldByName('QTDITE').AsFloat)), 40, alCentro );
        objTabela.lstLinhas.Add(objLinha);
      End;

      cdsDataCapacMaxima.Next;

    End;


    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('Operador Logado: ', strLoginUsuarioLogado + cvcmlCOMPLEMENTO_X, 40  , alEsquerda);
    objTabela.lstLinhas.Add(objLinha);

    objLiberacao.strDirAce := 'PERMAX';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.blnUsarSenhaFixa := False;
    objLiberacao.blnSempreVariavelUsuario := True;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    Result := objLiberacao.fLibera;

End;

function fAviso(cdsDataCapacMaxima: TUniClientDataSet;
                var qryCons      : TUniQuery;
                var objLinha     : TLinhaMsgLibera;
                var objLiberacao : TLiberacao;
                var objTabela    : TRegistroMsgLiberaTabela;
                    blnTrava     : Boolean;
                    blnAvisa     : Boolean;
                var strMsg       : String;
                var blnEntradaUltrapassaCapassidadeMaxima: Boolean) : Boolean;
Begin
  pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
  frmMensagemExplicativa.Caption := 'Aviso';
  frmMensagemExplicativa.Width   := 800;
  frmMensagemExplicativa.Height  := 450;
  frmMensagemExplicativa.RitchObservacao.Visible:= True;
  frmMensagemExplicativa.RitchObservacao.BringToFront;

  cdsDataCapacMaxima.First;
  While Not(cdsDataCapacMaxima.eof) do
  Begin

    qryCons.Close;
    qryCons.SQL.Clear;
    qryCons.SQL.Add(cvcmlSQL_CONSULTA);
    qryCons.ParamByName('CODEMP').AsString:= VS_strCodEmp;
    qryCons.ParamByName('CODITE').AsString:= cdsDataCapacMaxima.FieldByName('CODITE').AsString;
    qryCons.ParamByName('NUMLOT').AsString:= cdsDataCapacMaxima.FieldByName('NUMLOT').AsString;
    qryCons.ParamByName('STATUS').AsString:= 'S';
    qryCons.Open;

    blnEntradaUltrapassaCapassidadeMaxima:= qryCons.FieldByName('LOT_CAPACI').AsFloat <
                                           (qryCons.FieldByName('LOT_SALDOS').AsFloat +
                                            cdsDataCapacMaxima.FieldByName('QTDITE').AsFloat);

    frmMensagemExplicativa.RitchObservacao.Lines.Add('A capacidade máxima do(s) lote(s) abaixo será ultrapassada.');
    frmMensagemExplicativa.RitchObservacao.Lines.Add('');

    frmMensagemExplicativa.RitchObservacao.Lines.Add('Número do Lote'+ '             '+ 'Capacidade Máxima Lote'+'             '+'Saldo Lote Após Entrada');
    frmMensagemExplicativa.RitchObservacao.Lines.Add('');

    If blnEntradaUltrapassaCapassidadeMaxima Then
    Begin
      strMsg:= strMsg + qryCons.FieldByName('LOT_NUMLOT').AsString + '                               '+
                        qryCons.FieldByName('LOT_CAPACI').AsString + '                               '+
                        FormatFloat('#,##0.00', (qryCons.FieldByName('LOT_SALDOS').AsFloat +
                                                 cdsDataCapacMaxima.FieldByName('QTDITE').AsFloat));
      frmMensagemExplicativa.RitchObservacao.Lines.Add(strMsg);
      strMsg:= '';
    End;

    cdsDataCapacMaxima.Next;

  End;

  frmMensagemExplicativa.ShowModal;
  FreeAndNil(frmMensagemExplicativa);
  Result := True;
End;



function fTravaAviso(cdsDataCapacMaxima: TUniClientDataSet;
                     var qryCons      : TUniQuery;
                     var objLinha     : TLinhaMsgLibera;
                     var objLiberacao : TLiberacao;
                     var objTabela    : TRegistroMsgLiberaTabela;
                         blnTrava     : Boolean;
                         blnAvisa     : Boolean;
                     var strMsg       : String;
                     var blnEntradaUltrapassaCapassidadeMaxima: Boolean) : Boolean;

begin
  If blnTrava Then //A_T_N
  Begin
    Result := fTrava(cdsDataCapacMaxima,
                     qryCons,
                     objLinha,
                     objLiberacao,
                     objTabela,
                     blnTrava,
                     blnAvisa,
                     strMsg,
                     blnEntradaUltrapassaCapassidadeMaxima);
  End
  Else
  If blnAvisa Then
  Begin
    Result := fAviso(cdsDataCapacMaxima,
                     qryCons,
                     objLinha,
                     objLiberacao,
                     objTabela,
                     blnTrava,
                     blnAvisa,
                     strMsg,
                     blnEntradaUltrapassaCapassidadeMaxima)



  End
  Else
    Result := True;
End;

function fCriaDataCapaMaxima(cdsData: TUniClientDataSet): TUniClientDataSet;
Begin

  If cdsData <> Nil Then
    FreeAndNil(cdsData);

  cdsData:= TUniClientDataSet.Create(Nil);
  cdsData.FieldDefs.Add('CODITE', ftString, 13);
  cdsData.FieldDefs.Add('QTDITE', ftFloat);
  cdsData.FieldDefs.Add('NUMLOT', ftString, VS_Size_NumLot);

  cdsData.CreateDataSet;
  cdsData.Open;

  result:= cdsData;

End;

function fInsereItemCapacidadeMaxima(strCodIte, strNumLot: String; fltQtdIte: Double; cdsData:TUniClientDataSet): TUniClientDataSet;
Begin
  cdsData.Insert;
  cdsData.FieldByName('CODITE').AsString:= strCodIte;
  cdsData.FieldByName('QTDITE').AsFloat := fltQtdIte;
  cdsData.FieldByName('NUMLOT').AsString := strNumLot;
  cdsData.Post;

  Result:= cdsData;
End;


end.
