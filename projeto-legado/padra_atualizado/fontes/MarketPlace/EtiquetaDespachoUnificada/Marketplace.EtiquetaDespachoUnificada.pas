unit Marketplace.EtiquetaDespachoUnificada;

// Orquestrador da etiqueta unificada. Dispatcher fino:
//
//   1. Consulta registry pelo prefixo do marketplace
//   2. Valida NFE_LAYUNI configurado (coluna presente e nao vazia)
//   3. Se o processador precisa de DANFE, invoca NFeImpressao.exe pra gerar BMP;
//      DANFE que nao coube em uma pagina = nao unifica
//   4. Delega ao processador especifico via IProcessadorMarketplace
//   5. Salva o ZPL retornado em .unificada.txt e devolve o novo path
//
// Politica de falha: ANTES o orquestrador caia silenciosamente no fluxo
// original em qualquer falha - o que mascarava problemas e gerava
// reclamacoes tipo "nao esta unificando". Agora TODO caminho de falha
// dispara fMensagem descritivo. O Result continua sendo o path original
// (cliente ainda imprime a etiqueta do marketplace sozinha, evitando ficar
// sem etiqueta), mas ele sabe exatamente o que falhou.
//
// Cada marketplace tem sua propria unit que se auto-registra em initialization:
//   Marketplace.EtiquetaDespachoUnificada.MercadoLivre  (MLB_)
//   Marketplace.EtiquetaDespachoUnificada.Shopee        (SHP_)
//   Marketplace.EtiquetaDespachoUnificada.TikTok        (TIKTOK_)
//
// Novos marketplaces = novo processador + registro + entrada em VS_arrMarketplaces.
// Nao mexer aqui.

interface

uses
  System.SysUtils, System.IOUtils;

type
  TEtiquetaDespachoUnificada = class
    // Devolve o path do ZPL unificado, ou AstrPathZPLOriginal quando nao unificou.
    class function fGerar(const AstrPathZPLOriginal: String;
                          const AstrNumDoc, AstrEspDoc, AstrCodEmp, AstrPrefixo: String;
                          const AstrChaveNFe: String): String;

    // Retorna True se o marketplace correspondente ao prefixo esta habilitado
    // na configuracao CFG_EDUNIF (string com prefixos concatenados, ex:
    // 'MLB_SHP_TIKTOK_'). Substitui a antiga flag boolean unica CFG_EDUNIF S/N
    // permitindo habilitar/desabilitar unificacao por marketplace individualmente.
    // Vazio na configuracao = nenhum marketplace unificado (comportamento antigo).
    class function fMarketplaceUnificarAtivo(const AstrPrefixo: String): Boolean;
  end;

implementation

uses
  System.Variants,
  Marketplace.EtiquetaDespachoUnificada.IProcessador,
  untFuncoesSimples,
  untFuncoesGenerica,
  untImpressaoDiretaCitel;

class function TEtiquetaDespachoUnificada.fGerar(const AstrPathZPLOriginal: String;
                                                  const AstrNumDoc, AstrEspDoc, AstrCodEmp, AstrPrefixo: String;
                                                  const AstrChaveNFe: String): String;
var
  ipProcessador: IProcessadorMarketplace;
  strConteudo, strZPLFinal, strPathNovo, strDirTemp, strPathBMP: String;
  strBitmapsPresentes: String;
  intTamLayoutUnif: Integer;

  procedure pApagarBMPsDaChave;
  var
    strArquivo: String;
  begin
    for strArquivo in TDirectory.GetFiles(strDirTemp, 'etq-unif-' + AstrChaveNFe + '*.bmp') do
      TFile.Delete(strArquivo);
  end;

begin
  Result := AstrPathZPLOriginal;

  try
    if not TFile.Exists(AstrPathZPLOriginal) then
    begin
      pMensagemSonora('ARQUIVO DE ETIQUETA NAO ENCONTRADO' + #13#10 + #13#10 +
                'Nao foi encontrado o arquivo ZPL original da etiqueta:' + #13#10 + #13#10 +
                AstrPathZPLOriginal);
      Exit;
    end;

    ipProcessador := TRegistroProcessadores.fCriarPorPrefixo(AstrPrefixo);
    if ipProcessador = nil then
    begin
      pMensagemSonora('MARKETPLACE SEM PROCESSADOR' + #13#10 + #13#10 +
                'O marketplace ' + AstrPrefixo + ' esta habilitado no CFG_EDUNIF mas ' +
                'nao ha processador de etiqueta unificada disponivel para ele nesta ' +
                'versao do autcom.' + #13#10 + #13#10 +
                'Desmarque este marketplace na configuracao CFG_EDUNIF ou atualize o autcom.');
      Exit;
    end;

    strConteudo := TFile.ReadAllText(AstrPathZPLOriginal, TEncoding.ANSI);

    strPathBMP := '';
    if ipProcessador.fPrecisaDanfe then
    begin
      // Sem chave NFe autorizada nao ha como o NFeImpressao renderizar a DANFE.
      // Fluxo legitimo: cliente imprime etiqueta antes da NFe autorizar.
      // Aviso conciso pra nao confundir o operador (a mensagem "DANFE UNIFICADA
      // NAO FOI GERADA" apontaria para o NFeImpressao como culpado - errado).
      if Trim(AstrChaveNFe) = '' then
      begin
        fMensagem('ETIQUETA UNIFICADA',
                  'O pedido nao possui NFe autorizada ainda - imprimindo apenas ' +
                  'a etiqueta do marketplace (sem DANFE unificada).',
                  ['&OK']);
        Exit;
      end;

      // Consulta apenas o comprimento do NFE_LAYUNI - o campo eh um BLOB de
      // layout FastReport (dezenas a centenas de KB) e nao precisamos do
      // conteudo aqui, so saber se esta preenchido. Erro (coluna/tabela
      // inexistente) e vazio sao ambos bloqueantes - avisar em vez de
      // silenciosamente mascarar.
      try
        intTamLayoutUnif := StrToIntDef(
          VarToStr(fCampoTabela('COALESCE(LENGTH(NFE_LAYUNI),0)', 'IMPNFE',
                                ['NFE_CODEMP','NFE_MODELO'], [AstrCodEmp, 'NFE'])),
          0);
      except
        on E: Exception do
        begin
          pMensagemSonora('ERRO AO CONSULTAR LAYOUT UNIFICADO' + #13#10 + #13#10 +
                    'Nao foi possivel consultar a coluna NFE_LAYUNI da tabela IMPNFE ' +
                    'para a empresa ' + AstrCodEmp + ':' + #13#10 + #13#10 +
                    E.Message + #13#10 + #13#10 +
                    'Verifique se a migration que cria a coluna NFE_LAYUNI foi aplicada ' +
                    'no banco de dados deste cliente.');
          Exit;
        end;
      end;

      if intTamLayoutUnif = 0 then
      begin
        pMensagemSonora('LAYOUT UNIFICADO NAO CONFIGURADO' + #13#10 + #13#10 +
                  'O marketplace ' + AstrPrefixo + ' esta habilitado para etiqueta ' +
                  'unificada no CFG_EDUNIF, mas o layout NFE_LAYUNI nao esta ' +
                  'configurado para a empresa ' + AstrCodEmp + '.' + #13#10 + #13#10 +
                  'Configure o layout no modulo NFeImpressao antes de imprimir, ' +
                  'ou desmarque este marketplace na configuracao CFG_EDUNIF.');
        Exit;
      end;

      strDirTemp := TPath.Combine(TPath.GetTempPath, 'autcom');
      if not TDirectory.Exists(strDirTemp) then
        TDirectory.CreateDirectory(strDirTemp);

      strPathBMP := TPath.Combine(strDirTemp, 'etq-unif-' + AstrChaveNFe + '.bmp');

      // Apaga os BMPs desta chave antes de gerar: o principal e as paginas
      // .2.bmp, .3.bmp... que o export do FastReport deixa ao lado. Um BMP
      // antigo faria o FileExists abaixo aceitar a DANFE de outra execucao, e
      // uma .2.bmp antiga faria uma DANFE que cabe parecer que nao coube.
      pApagarBMPsDaChave;

      // Sincrono - pGerarBMP aguarda NFeImpressao.exe terminar.
      TImpressaoDiretaCitel.pGerarBMP(AstrCodEmp, AstrChaveNFe, strDirTemp);

      if not TFile.Exists(strPathBMP) then
      begin
        pMensagemSonora('DANFE UNIFICADA NAO FOI GERADA' + #13#10 + #13#10 +
                  'O modulo NFeImpressao nao produziu o BMP da DANFE para a chave ' +
                  AstrChaveNFe + ' (empresa ' + AstrCodEmp + ').' + #13#10 + #13#10 +
                  'Arquivo esperado: ' + strPathBMP + #13#10 + #13#10 +
                  'Verifique se o NFeImpressao.exe esta acessivel e se o layout ' +
                  'unificado configurado esta valido.');
        Exit;
      end;

      // O NFE_LAYUNI tem altura fixa: o que nao cabe vai para a pagina 2, que
      // a etiqueta nao usa - itens sumiriam da DANFE sem aviso. Existir a
      // .2.bmp e o proprio layout dizendo que nao coube, e vale para qualquer
      // layout que o cliente monte (descricao longa, destinatario que estica).
      // Contar itens nao daria essa garantia; o PreviewPages.Count vive no
      // processo do NFeImpressao. Sai a etiqueta original e quem imprime manda
      // a DANFE separada. Sem mensagem: e desfecho previsto, nao falha.
      if TFile.Exists(ChangeFileExt(strPathBMP, '.2.bmp')) then
      begin
        pApagarBMPsDaChave;
        Exit;
      end;
    end;

    strZPLFinal := ipProcessador.fProcessar(strConteudo, strPathBMP);
    if strZPLFinal = '' then
    begin
      // Causa mais comum: o marketplace trocou a codificacao do bitmap e o
      // processador nao reconhece mais o formato. Sem dizer quais marcadores
      // estao no arquivo, o relato chega ao suporte como "nao unificou" e a
      // investigacao comeca do zero - foi o que aconteceu com a folha A5 da
      // Shopee, que passou de ~DGR/:Z64: para ^GFA sem aviso.
      strBitmapsPresentes := '';
      if Pos('~DGR:', strConteudo) > 0 then
        strBitmapsPresentes := strBitmapsPresentes + '~DGR ';
      if Pos(':Z64:', strConteudo) > 0 then
        strBitmapsPresentes := strBitmapsPresentes + ':Z64: ';
      if Pos('^GFA,', strConteudo) > 0 then
        strBitmapsPresentes := strBitmapsPresentes + '^GFA ';
      if strBitmapsPresentes = '' then
        strBitmapsPresentes := '(nenhum bitmap reconhecido)';

      if strPathBMP = '' then
        strPathBMP := '(nao aplicavel)';

      pMensagemSonora('FALHA NO PROCESSADOR DO MARKETPLACE' + #13#10 + #13#10 +
                'O processador do marketplace ' + AstrPrefixo + ' nao conseguiu ' +
                'unificar a etiqueta (retornou vazio).' + #13#10 + #13#10 +
                'Bitmaps encontrados no ZPL: ' + Trim(strBitmapsPresentes) + #13#10 +
                'Arquivo ZPL: ' + AstrPathZPLOriginal + #13#10 +
                'BMP da DANFE: ' + strPathBMP + #13#10 + #13#10 +
                'Se o marketplace mudou o layout da etiqueta, envie o arquivo ZPL ' +
                'acima para o suporte.');
      Exit;
    end;

    strPathNovo := ChangeFileExt(AstrPathZPLOriginal, '.unificada.txt');
    TFile.WriteAllText(strPathNovo, strZPLFinal, TEncoding.ANSI);
    Result := strPathNovo;
  except
    on E: Exception do
    begin
      // Erro nao tratado - excecao imprevista. Usa pMensagemErro (padrao do
      // projeto, dispara rollback se houver transacao ativa).
      pMensagensErro(E.ClassName + ': ' + E.Message,
                     '[TEtiquetaDespachoUnificada.fGerar]',
                     Format('prefixo=%s empresa=%s chave=%s',
                            [AstrPrefixo, AstrCodEmp, AstrChaveNFe]));
      Result := AstrPathZPLOriginal;
    end;
  end;
end;

class function TEtiquetaDespachoUnificada.fMarketplaceUnificarAtivo(const AstrPrefixo: String): Boolean;
var
  strCfg: String;
begin
  strCfg := VarToStr(fCfgSis('EDUNIF', varString));
  if strCfg = '' then
    Exit(False);
  // Prefixos em VS_arrMarketplaces vem uppercase; normalizar aqui garante
  // matching mesmo se o chamador passar 'mlb_' ou 'MLB_'.
  Result := strCfg.Contains(UpperCase(AstrPrefixo));
end;

end.
